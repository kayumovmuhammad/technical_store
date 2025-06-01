import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:technical_store/constants.dart';

Future<Map> initCategories() async {
  var dio = Dio();
  var response = await dio.get("$ipAddress/info/categories");
  Map categories = response.data;
  return categories;
}

class DataProvider with ChangeNotifier {
  Map categories;
  DataProvider({required this.categories});
}
