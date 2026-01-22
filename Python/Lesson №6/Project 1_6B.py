import os
from pathlib import Path

script_dir = Path(__file__).parent
directory = script_dir / 'data'
output_file_path = os.path.join(directory, 'output.txt' )
log_file_path = os.path.join(directory, 'log.txt' )

def csv_files(file_list):
    with open(output_file_path, 'w', encoding='utf-8') as outfile, \
         open(log_file_path, 'a', encoding='utf-8') as log:
        
        for file_name in file_list:
            try:               
                with open(directory / file_name, 'r', encoding='utf-8') as infile:
                    content = infile.read()
                    outfile.write(f"--- Содержимое файла: {file_name} ---\n")
                    outfile.write(content)
                    outfile.write("\n")               
              
                log.write(f"УСПЕХ: Файл '{file_name}' скопирован в файл '{output_file_path}'.\n")
                
            except FileNotFoundError:               
                log.write(f"ОШИБКА: Файл '{file_name}' не найден в директории '{directory}'.\n")

file_list = ['cars.csv','delivery.csv','fruits.csv','drinks.csv','names.csv']
csv_files(file_list)