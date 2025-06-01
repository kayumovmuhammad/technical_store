from fastapi import FastAPI
from pydantic import BaseModel
from models import Order
from config import BOT_TOKEN, ADMIN_CHAT_ID, ITEM_COUNT_IN_PAGE, MAIN_CATEGORY
import json
import requests
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/info/data")
async def get_data():
    with open("data.json", encoding='utf-8') as dt:
        data = json.loads(dt.read())
    
    return data

@app.get("/info/categories")
async def get_categories():
    with open("data.json", encoding='utf-8') as dt:
        data = json.loads(dt.read())

    categories = {
        MAIN_CATEGORY: len(data)
    }

    for item in data:
        category = item['category']

        if (category not in categories):
            categories[category] = 0

        categories[category] += 1

    for category in categories.keys():
        category_count = categories[category]
        categories[category] = (category_count + ITEM_COUNT_IN_PAGE - 1) // ITEM_COUNT_IN_PAGE

    return categories


@app.get("/info/data/part")
async def get_part_of_data(category: str, page: int):
    answer: list = []
    count = 0
    with open("data.json", encoding='utf-8') as dt:
        data = json.loads(dt.read())

    for item in data:
        if (item['category'] == category or category == MAIN_CATEGORY):
            count += 1
            if (count > ITEM_COUNT_IN_PAGE * page and count <= ITEM_COUNT_IN_PAGE * (page+1)):
                answer.append(item)

            if count > ITEM_COUNT_IN_PAGE * (page+1):
                break

    return answer

@app.get("/info/search")
async def find_for_search(searchable: str, page: int):
    answer = []
    count = 0
    with open("data.json", encoding='utf-8') as dt:
        data = json.loads(dt.read())
    
    for item in data:
        searchable = searchable.lower().replace(" ", "")
        search = (item['name'].lower() + item['description'].lower()).replace(" ", "")
        
        if search.find(searchable) != -1:
            count += 1
            if (count > ITEM_COUNT_IN_PAGE * page and count <= ITEM_COUNT_IN_PAGE * (page+1)):
                answer.append(item)

    return {
        'data': answer,
        'pageCount': (count + ITEM_COUNT_IN_PAGE - 1) // ITEM_COUNT_IN_PAGE
    }
    
@app.post("/sale")
async def sale_items(order: Order):
    with open("data.json", encoding='utf-8') as dt:
        data = json.loads(dt.read())
        
    message = f"Имя: {order.name} | Номер: {order.number} | адрес: \"{order.address}\":\n"
    
    for i in range(len(order.items)):
        id = order.items[i]
        count = order.counts[i]
        message += f"{data[id]['name']} | цена: {data[id]['price']} | кол: {count}\n"
    message += f"Описание: {order.description}"
    send_message_url = f'https://api.telegram.org/bot{BOT_TOKEN}/sendMessage'
    payload = {
	    'chat_id': ADMIN_CHAT_ID,
	    'text': message
	}
    response = requests.post(send_message_url, data=payload)
    return response.json()
    