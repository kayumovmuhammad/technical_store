import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_store/constants.dart';
import 'package:technical_store/models/item_model.dart';
import 'package:technical_store/providers/basket_provider.dart';
import 'package:technical_store/widgets/add_remove_btn.dart';

class DescriptionWidget extends StatefulWidget {
  final ItemModel currentItem;
  const DescriptionWidget({super.key, required this.currentItem});

  @override
  State<DescriptionWidget> createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<DescriptionWidget> {
  @override
  Widget build(BuildContext context) {
    final basketProvider = Provider.of<BasketProvider>(context);
    final basket = basketProvider.basket;
    final id = widget.currentItem.id;
    int count = 0;
    if (basket[id] != null) {
      count = basket[id]!.count;
    }
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          widget.currentItem.name,
          style: theme.textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
        Text(
          "${widget.currentItem.price.toString()} с.",
          style: theme.textTheme.titleSmall,
          textAlign: TextAlign.center,
        ),
        if (widget.currentItem.description.toString() != "null")
          Text(
            widget.currentItem.description.toString(),
            style: theme.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        SizedBox(height: kDefaultPadding / 2),
        AddRemoveBtn(currentItem: widget.currentItem),
        SizedBox(height: kDefaultPadding / 2),
        Text(
          "Общая цена: ${widget.currentItem.price * count} с.",
          style: theme.textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
