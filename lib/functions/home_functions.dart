List getCategories(List items) {
  Set categories = {'Все'};

  for (var item in items) {
    categories.add(item["category"]);
  }

  return categories.toList();
}

List getProductsByCategory(List items) {
  Set categories = {'Все'};

  for (var item in items) {
    categories.add(item["category"]);
  }

  List<List> productsByCategory = [];

  for (var item in categories) {
    List products = [];
    for (var ind = 0; ind < items.length; ind++) {
      if (items[ind]['category'] == item || item == 'Все') {
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
