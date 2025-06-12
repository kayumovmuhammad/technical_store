from typing import Annotated
from fastapi import FastAPI, Depends
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.ext.asyncio import AsyncSession
from database.db import get_session
from routers.info_router import info_router
from routers.sale_router import sale_router

from routers.testing_router import testing_router

app = FastAPI()

app.include_router(info_router)
app.include_router(sale_router)
app.include_router(testing_router)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)