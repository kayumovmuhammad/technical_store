import 'package:technical_store/models/item_model.dart';

List getCategories(List<ItemModel> items) {
  Set categories = {'Все'};

  for (var item in items) {
    categories.add(item.categody);
  }

  return categories.toList();
}

List getProductsByCategory(List<ItemModel> items) {
  Set categories = {'Все'};

  for (var item in items) {
    categories.add(item.categody);
  }

  List<List> productsByCategory = [];

  for (var item in categories) {
    List products = [];
    for (var ind = 0; ind < items.length; ind++) {
      if (items[ind].categody == item || item == 'Все') {
        products.add(ind);
      }
    }
    productsByCategory.add(products);
  }

  return productsByCategory;
}

int getAxisCount(double width, double height) {
  if (width > height) {
    return 4;
  } else {
    return 2;
  }
}
