#работа со списками

list1 = [82,8,23,97,92,44,17,39,11,12]
print("Исходный список: ", list1)
list1[-1] = 10
print("Последний элемент заменен на 10: ", list1)
list1.append(15)
print("В конец списка добавлено число 15: ", list1)
list1.insert(1,28)
print("Между 1 и 2 индексом вставлено число 28: ", list1)
del list1[0]
print("Удален первый элемент списка: ", list1)
del list1[-1]
print("Удален последний элемент списка", list1)
print(list1)
print("Итоговый вариант списка: ", list1)
list1.sort(reverse=True)
print("Список после сортировки по убыванию: ", list1)

list2 = [3,5,6,2,33,6,11]
lis = sorted(list2)
print("Исходный список: ", list2)
print("Список после сортировки: ", lis)

#работа с кортежами

seq = (2,8,23,97,92,44,17,39,11,12)
print("Исходный кортеж: ", seq)
print("Результат операции count(8): ", seq.count(8))
print("Результат операции index(44): ", seq.index(44))
listseq = list(seq)
print("Преобразование кортежа к списку: ", listseq)
print("Проверяем тип преобразованного объекта", type(listseq))
listseq.append(99)
print("В конец списка добавлено число 99: ", listseq)
del listseq[0]
print("Удален первый элемент списка: ", listseq)

#работа со словарями

D = {'food': 'Apple', 'quantity': 4, 'color': 'Red'}
print("Исходный словарь: ", D)
print("D['food']: ", D['food'])
D['quantity'] += 10
print("D['quantity'] += 10: ", D['quantity'])
dp = {}
dp['name'] = input("Введите ваше имя: ")
dp['surname'] = input("Введите вашу фамилию: ")
print("Итговый словарь: ", dp)

#работа с вложенностью

rec = {'name': {'firstname': 'Bob', 'lastname': 'Smith'},
        'job': ['dev', 'mgr'],
        'age': 25}
print("Полное ФИО: ", rec['name']['firstname']," ", rec['name']['lastname'])
print("Имя: ", rec['name']['firstname'])
print("Список должностей: ", rec['job'])
rec['job'].append('janitor')
print("Список должностей после изменений: ", rec['job'])
print("Полное ФИО: ", rec['name']['firstname']," ", rec['name']['lastname'],"\n",
      "Должность: ", rec['job'][0],"\n",
      "Возраст: ",rec['age'] )