from pathlib import Path
from sys import argv

#Упражнение 4 контрольное

script_dir = Path(__file__).parent
dir_name = argv[1]
target_dir = script_dir / dir_name
target_dir.mkdir(exist_ok=True)
for file in script_dir.glob("*.txt"):
        new_path = target_dir / file.name
        file.copy(new_path)