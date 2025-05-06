import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future<List> initData() async {
  var dio = Dio();
  var response = await dio.get("http://127.0.0.1:8000/info/data");
  var data = response.data as List;

  return data;
}

class DataProvider with ChangeNotifier {
  List data;
  DataProvider({required this.data});
}
