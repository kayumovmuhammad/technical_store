import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:technical_store/constants.dart';

Future<List> getSearchableResult(String searchable) async {
  var dio = Dio();
  var response = await dio.get(
    "$ipAddress/info/find/search?searchable=$searchable",
  );
  var data = response.data as List;

  return data;
}

class ShowStatus {
  String showStatic = "showStatic";
  String searching = "searching";
  String showingResult = "showingResult";
  String nothingToShow = "nothingToShow";
}

class HomeProvider with ChangeNotifier {
  String status = "showStatic";
  int selectedCategory = 0;
  int page = 0;
  List resultOfSearch = [];
  String searchable = '';

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
}
