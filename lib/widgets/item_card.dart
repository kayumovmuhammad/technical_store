import 'package:flutter/material.dart';
import 'package:technical_store/constants.dart';
import 'package:technical_store/screens/add_to_basket_screen.dart';

class ItemCard extends StatefulWidget {
  final Map currentProduct;
  final int mainIndex;
  const ItemCard({
    super.key,
    required this.currentProduct,
    required this.mainIndex,
  });

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddToBasketScreen(index: widget.mainIndex),
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
                child: Image.network(widget.currentProduct["imageLink"]),
              ),
              Text(
                widget.currentProduct["name"],
                style: theme.textTheme.headlineMedium,
              ),
              Text(
                "${widget.currentProduct["price"]} с.",
                style: theme.textTheme.titleSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
