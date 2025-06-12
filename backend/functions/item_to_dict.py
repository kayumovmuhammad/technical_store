import json
from database.db import ItemsORM

def item_to_dict(item: ItemsORM):
    return {
        'id': item.id,
        'category': item.category,
        'name': item.name,
        'description': item.description,
        'imageLinks': json.loads(item.image_links),
        'price': item.price,
        'is_deleted': item.is_deleted
    }   