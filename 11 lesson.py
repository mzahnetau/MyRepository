# Напишите функцию, которая принимает JSON-строку и выводит данные в виде словаря Python."""
import json
ourStr = '{"DOB": "1975", "city": "Warsaw", "name": "Anatol"}'
result = json.loads(ourStr)
print(result)

# Напишите код, который загружает данные из Excel-файла, подсчитывает количество строк и выводит результат.
import pandas as pd

data = pd.read_excel('our_Excel_file.xlsx', header=None) #нашел эту штуку, потому что по умолчанию считает все без первой строки
rows = len(data)
print(f'The number of lines in my file is {rows}')

# Напишите функцию, которая загружает данные из API и обрабатывает их, выводя только
#нужные поля. (по аналогии с примером, который мы смотрели на уроке)

# тут я решил развлечься и нашел API с рандомными картинками собак :)
import requests

response = requests.get('https://dog.ceo/api/breeds/image/random')

if response.status_code == 200:
    data = response.json()
    print(data['message'])

# а для этого решения я взял другой api с публичными данными из США

import requests

response = requests.get('https://datausa.io/api/data?drilldowns=Nation&measures=Population')

if response.status_code == 200:
    data = response.json()
    ourData = data['data']

    for i in ourData: # вытаскиваю данные за 2020-2022 года
        if 2020 <= int(i['Year']) <= 2022:
            print(f"Year: {i['Year']}, Population: {i['Population']}")

# Напишите программу, которая загружает данные из нескольких Excel файлов, объединяет их и сохраняет в новый файл.

import pandas as pd

doc1 = pd.read_excel('our_Excel_file.xlsx')
doc2 = pd.read_excel('our_Excel_file2.xlsx')

newData = pd.concat([doc1, doc2], ignore_index=True) # сбросил индексацию

newData.to_excel('newdata.xlsx', index=False) # не добавил таким образом колонку с индексами в новом файле


#Напишите код, который загружает данные из API, выполняет предварительную обработку
#(например, фильтрацию) и сохраняет результат в Excel-файл.

# для этой задачи я использовал другой api, который предоставляет информацию о рандомных юзерах из разных стран
import requests
import pandas as pd

response = requests.get("https://randomuser.me/api/?results=20")
data = response.json()

users = data['results']
processed_data = []

for user in users:

    if user['location']['country'] == 'United States': # возьмем только юзеров из США
        processed_data.append({
            'Name': f"{user['name']['first']} {user['name']['last']}",
            'City': user['location']['city'],
            'Country': user['location']['country'],
        })

if processed_data:
    df = pd.DataFrame(processed_data)
    df.to_excel('random_users_us.xlsx', index=False)

else:
    print("No users from the USA")
