import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';
import 'package:technical_store/constants.dart';
import 'package:technical_store/providers/home_provider.dart';

class SearchLine extends StatefulWidget {
  const SearchLine({super.key});

  @override
  State<SearchLine> createState() => _SearchLineState();
}

List<String> getSuggestions(data) {
  List<String> list = [];

  for (var item in data) {
    list.add(item['name']);
  }

  return list;
}

class _SearchLineState extends State<SearchLine> {
  var selectedValue = SearchFieldListItem('');
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    String query = homeProvider.searchable;

    return TextField(
      controller: TextEditingController(text: query),
      onChanged: (value) {
        query = value;
        homeProvider.searchable = value;
      },
      onSubmitted: (value) async {
        homeProvider.setStatus(ShowStatus().searching);
        homeProvider.selectedCategory = 0;
        homeProvider.resultOfSearch = await getSearchableResult(value);
        homeProvider.setStatus(ShowStatus().showingResult);
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: kCancelButton,
        hintText: 'Поиск',
      ),
    );
  }
}
