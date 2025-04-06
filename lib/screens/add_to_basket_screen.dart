import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_store/constants.dart';
import 'package:technical_store/providers/basket_provider.dart';
import 'package:technical_store/providers/data_provider.dart';

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
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: () {
                  basketProvider.addToBasket(
                    dataProvider.data[widget.index]['id'],
                    dataProvider.data[widget.index]['price'],
                    counts,
                  );
                  Navigator.of(context).pop();
                },
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
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
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
                textAlign: TextAlign.center,
              ),
              Text(
                "${dataProvider.data[widget.index]["price"].toString()} с.",
                style: TextStyle(color: priceColor, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              if (dataProvider.data[widget.index]["description"].toString() !=
                  "null")
                Text(
                  dataProvider.data[widget.index]["description"].toString(),
                  style: TextStyle(color: kTextColor, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              SizedBox(height: kDefaultPadding / 2),
              Text(
                "Количество:",
                style: TextStyle(
                  color: kTextColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                        });
                      }
                    },
                    child: Icon(Icons.remove),
                  ),
                ],
              ),
              SizedBox(height: kDefaultPadding / 2),
              Text(
                "Общая цена: ${dataProvider.data[widget.index]["price"] * counts} с.",
                style: TextStyle(
                  color: kTextColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
