import 'package:technical_store/models/item.dart';

List<Item> data = [
  Item(
    id: 1,
    category: "Ноутбуки",
    name: "Ноутбук HP Victus - core i5/16/256",
    description:
        "Процессор: core i5-14 gen\nВидеокарта: RTX 3050\nОперативная память: 16 GB\nНакопитель: 256 GB SSD",
    specifications: {
      "Процессор": "core i5-14 gen",
      "Видеокарта": "RTX 3050",
      "Оперативная память": "16 GB",
      "Накопитель": "256 GB SSD",
    },
    imageLink:
        "https://ssl-product-images.www8-hp.com/digmedialib/prodimg/lowres/c08511248.png",
    price: 8500,
  ),
  Item(
    id: 2,
    category: "Ноутбуки",
    name: "Ноутбук Acer - core i3/4/128",
    specifications: {
      "Процессор": "core i3-11 gen",
      "Оперативная память": "4 GB",
      "Накопитель": "128 GB SSD",
    },
    imageLink:
        "https://bios.tj/image/cache/catalog/acer-aspire-5-1-600x600.jpg",
    price: 3500,
  ),
  Item(
    id: 3,
    category: "Ноутбуки",
    name: "Ноутбук Asus - core i7/32/1TB",
    specifications: {
      "Процессор": "core i7-14 gen",
      "Видеокарта": "RTX 4070",
      "Оперативная память": "32 GB",
      "Накопитель": "1 TB SSD",
    },
    imageLink:
        "https://dlcdnwebimgs.asus.com/gain/91f5e32d-e415-4d8b-a080-ffadc04fceee/",
    price: 3500,
  ),
  Item(
    id: 4,
    name: "Клавиатура Logitech",
    category: "Клавиатуры",
    imageLink: "https://ak.ua/files/resized/products/50747.1800x1800w.jpg",
    price: 250,
  ),
  Item(
    id: 5,
    name: "Мышка HP",
    description: "Игровая мышка беспроводная",
    category: "Мышки",
    imageLink:
        "https://api.technodom.kz/f3/api/v1/images/800/800/myshka_besprovodnaya_usbbt_hp_6cr71aa_black_269836_1.jpg",
    price: 100,
  ),
];
