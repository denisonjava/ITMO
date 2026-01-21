from pathlib import Path
import pandas as pd

file_path = Path('data') / 'orderdata_sample.csv'
df = pd.read_csv(file_path)
df['Total'] = df['Quantity'] * df['Price'] + df['Freight']
#выведем заказы где общая цена больше 1000
total = df['Total'] > 1000
selected_columns = ['Quantity','Price','Total']

print("Выборка заказов с суммой более 1000:")
print(df.loc[total, selected_columns])
output_path = Path('data') / 'orderdata_sample_with_total.csv'
df.to_csv(output_path)