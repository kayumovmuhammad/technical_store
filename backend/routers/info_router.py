import json
from fastapi import APIRouter, Depends
from typing import Annotated
from sqlalchemy.ext.asyncio import AsyncSession
from database.db import ItemsORM, get_session
from sqlalchemy import select, or_, and_, func
from config import ITEM_COUNT_IN_PAGE, MAIN_CATEGORY, NAME_PRIORITY_WEIGHT
from functions.item_to_dict import item_to_dict

info_router = APIRouter(prefix='/info')

SessionDep = Annotated[AsyncSession, Depends(get_session)]

@info_router.get("/categories")
async def get_categories():
    with open("database/categories.json", encoding='utf-8') as file:
        data = json.loads(file.read())
        
    categories = dict()
    
    for category in data.keys():
        categories[category] = (data[category] + ITEM_COUNT_IN_PAGE - 1) // ITEM_COUNT_IN_PAGE
    
    return categories


@info_router.get("/data/part")
async def get_part_of_data(category: str, page: int, session: SessionDep):
    query = select(ItemsORM).where(((ItemsORM.category == category) | (category == MAIN_CATEGORY)) & ItemsORM.is_deleted == False)
    items_response = await session.execute(query)
    items = items_response.scalars().all()
    print(items)
    items = items[page*ITEM_COUNT_IN_PAGE: min(len(items), (page+1)*ITEM_COUNT_IN_PAGE)]
    answer = []
    for item in items:
        answer.append(item_to_dict(item))
        
    print(answer, items) 
    return answer

@info_router.get("/search")
async def find_for_search(searchable: str, page: int, session: SessionDep):
    answer = []
    searchable = searchable.lower()

    similarity_name = func.similarity(ItemsORM.name, searchable)
    similarity_description = func.similarity(ItemsORM.description, searchable)
    
    query = select(ItemsORM).where(
        and_(
            ItemsORM.is_deleted == False,
            or_(
                similarity_name > 0.2,
                similarity_description > 0.2
            )
        )
    ).order_by(func.greatest(similarity_description, similarity_name * NAME_PRIORITY_WEIGHT).desc())
    
    response = await session.execute(query)
    items = response.scalars().all()
    count = len(items)
    items = items[page*ITEM_COUNT_IN_PAGE: min(len(items), (page+1)*ITEM_COUNT_IN_PAGE)]

    for item in items:
        answer.append(item_to_dict(item))

    return {
        'data': answer,
        'pageCount': (count + ITEM_COUNT_IN_PAGE - 1) // ITEM_COUNT_IN_PAGE
    }
