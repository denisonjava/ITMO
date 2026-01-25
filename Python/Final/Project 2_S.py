#подключаем кастомный модуль найденный на просторах интернета для работы с роутерами фирмы TP Link
from tplinkrouterc6u import TplinkC80Router
import json
from pathlib import Path
from loguru import logger

#Указываем переменные для подключения к роутеру IP адрес, пароль в открытом виде и логин:
#т.к. данная модель роутера не поддерживает SSH, мы подлкючаемcя по протоколу HTTP
router_ip = "http://192.168.0.1"
password = "admin"
login = "admin"
file_json = 'network_map.json'
script_dir = Path(__file__).parent
list_client_router = []
directory_ipv4 = {}
dev_list = []
dev_to_save = []

# Создаем логгер
logger.add(script_dir / 'debug.log', format="{time} {level} {message}", level="INFO")

#создаем экземпляр класса router с нашими параметрами, 
#ставим параметр verify_ssl=False чтобы обойти ошибку проверки сертификата SSL
router = TplinkC80Router(router_ip,password,login,verify_ssl=False)

try:
    #авторизовываемся
    router.authorize()
    logger.info("Авторизация пройдена успешно")
    
    #Получаем версию прошивки роутера
    firmware = router.get_firmware()    
    logger.info(f"Версия прошивки роутера получена: {firmware}")

    #Получаем статус сети WAN, записываем параметры в словарь:
    ipv4 = router.get_ipv4_status()
    directory_ipv4["IPv4_WAN"] = ipv4.wan_ipv4_ipaddr
    directory_ipv4["Netmask_WAN"] = ipv4.wan_ipv4_netmask
    directory_ipv4["Gateway_WAN"] = ipv4.wan_ipv4_gateway
    
    #Выводим на экран параметры подключения WAN:
    logger.info(f"Параметры подключения к WAN получены успешно: {directory_ipv4}")

    #Получаем список клиентов выводим на экран и записываем в файл JSON
    clients = router.get_status()
    dev_list = clients.devices 
    for dev in dev_list:
        dev_dict = {"Hostname": dev.hostname,
        "IP": str(dev._ipaddr),
        "MAC": str(dev._macaddr),
        "Status": dev.active
        }
        dev_to_save.append(dev_dict)
        #print(f"Hostname клиента: {dev.hostname} IP адрес: {dev._ipaddr} Статус: {dev.active}")    
    logger.info(f"Список клиентов получен успешно: {dev_to_save}")

    #Записываем список клиентов в файл JSON
    with open(script_dir / file_json, "w") as f:
        json.dump(dev_to_save, f, indent=4)
    logger.info(f"Список клиентов успешно записан в файл: {file_json}")

except Exception as e:
    print(f"Произошла ошибка: {e}")
    logger.error(f"Произошла ошибка: {e}")