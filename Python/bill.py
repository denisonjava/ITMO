bill = float(input("Сумма заказа в ресторане: "))
tax = ((bill / 100) * 5)
print("Сумма налога 5%: {:.2f}".format(tax))
tips = ((bill / 100) * 10)
print("Сумма чаевых 10%: {:.2f}".format(tips))
total = bill + tax + tips
print("Итого к оплате: {:.2f}".format(total))