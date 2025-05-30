import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_store/constants.dart';
import 'package:technical_store/models/item_model.dart';
import 'package:technical_store/providers/basket_provider.dart';

class AddToBasketScreen extends StatefulWidget {
  final ItemModel currentItem;
  const AddToBasketScreen({super.key, required this.currentItem});

  @override
  State<AddToBasketScreen> createState() => AddToBasketScreenState();
}

class AddToBasketScreenState extends State<AddToBasketScreen> {
  int counts = 0;

  @override
  Widget build(BuildContext context) {
    final basketProvider = Provider.of<BasketProvider>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final imageSide = min(height / 3, width);
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            color: Colors.black,
            focusColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.close),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                ),
                onPressed: () {
                  basketProvider.addToBasket(
                    widget.currentItem.id,
                    widget.currentItem.price,
                    counts,
                  );
                  Navigator.of(context).pop();
                },
                child: Text("Готово", style: theme.textTheme.bodySmall),
              ),
            ),
          ],
        ),
        body: Container(
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: imageSide,
                height: imageSide,
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
              if (widget.currentItem.description.toString() !=
                  "null")
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
                      if (counts < 20) {
                        setState(() {
                          counts++;
                        });
                      }
                    },
                    child: Icon(Icons.add),
                  ),
                  SizedBox(
                    height: 50,
                    width: 70,
                    child: Center(
                      child: Text(
                        counts.toString(),
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
                      if (counts > 0) {
                        setState(() {
                          counts--;
                        });
                      }
                    },
                    child: Icon(Icons.remove),
                  ),
                ],
              ),
              SizedBox(height: kDefaultPadding / 2),
              Text(
                "Общая цена: ${widget.currentItem.price * counts} с.",
                style: theme.textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
