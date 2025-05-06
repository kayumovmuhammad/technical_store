from pydantic import BaseModel

class Order(BaseModel):
    items: list
    counts: list
    number: str
    address: str
    name: str
    description: str