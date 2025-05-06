from fastapi import FastAPI
from models import Order
from config import ADMIN_CHAT_ID, BOT_TOKEN
import json
import requests

app = FastAPI()

@app.get("/info/data")
async def get_data():
    with open("data.json") as dt:
        data = json.loads(dt.read())
    
    return data

@app.post("/sale")
async def sale_items(order: Order):
    with open("data.json") as dt:
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
    