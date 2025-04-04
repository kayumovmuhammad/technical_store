import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future<String> getDataFromGists(String id) async {
  var dio = Dio();
  var request = await dio.get("https://api.github.com/gists/$id");
  var content = request.data['files']['main.txt']['content'];

  return content;
}

Future<List> initData() async {
  final String id = "f8d636bc3b50448190656126592b9713";

  String sData = await getDataFromGists(id);

  List data = jsonDecode(sData);

  return data;
}

class DataProvider with ChangeNotifier {
  List data;
  DataProvider({required this.data});
}
