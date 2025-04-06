import 'package:flutter/material.dart';

class BasketProvider with ChangeNotifier {
  Map basket = {};
  int totalPrice = 0;

  void addToBasket(int id, int price, int counts) {
    if (basket[id] == null) {
      basket[id] = 0;
    }
    basket[id] += counts;
    totalPrice += price * counts;
    notifyListeners();
  }

  void removeFormBasket(int id, int price) {
    basket[id]--;
    totalPrice -= price;
    notifyListeners();
  }

  void clearBasket() {
    totalPrice = 0;
    basket.clear();
    notifyListeners();
  }
}
