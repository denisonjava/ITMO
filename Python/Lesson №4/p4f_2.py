from pathlib import Path
from sys import argv

#Упражнение 2 контрольное

script_dir = Path(__file__).parent
filename = "text.txt"
file_path = script_dir / filename
with open(file_path, 'r') as f:
        content = f.read() # Читаем весь файл
        print(content)
        letter_count = sum(map(str.isalpha, content))
        word_count = len(content.split())
        lines_count = content.count('\n')
print(f"Количество букв в файле: {letter_count}")
print(f"Количество слов в файле: {word_count}")
print(f"Количество строк в файле: {lines_count}")


