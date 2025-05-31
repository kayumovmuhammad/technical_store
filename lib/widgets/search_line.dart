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
        homeProvider.page = 0;
        homeProvider.setStatus(ShowStatus().searching);
        homeProvider.selectedCategory = 0;
        homeProvider.resultOfSearch = await getSearchableResult(value);
        if (homeProvider.resultOfSearch.isNotEmpty) {
          homeProvider.setStatus(ShowStatus().showingResult);
        } else {
          homeProvider.setStatus(ShowStatus().nothingToShow);
        }
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(width: 0.5),
        ),
        filled: true,
        fillColor: kCancelButton,
        hintText: 'Поиск',
      ),
    );
  }
}
