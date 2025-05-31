import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_store/constants.dart';
import 'package:technical_store/models/item_model.dart';
import 'package:technical_store/providers/data_provider.dart';
import 'package:technical_store/providers/home_provider.dart';
import 'package:technical_store/widgets/item_card.dart';

class StaticItemsList extends StatefulWidget {
  final List products;
  final Function scroolToTop;
  const StaticItemsList({
    super.key,
    required this.products,
    required this.scroolToTop,
  });

  @override
  State<StaticItemsList> createState() => _StaticItemsListState();
}

class _StaticItemsListState extends State<StaticItemsList> {
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    final homeProvider = Provider.of<HomeProvider>(context);
    final int page = homeProvider.page;
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400,
            mainAxisExtent: 400,
            mainAxisSpacing: kDefaultPadding / 2,
            crossAxisSpacing: kDefaultPadding / 2,
            childAspectRatio: 0.75,
          ),
          itemCount:
              (min(widget.products.length, (page + 1) * itemCountInPage) -
                  (page) * itemCountInPage),
          itemBuilder: (context, index) {
            ItemModel currentItem =
                dataProvider.data[widget.products[index +
                    (page) * itemCountInPage]];
            return ItemCard(
              currentItem: currentItem,
              mainIndex: widget.products[index + (page) * itemCountInPage],
            );
          },
        ),
        SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: ,
            children: [
              GestureDetector(
                onTap: () {
                  if (page != 0) {
                    homeProvider.setPage(page - 1);
                    widget.scroolToTop();
                  }
                },
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: page != 0 ? Colors.black : Colors.transparent,
                ),
              ),
              SizedBox(width: 10),
              Text('${page + 1}', style: TextStyle(fontSize: 20)),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  if (widget.products.length > (page + 1) * itemCountInPage) {
                    setState(() {
                      homeProvider.setPage(page + 1);
                      widget.scroolToTop();
                    });
                  }
                },
                child: Icon(
                  Icons.arrow_forward_ios,
                  color:
                      (widget.products.length > (page + 1) * itemCountInPage)
                          ? Colors.black
                          : Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
