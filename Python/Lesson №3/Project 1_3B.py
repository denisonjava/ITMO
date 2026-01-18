import random
import names

#Задание 1

list = []
i = 0
for i in range(0,20):
    list.append(random.randint(1,100))

print("Случайно сгенерированный список с числами от 1 до 100: ", list)

list2 = []
i = 0
for i in range(0,20):
    if (list[i]>=40):
        list2.append('Max')
    else:
        list2.append('Min')
print("Если число больше или равно 40 ставим - Max, если меньше 40 - Min ", list2)

#Задание 2

name = []
i = 0
for i in range(0,100):
    name.append(names.get_first_name())

print("Список со 100 случайными именами: ", name)

list3 = [] #список под имена где первый символ между А и М
list4 = [] #все остальные имена
for i in range(0,100):
    if ord(name[i][0]) >= 65 and ord(name[i][0]) <= 77:
        list3.append(name[i])
    else:
        list4.append(name[i])
print("Список с именами где первый символ между А и М: ", list3)
print("Список со всеми остальными именами: ", list4)

#Задание 3
enter = True
poem =[]
str1 = ""
i = 0
while enter:
    poem.append(str(input("Введите слова: ")))
    if (len(poem[i]) == 0):
        del poem[-1]
        break
    str1 += str(poem[i][0])
    i = i + 1
print("Список слов: ", poem)
print("Акростих: ", str1)
