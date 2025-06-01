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

    return TextField(
      controller: TextEditingController(text: homeProvider.query),
      onChanged: (value) {
        homeProvider.query = value;
      },
      onSubmitted: (value) async {
        homeProvider.setStatus(ShowStatus().searching);

        List required = await getSearchableResult(homeProvider.query, 0);

        homeProvider.page = 0;
        homeProvider.products = required[0];
        homeProvider.selectedCategory = inf;
        homeProvider.searchable = homeProvider.query;
        homeProvider.searchPageCount = required[1];
        homeProvider.setStatus(ShowStatus().showSearch);
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
