import json
from config import BOT_TOKEN
import asyncio

import asyncio
from aiogram import Bot, Dispatcher, F
from aiogram.fsm.state import State, StatesGroup
from aiogram.fsm.context import FSMContext
from aiogram import types
from aiogram.filters import CommandStart, Command
from aiogram.types import InlineKeyboardButton, InlineKeyboardMarkup
from aiogram.utils.keyboard import InlineKeyboardBuilder
import asyncio

bot = Bot(token=BOT_TOKEN)
dp = Dispatcher()

class Item(StatesGroup):
    name = State()
    category = State()
    description = State()
    imageLink = State()
    price = State()
    price2 = State()

@dp.message(CommandStart())
async def start_message(message: types.Message):
    # print(message.chat.id)
    await message.answer("Привет")
    
@dp.message(Command("new_item"))
async def new_item(message: types.Message, state: FSMContext):
    await message.answer("Введите имя товара:")
    await state.set_state(Item.name)
    
@dp.message(Command("cancel"))
async def new_item(message: types.Message, state: FSMContext):
    await message.answer("Остановлено")
    await state.clear()

@dp.message(Item.name)
async def get_name(message: types.Message, state: FSMContext):
    await state.update_data(name=message.text)
    await message.answer("Введите категорию товара:")
    await state.set_state(Item.category)
    
@dp.message(Item.category)
async def get_name(message: types.Message, state: FSMContext):
    await state.update_data(category=message.text)
    await message.answer("Введите описание товара:")
    await state.set_state(Item.description)
    
@dp.message(Item.description)
async def get_name(message: types.Message, state: FSMContext):
    await state.update_data(description=message.text)
    await message.answer("Введите ссылку на изображение товара:")
    await state.set_state(Item.imageLink)

@dp.message(Item.imageLink)
async def get_name(message: types.Message, state: FSMContext):
    await state.update_data(imageLink=message.text)
    await message.answer("Введите сумму товара:")
    await state.set_state(Item.price)
    
async def confirmation(state, message):
    await state.update_data(price=message.text)
    data = await state.get_data()
    keyboardBuilder = InlineKeyboardBuilder()
    keyboardBuilder.row(
        InlineKeyboardButton(text='OK', callback_data='ok_btn'),
        InlineKeyboardButton(text='Отмена', callback_data='cancel_btn')
    )
    await message.answer(f'Проверьте что всё данные введены правильно:\nИмя: {data['name']}\nКатегория: {data['category']}\nОписание: {data['description']}\nСсылка на изображение: {data['imageLink']}\nЦена: {data['price']}\n', reply_markup=keyboardBuilder.as_markup())
    
@dp.message(Item.price)
async def get_name(message: types.Message, state: FSMContext):
    if message.text.isdigit():
        await confirmation(state, message)
    else:
        await message.answer("Неправильное число")
        await state.set_state(Item.price2)
         
@dp.message(Item.price2)
async def get_name(message: types.Message, state: FSMContext):
    if message.text.isdigit():
        await confirmation(state, message)
    else:
        await message.answer("Неправильное число")
        await state.set_state(Item.price)
        
    
@dp.callback_query(F.data == 'ok_btn')
async def ok(callback: types.CallbackQuery, state: FSMContext):
    data = await state.get_data()
    data['price'] = int(data['price'])
    
    with open("data.json", encoding='utf-8') as dt:
        dataFromJson = list(json.loads(dt.read()))
    
    data['id'] = len(dataFromJson)
    
    dataFromJson.append(data)
    
    with open("data.json", 'w', encoding='utf-8') as dt:
        dt.write(json.dumps(dataFromJson, ensure_ascii=False, indent=4))
    
    await bot.delete_message(callback.message.chat.id, callback.message.message_id)
    await callback.message.answer("Добавлено!")
    await callback.answer()
    await state.clear()
    
@dp.callback_query(F.data == 'cancel_btn')
async def cancel_btn(callback: types.CallbackQuery, state: FSMContext):
    await bot.delete_message(callback.message.chat.id, callback.message.message_id)
    await callback.message.answer("Не добавлено(")
    await callback.answer()
    await state.clear()

@dp.message(Command("delete_item"))
async def delete_item(message: types.Message):
    keyboardBuilder = InlineKeyboardBuilder()
    with open("data.json", encoding='utf-8') as dt:
        dataFromJson = list(json.loads(dt.read()))
        
    for it in dataFromJson:
        keyboardBuilder.row(
            InlineKeyboardButton(text=it['name'], callback_data=f'del_{it['id']}')
        )
    
    await message.answer('Выберите товар для удаления:', reply_markup=keyboardBuilder.as_markup())
    
@dp.callback_query(F.data.startswith('del_'))
async def delete_item_call(callback: types.CallbackQuery):
    await bot.delete_message(callback.message.chat.id, callback.message.message_id)
    id = int(callback.data[4:])
    
    print(id)
    
    with open("data.json", encoding='utf-8') as dt:
        dataFromJson = list(json.loads(dt.read()))
        
    dataFromJson = dataFromJson[0: id] + dataFromJson[id+1:]
    
    for i in range(len(dataFromJson)):
        dataFromJson[i]['id'] = i
        
    with open("data.json", 'w', encoding='utf-8') as dt:
        dt.write(json.dumps(dataFromJson, ensure_ascii=False, indent=4))
    
    await callback.message.answer('Успешно удалено')
    await callback.answer()

async def main():

    await dp.start_polling(bot)


if __name__ == "__main__":
    asyncio.run(main())