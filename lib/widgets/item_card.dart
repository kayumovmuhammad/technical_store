import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_store/constants.dart';
import 'package:technical_store/models/item_model.dart';
import 'package:technical_store/providers/data_provider.dart';
import 'package:technical_store/screens/add_to_basket_screen.dart';

class ItemCard extends StatefulWidget {
  final ItemModel currentItem;
  final int mainIndex;
  const ItemCard({
    super.key,
    required this.currentItem,
    required this.mainIndex,
  });

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool isHovered = false;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 50), () {
      setState(() {
        isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dataProvider = Provider.of<DataProvider>(context);
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.9,
      duration: Duration(milliseconds: 200),
      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            isHovered = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHovered = false;
          });
        },
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => AddToBasketScreen(
                      currentItem: dataProvider.data[widget.mainIndex],
                    ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(9)),
              border: Border.all(color: Colors.grey, width: 1),
            ),
            child: Padding(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl: widget.currentItem.imageLinks[0],
                        placeholder:
                            (context, url) => Center(
                              child: CircularProgressIndicator(
                                color: theme.primaryColor,
                              ),
                            ),
                      ),
                    ),
                  ),
                  Text(
                    widget.currentItem.name,
                    style: theme.textTheme.headlineMedium,
                  ),
                  Text(
                    "${widget.currentItem.price} с.",
                    style: theme.textTheme.titleSmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
