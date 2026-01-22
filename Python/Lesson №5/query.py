def make_query(**kwargs):
    sorted_keys = sorted(kwargs.keys())
    sorted_query = [f"{key}={kwargs[key]}" for key in sorted_keys]
    return "&".join(sorted_query)

print(make_query(category='books', genre='thriller', author='Stephen_King'))
print(make_query(name='Егор', last_name='Тимохин', age=25, occupation='дизайнер'))