from typing import Annotated
from fastapi import APIRouter, Depends
from sqlalchemy import select
from pydantic import BaseModel
from config import MAIN_CATEGORY
from database.db import ItemSchema, get_session, setup_database
from sqlalchemy.ext.asyncio import AsyncSession
import json
from functions.item_to_dict import item_to_dict
from database.db import ItemsORM

testing_router = APIRouter()


@testing_router.post('/init')
async def init():
    setup_database()
    
    # with open('database/categories.json', 'r', encoding='utf-8') as file:
    #     categories = json.loads(file.read())
    
    # categories = {MAIN_CATEGORY: 0}
    
    # with open('database/categories.json', 'w', encoding='utf-8') as file:
    #     file.write(json.dumps(categories, ensure_ascii=False, indent=4))
        
    return {"status": "OK"}


SessionDep = Annotated[AsyncSession, Depends(get_session)]


@testing_router.put('/add')
async def add(item: ItemSchema, session: SessionDep):
    add_item = ItemsORM(
        category=item.category,
        name=item.name,
        description=item.description,
        image_links=json.dumps(item.image_links, ensure_ascii=False, indent=4),
        price=item.price,
    )
    
    with open('database/categories.json', 'r', encoding='utf-8') as file:
        categories = json.loads(file.read())
    
    if item.category not in categories:
        categories[item.category] = 0
    categories[item.category] += 1
    categories[MAIN_CATEGORY] += 1
        
    session.add(add_item)
    await session.commit()
    
    with open('database/categories.json', 'w', encoding='utf-8') as file:
        file.write(json.dumps(categories, ensure_ascii=False, indent=4))
        
    return {"status": "OK"}


@testing_router.get("/get_item")
async def get_item(id: int, session: SessionDep):
    query = select(ItemsORM).filter(ItemsORM.id == id)
    response = await session.execute(query)
    answers_class = response.scalars().all()
    answers: list[dict] = []
    for item in answers_class:
        answers.append(item_to_dict(item))
    
    return answers
