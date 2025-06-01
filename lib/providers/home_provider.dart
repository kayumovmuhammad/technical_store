import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:technical_store/constants.dart';
import 'package:technical_store/models/item_model.dart';

Future<List> getSearchableResult(String searchable, int page) async {
  var dio = Dio();
  var response = await dio.get(
    "$ipAddress/info/search?searchable=$searchable&page=$page",
  );

  List data = response.data['data'];
  int pageCount = response.data['pageCount'];
  List<ItemModel> answer = [];

  for (var item in data) {
    answer.add(
      ItemModel(
        id: item["id"],
        name: item["name"],
        category: item["category"],
        description: item["description"],
        imageLinks: item["imageLinks"],
        price: item["price"],
      ),
    );
  }

  return [answer, pageCount];
}

Future<List<ItemModel>> getDataByCategory(String category, int page) async {
  var dio = Dio();
  var response = await dio.get(
    "$ipAddress/info/data/part?category=$category&page=$page",
  );
  List data = response.data;
  List<ItemModel> answer = [];

  for (var item in data) {
    answer.add(
      ItemModel(
        id: item["id"],
        name: item["name"],
        category: item["category"],
        description: item["description"],
        imageLinks: item["imageLinks"],
        price: item["price"],
      ),
    );
  }

  return answer;
}

class ShowStatus {
  String showStatic = "showStatic";
  String showSearch = "showSearch";
  String searching = "searching";
}

class HomeProvider with ChangeNotifier {
  String status = ShowStatus().showStatic, searchable = '', query = '';
  int selectedCategory = 0, page = 0, searchPageCount = 0;
  List<ItemModel> products;

  HomeProvider({required this.products});

  void setStatus(String value) {
    status = value;
    notifyListeners();
  }

  void setSelectedCategory(int value) {
    selectedCategory = value;
    notifyListeners();
  }

  void setPage(int value) {
    page = value;
    notifyListeners();
  }

  void setProducts(List<ItemModel> newValue) {
    products = newValue;
    notifyListeners();
  }
}
