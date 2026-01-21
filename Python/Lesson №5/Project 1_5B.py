#Задание 1

def temp(temps):
    cleared_list = [temp for temp in temps if temp is not None]
    average = sum(cleared_list) / len(cleared_list)
    return print(f"Средняя температура: {average:.2f}")

temprature = [1, 3, None, 13, 34, 23, None, 10, None]
res = temp(temprature)

#Задание 2

def sort(*args):
    minus = sorted([x for x in args if x < 0], reverse=True)
    plus = sorted([x for x in args if x >= 0])

    return minus, plus

list = sort(5, -1, 4, -5, 3, 8, 2, 11, 45, 23, 67, -4, 0, -7)
print(list)

#Задание 3

#Итеративное вычисление степени
def abs(x, n):
    res = 1
    for i in range(n):
        res *= x
    return res

exmpl = abs(2,5)
print(f"2 в 5 степени: {exmpl:.2f}")

#рекурсивное вычисление степени
def abs_rec(y, m):
    if m == 0:
        return 1
    if m < 0:
        return 1 / abs_rec(y, -m)

    return y * abs_rec(y, m - 1)

exmpl = abs_rec(2,7)
print(f"2 в 7 степени: {exmpl:.2f}")