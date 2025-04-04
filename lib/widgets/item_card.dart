import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_store/constans.dart';
import 'package:technical_store/providers/basket_provider.dart';
import 'package:technical_store/providers/data_provider.dart';

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
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          useSafeArea: true,
          context: context,
          builder: (context) {
            return AddToBasketScreen(index: widget.mainIndex);
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(9)),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: Padding(
          padding: EdgeInsets.all(kDefauldPaddin / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(widget.currentProduct["imageLink"]),
              ),
              Text(
                widget.currentProduct["name"],
                style: TextStyle(
                  color: kTextColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "${widget.currentProduct["price"]} с.",
                style: TextStyle(
                  color: priceColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddToBasketScreen extends StatefulWidget {
  final int index;
  const AddToBasketScreen({super.key, required this.index});

  @override
  State<AddToBasketScreen> createState() => AddToBasketScreenState();
}

class AddToBasketScreenState extends State<AddToBasketScreen> {
  int counts = 0;
  @override
  Widget build(BuildContext context) {
    final basketProvider = Provider.of<BasketProvider>(context);
    final dataProvider = Provider.of<DataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefauldPaddin / 2),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: () {},
              child: Text(
                "Готово",
                style: TextStyle(color: kTextColor, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: kDefauldPaddin / 2),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: min(
                MediaQuery.of(context).size.height,
                MediaQuery.of(context).size.width,
              ),
              height: min(
                MediaQuery.of(context).size.height,
                MediaQuery.of(context).size.width,
              ),
              child: Image.network(
                dataProvider.data[widget.index]["imageLink"],
              ),
            ),
            Text(
              dataProvider.data[widget.index]["name"],
              style: TextStyle(
                color: kTextColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${dataProvider.data[widget.index]["price"].toString()} с.",
              style: TextStyle(color: priceColor, fontSize: 20),
            ),
            if (dataProvider.data[widget.index]["description"].toString() !=
                "null")
              Text(
                dataProvider.data[widget.index]["description"].toString(),
                style: TextStyle(color: kTextColor, fontSize: 20),
              ),
            SizedBox(height: kDefauldPaddin / 2),
            Text(
              "Количество:",
              style: TextStyle(
                color: kTextColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    iconColor: kTextColor,
                    fixedSize: Size(70, 50),
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: () {
                    if (counts < 20) {
                      setState(() {
                        counts++;
                        basketProvider.addToBasket(
                          dataProvider.data[widget.index]["id"],
                          dataProvider.data[widget.index]["price"],
                        );
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
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: () {
                    if (counts > 0) {
                      setState(() {
                        counts--;
                        basketProvider.removeFormBasket(
                          dataProvider.data[widget.index]["id"],
                          dataProvider.data[widget.index]["price"],
                        );
                      });
                    }
                  },
                  child: Icon(Icons.remove),
                ),
              ],
            ),
            SizedBox(height: kDefauldPaddin / 2),
            Text(
              "Общая цена: ${dataProvider.data[widget.index]["price"] * counts} с.",
              style: TextStyle(
                color: kTextColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
