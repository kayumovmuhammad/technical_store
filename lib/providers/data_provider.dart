import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:technical_store/constants.dart';

Future<List> initData() async {
  var dio = Dio();
  print(ipAddress);
  var response = await dio.get("$ipAddress/info/data");
  print(ipAddress);
  var data = response.data as List;

  return data;
}

class DataProvider with ChangeNotifier {
  List data;
  DataProvider({required this.data});
}
