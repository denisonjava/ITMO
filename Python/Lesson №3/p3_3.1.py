x = int(input("Введите первое число: "))
y = int(input("Введите второе число: "))
z = int(input("Введите третье число: "))
if x > y and x > z:
    print("Самое большое число: ", x)
elif y > x and y > z:
    print("Самое большое число: ", y)
elif z > x and z > y:
    print("Самое большое число: ", z)
