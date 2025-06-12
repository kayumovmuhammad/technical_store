import json
from fastapi import APIRouter
import requests

from config import ADMIN_CHAT_ID, BOT_TOKEN
from models import Order

sale_router = APIRouter()

@sale_router.post("/sale")
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
    requests.post(send_message_url, data=payload)
    