import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:technical_store/constants.dart';
import 'package:technical_store/models/item_model.dart';

Future<List<ItemModel>> initData() async {
  var dio = Dio();
  var response = await dio.get("$ipAddress/info/data");
  var jsonData = response.data as List;

  List<ItemModel> data = [];

  for (var item in jsonData) {
    ItemModel it = ItemModel(
      id: item["id"],
      name: item["name"],
      categody: item["categody"],
      description: item["description"],
      imageLink: item["imageLink"],
      price: item["price"],
    );
    data.add(it);
  }

  return data;
}

class DataProvider with ChangeNotifier {
  List<ItemModel> data;
  DataProvider({required this.data});
}
