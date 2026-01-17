import datetime
import calendar

current_date = datetime.date.today()
year = current_date.year                # проверяемая переменная
#year = 2024 #для проверки високостного года

#Задание 1. Проверка с условиями if-else

print("проверяемй год", year)
if (year % 4 == 0) and ( year % 100 != 0) or ( year % 400 == 0):
    print("Год високосный")
else:
    print("Год невисокосный")

#Задание 2. Проверка с дополнительными условиями elif

if (year % 4 == 0) and ( year % 100 != 0):
    print("Год високосный")
elif ( year % 400 == 0):
    print("Год високосный")
else: 
    print("Год невисокосный")

#Задание 3. Проверка с помощью логических операторов в одну строку if

if (year % 4 == 0) and ( year % 100 != 0) or ( year % 400 == 0):
    print("Год високосный")

#Задание 4. Проверка с применением специальной функции модуля calendar

if calendar.isleap(year):
    print("Год високосный")
else:
    print("Год невисокосный")

