import datetime

#Упражнение 2. Определение наибольшего общего делителя

def NOD(a,b):    
    nod = 0
    while a != b:
        if a > b:
            a = a - b
        else:
            b = b - a
    nod = a
    return nod

a = int(input('Задайте первое число: '))
b = int(input('Задайте второе число: '))
nod = NOD(a,b)
print('НОД равен', nod)

#Наибольшее из трех чисел
def max(x,y,z):    
    if x > y and x > z:
        print("Самое большое число: ", x)
        return x
    elif y > x and y > z:
        print("Самое большое число: ", y)
        return y
    elif z > x and z > y:
        print("Самое большое число: ", z)
        return z   

x = int(input("Введите первое число: "))
y = int(input("Введите второе число: "))
z = int(input("Введите третье число: "))

max_int = max(x,y,z)
print("Самое большое число: ", max_int)

#високосный год

def visok(a):
    if (a % 4 == 0) and ( a % 100 != 0):
        return print("Год високосный")
    elif ( a % 400 == 0):
        return print("Год високосный")
    else: 
        return print("Год невисокосный")
current_date = datetime.date.today()
year = current_date.year
visok(year)

