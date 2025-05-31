import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_store/constants.dart';
import 'package:technical_store/models/item_model.dart';
import 'package:technical_store/providers/basket_provider.dart';
import 'package:technical_store/widgets/add_to_basket_widgets/description_widget.dart';
import 'package:technical_store/widgets/add_to_basket_widgets/images_widget.dart';

class AddToBasketScreen extends StatefulWidget {
  final ItemModel currentItem;
  const AddToBasketScreen({super.key, required this.currentItem});

  @override
  State<AddToBasketScreen> createState() => AddToBasketScreenState();
}

class AddToBasketScreenState extends State<AddToBasketScreen> {
  int counts = 0;
  int selectedImage = 0;

  void reduceCounts() {
    if (counts > 0) {
      setState(() {
        counts--;
      });
    }
  }

  void addCounts() {
    if (counts < 20) {
      setState(() {
        counts++;
      });
    }
  }

  int getCounts() {
    return counts;
  }

  int getSelectedImage() {
    return selectedImage;
  }

  void setSelectedImage(int value) {
    setState(() {
      selectedImage = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final basketProvider = Provider.of<BasketProvider>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final imageSide = min(height / 2, width);
    final bool isPhone = (height >= width);
    final theme = Theme.of(context);
    final List<Widget> widgets = [
      ImagesWidget(
        imageSide: imageSide,
        currentItem: widget.currentItem,
        getSelectedImage: getSelectedImage,
        setSelectedImage: setSelectedImage,
      ),
      DescriptionWidget(
        currentItem: widget.currentItem,
        addCounts: addCounts,
        getCounts: getCounts,
        reduceCounts: reduceCounts,
      ),
    ];
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
            children: [
              (isPhone)
                  ? Column(children: widgets)
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widgets,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
