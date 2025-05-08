import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:technical_store/constants.dart';
import 'package:technical_store/providers/basket_provider.dart';
import 'package:technical_store/providers/settings_provider.dart';
import 'package:technical_store/screens/home_screen.dart';
import 'package:dio/dio.dart';

Future<void> sendOrder(
  List items,
  List counts,
  String number,
  String address,
  String name,
  String description,
) async {
  var dio = Dio();
  var data = {
    "items": items,
    "counts": counts,
    "number": number,
    "address": address,
    "name": name,
    "description": description,
  };
  await dio.post("$ipAddress/sale", data: data);
}

class OrderingScreen extends StatefulWidget {
  final String number, address, name;
  const OrderingScreen({
    super.key,
    required this.number,
    required this.address,
    required this.name,
  });

  @override
  State<OrderingScreen> createState() => _OrderingScreenState();
}

class _OrderingScreenState extends State<OrderingScreen> {
  String number = '', address = '', name = '', description = '';

  @override
  void initState() {
    number = widget.number;
    address = widget.address;
    name = widget.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    var basketProvider = Provider.of<BasketProvider>(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
        title: Text("Оформление заказа"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              child: ListView(
                children: [
                  Text("Номер телефона:", style: theme.textTheme.headlineSmall),
                  TextField(
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9+]')),
                    ],
                    controller: TextEditingController(text: number),
                    onChanged: (value) {
                      number = value;
                    },
                    style: theme.textTheme.bodySmall,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Text("Адрес:", style: theme.textTheme.headlineSmall),
                  TextField(
                    controller: TextEditingController(text: address),
                    onChanged: (value) {
                      address = value;
                    },
                    style: theme.textTheme.bodySmall,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kTextColor, width: 1.5),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Text("Имя:", style: theme.textTheme.headlineSmall),
                  TextField(
                    controller: TextEditingController(text: name),
                    onChanged: (value) {
                      name = value;
                    },
                    style: theme.textTheme.bodySmall,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kTextColor, width: 1.5),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Text(
                    "Примечание к заказу:",
                    style: theme.textTheme.headlineSmall,
                  ),
                  TextField(
                    maxLines: 3,
                    controller: TextEditingController(text: description),
                    onChanged: (value) {
                      description = value;
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kTextColor, width: 1.5),
                      ),
                      border: OutlineInputBorder(),
                    ),
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(kDefaultPadding / 2),
            height: 80,
            width: (MediaQuery.of(context).size.width),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: () async {
                settingsProvider.updateSettings({
                  'number': number,
                  'address': address,
                  'name': name,
                });

                // List items = basketProvider.basket.keys.toList();

                await sendOrder(
                  basketProvider.basket.keys.toList(),
                  basketProvider.basket.values.toList(),
                  number,
                  address,
                  name,
                  description,
                );

                basketProvider.clearBasket();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Home();
                    },
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text("Оформить Заказ", style: theme.textTheme.bodyMedium),
            ),
          ),
        ],
      ),
    );
  }
}
