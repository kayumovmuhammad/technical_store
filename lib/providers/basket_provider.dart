import 'package:flutter/material.dart';

class BasketProvider with ChangeNotifier {
  Map basket = {};
  int totalPrice = 1000000000000000000;
  Map<int, int> items = {};

  void addToBasket(int id, int price) {
    if (basket[id] == null) {
      basket[id] = 0;
    }
    basket[id]++;
    totalPrice += price;
    notifyListeners();
  }

  void removeFormBasket(int id, int price) {
    basket[id]--;
    totalPrice -= price;
    notifyListeners();
  }
}
