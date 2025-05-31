import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_store/constants.dart';
import 'package:technical_store/models/item_model.dart';
import 'package:technical_store/providers/data_provider.dart';
import 'package:technical_store/providers/home_provider.dart';
import 'package:technical_store/widgets/item_card.dart';

class StaticItemsList extends StatefulWidget {
  final List productsByCategory;
  const StaticItemsList({super.key, required this.productsByCategory});

  @override
  State<StaticItemsList> createState() => _StaticItemsListState();
}

class _StaticItemsListState extends State<StaticItemsList> {
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    final homeProvider = Provider.of<HomeProvider>(context);
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400,
        mainAxisExtent: 400,
        mainAxisSpacing: kDefaultPadding / 2,
        crossAxisSpacing: kDefaultPadding / 2,
        childAspectRatio: 0.75,
      ),
      itemCount: min(
        30,
        widget.productsByCategory[homeProvider.selectedCategory].length,
      ),
      itemBuilder: (context, index) {
        ItemModel currentItem =
            dataProvider.data[widget.productsByCategory[homeProvider
                .selectedCategory][index]];
        return ItemCard(
          currentItem: currentItem,
          mainIndex:
              widget.productsByCategory[homeProvider.selectedCategory][index],
        );
      },
    );
  }
}
