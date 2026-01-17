from turtle import title

fio = str(input("Введи фамилию и имя: ")).title()
print("Фамилия и Имя в титульном регистре: ", fio)
name = fio.split()[1]
surname = fio.split()[0]
login = (surname[:4] + name[:1]).lower()
print(fio,": ", login)