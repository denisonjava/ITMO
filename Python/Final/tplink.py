from pytplinkrouter import TPLinkRouterFactory

host = "192.168.0.1"
user = "admin"
pwd = "TPDotNet33"

factory = TPLinkRouterFactory(host, user, pwd)
router = factory.get_router()

# Вывести список подключённых устройств
for device in router.scan_devices():
    print(device)

