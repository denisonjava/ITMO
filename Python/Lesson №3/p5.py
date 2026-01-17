#Контрольное задание 4.1

i = 0 # счетчик итераций цикла
sum = 0 # сумма за день
days = ['понедельник','вторник','среду','четверг','пятницу','субботу','восресенье']
sales = []
for i in range(0,7):
    sum = int(input(f"Введите сумму продаж за '{days[i]}': "))
    sales.append(sum)
print(sales)

total=0 # сумма продаж за неделю
for j in range(0,7):
    total += sales[j]
print("Объем продаж за неделю: ", total)
sorted = sorted(sales)

for k in range(0,7):
    print(sorted[k])