import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:technical_store/constants.dart';
import 'package:technical_store/models/item_model.dart';
import 'package:technical_store/screens/add_to_basket_screen.dart';
import 'package:technical_store/widgets/add_remove_btn.dart';

class ItemCard extends StatefulWidget {
  final ItemModel currentItem;
  const ItemCard({super.key, required this.currentItem});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool isHovered = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
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
                  (context) =>
                      AddToBasketScreen(currentItem: widget.currentItem),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(
              color: (isHovered ? Colors.black : Colors.grey),
              width: 1,
            ),
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
                SizedBox(height: kDefaultPadding / 2),
                AddRemoveBtn(currentItem: widget.currentItem),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
