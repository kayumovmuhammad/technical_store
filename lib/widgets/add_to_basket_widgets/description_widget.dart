import 'package:flutter/material.dart';
import 'package:technical_store/constants.dart';
import 'package:technical_store/models/item_model.dart';

class DescriptionWidget extends StatefulWidget {
  final ItemModel currentItem;
  final Function getCounts, addCounts, reduceCounts;
  const DescriptionWidget({
    super.key,
    required this.currentItem,
    required this.addCounts,
    required this.getCounts,
    required this.reduceCounts,
  });

  @override
  State<DescriptionWidget> createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<DescriptionWidget> {
  @override
  Widget build(BuildContext context) {
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
        Text(
          "Количество:",
          style: theme.textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                iconColor: kTextColor,
                fixedSize: Size(70, 50),
                backgroundColor: theme.primaryColor,
              ),
              onPressed: () {
                widget.addCounts();
              },
              child: Icon(Icons.add),
            ),
            SizedBox(
              height: 50,
              width: 70,
              child: Center(
                child: Text(
                  widget.getCounts().toString(),
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
                widget.reduceCounts();
              },
              child: Icon(Icons.remove),
            ),
          ],
        ),
        SizedBox(height: kDefaultPadding / 2),
        Text(
          "Общая цена: ${widget.currentItem.price * widget.getCounts()} с.",
          style: theme.textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
