from config import BOT_TOKEN
import asyncio

import asyncio
from aiogram import Bot, Dispatcher
from config import BOT_TOKEN
from aiogram import types
from aiogram.filters import CommandStart

dp = Dispatcher()

@dp.message(CommandStart())
async def start_message(message: types.Message):
    print(message.chat.id)
    await message.answer("Привет Jambikjon")

@dp.message()

async def main():
    bot = Bot(token=BOT_TOKEN)

    await dp.start_polling(bot)


if __name__ == "__main__":
    asyncio.run(main())