import asyncio
from pydantic import BaseModel
from sqlalchemy.ext.asyncio import create_async_engine, async_sessionmaker
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column
from sqlalchemy import create_engine
from typing import Annotated
from config import DATABASE_URL

engine = create_async_engine(
    DATABASE_URL
)

new_session = async_sessionmaker(engine)

async def get_session():
    async with new_session() as session:
        yield session

class Base(DeclarativeBase):
    pass


# models.py
int_pk = Annotated[int, mapped_column(primary_key=True)]

class ItemsORM(Base):
    __tablename__ = 'items'
    
    id: Mapped[int_pk]
    category: Mapped[str]
    name: Mapped[str]
    description: Mapped[str]
    image_links: Mapped[str]
    price: Mapped[int]
    is_deleted: Mapped[bool] = mapped_column(default=False, server_default='false')

class CategoriesORM(Base):
    __tablename__ = 'categories'
    
    id: Mapped[int_pk]
    category: Mapped[str]
    count: Mapped[int]

    
class ItemSchema(BaseModel):
    category: str
    name: str
    description: str
    image_links: list
    price: int


async def setup_database():
    async with engine.begin() as conn:
        print(DATABASE_URL)
        # await conn.run_sync(lambda sync_conn: CategoriesORM.__table__.drop(sync_conn, checkfirst=True))
        # await conn.run_sync(lambda sync_conn: CategoriesORM.__table__.create(sync_conn, checkfirst=True))
        # await conn.run_sync(Base.metadata.drop_all)
        # await conn.run_sync(Base.metadata.create_all)

# asyncio.run(setup_database())
# setup_database()