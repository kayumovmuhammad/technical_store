from fastapi import FastAPI
from models import Order
from config import ADMIN_CHAT_ID, BOT_TOKEN
import json
import requests
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

origins = [
    "http://localhost.tiangolo.com",
    "https://localhost.tiangolo.com",
    "http://localhost",
    "http://127.0.0.1",
    "http://127.0.0.1:8000",
    "http://localhost:43329/",
    "http://0.0.0.0:43329/",
    "http://localhost:8080",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/info/data")
async def get_data():
    with open("data.json", encoding='utf-8') as dt:
        data = json.loads(dt.read())
    
    return data

@app.get("/info/find/search")
async def find_for_search(searchable: str):
    indexes = []
    with open("data.json", encoding='utf-8') as dt:
        data = json.loads(dt.read())
    
    for it in data:
        searchable = searchable.lower().replace(" ", "")
        search = (it['name'].lower() + it['description'].lower()).replace(" ", "")
        
        if search.find(searchable) != -1:
            indexes.append(it['id'])
            
    return indexes
    
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
    