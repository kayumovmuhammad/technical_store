import 'package:flutter/material.dart';
import 'package:technical_store/models/item_model.dart';

class BasketItemModel {
  int count;
  ItemModel item;

  BasketItemModel({required this.item, required this.count});
}

class BasketProvider with ChangeNotifier {
  Map<int, BasketItemModel> basket = {};
  int totalPrice = 0;

  void addToBasket(ItemModel item) {
    if (basket[item.id] == null) {
      basket[item.id] = BasketItemModel(item: item, count: 0);
    }
    basket[item.id]?.count++;
    totalPrice += item.price;
    notifyListeners();
  }

  void removeFormBasket(ItemModel item) {
    basket[item.id]?.count--;
    totalPrice -= item.price;
    notifyListeners();
  }

  void clearBasket() {
    totalPrice = 0;
    basket.clear();
    notifyListeners();
  }
}
