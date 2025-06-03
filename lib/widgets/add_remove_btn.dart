import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_store/constants.dart';
import 'package:technical_store/models/item_model.dart';
import 'package:technical_store/providers/basket_provider.dart';

class AddRemoveBtn extends StatefulWidget {
  final ItemModel currentItem;
  const AddRemoveBtn({super.key, required this.currentItem});

  @override
  State<AddRemoveBtn> createState() => _AddRemoveBtnState();
}

class _AddRemoveBtnState extends State<AddRemoveBtn> {
  @override
  Widget build(BuildContext context) {
    final basketProvider = Provider.of<BasketProvider>(context);
    final theme = Theme.of(context);
    final currentItem = widget.currentItem;
    int count = 0;
    if (basketProvider.basket[currentItem.id]?.count != null) {
      count = basketProvider.basket[currentItem.id]!.count;
    }

    if (count == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              iconColor: kTextColor,
              fixedSize: Size(185, 50),
              backgroundColor: theme.primaryColor,
            ),
            onPressed: () {
              basketProvider.addToBasket(currentItem);
            },
            child: Text("В корзину", style: theme.textTheme.bodySmall),
          ),
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            iconColor: kTextColor,
            fixedSize: Size(70, 50),
            backgroundColor: theme.primaryColor,
          ),
          onPressed: () {
            if (count < maxItems) {
              basketProvider.addToBasket(currentItem);
            }
          },
          child: Icon(Icons.add),
        ),
        SizedBox(
          height: 50,
          width: 45,
          child: Center(
            child: Text(
              count.toString(),
              style: TextStyle(
                color: kTextColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            iconColor: kTextColor,
            fixedSize: Size(70, 50),
            backgroundColor: theme.primaryColor,
          ),
          onPressed: () {
            if (count > 0) {
              basketProvider.removeFormBasket(currentItem);
            }
          },
          child: Icon(Icons.remove),
        ),
      ],
    );
  }
}
