import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:technical_store/constants.dart';
import 'package:technical_store/functions/n_push_and_remove_until.dart';
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
  late TextEditingController nameController,
      addressController,
      numberController;

  @override
  void initState() {
    number = widget.number;
    address = widget.address;
    name = widget.name;
    nameController = TextEditingController(text: name);
    addressController = TextEditingController(text: address);
    numberController = TextEditingController(text: number);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    numberController.dispose();
    super.dispose();
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
                    controller: numberController,
                    onChanged: (value) {
                      number = value;
                    },
                    style: theme.textTheme.bodySmall,
                  ),
                  Text("Адрес:", style: theme.textTheme.headlineSmall),
                  TextField(
                    controller: TextEditingController(text: address),
                    onChanged: (value) {
                      address = value;
                    },
                    style: theme.textTheme.bodySmall,
                  ),
                  Text("Имя:", style: theme.textTheme.headlineSmall),
                  TextField(
                    controller: nameController,
                    onChanged: (value) {
                      name = value;
                    },
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    "Примечание к заказу:",
                    style: theme.textTheme.headlineSmall,
                  ),
                  TextField(
                    maxLines: 3,
                    controller: addressController,
                    onChanged: (value) {
                      description = value;
                    },
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
              style: ElevatedButton.styleFrom(backgroundColor: theme.primaryColor),
              onPressed: () async {
                settingsProvider.updateSettings({
                  'number': number,
                  'address': address,
                  'name': name,
                });

                sendOrder(
                  basketProvider.basket.keys.toList(),
                  basketProvider.basket.values.toList(),
                  number,
                  address,
                  name,
                  description,
                );

                basketProvider.clearBasket();

                nPushAndRemoveUntil(context, Home());
              },
              child: Text("Оформить Заказ", style: theme.textTheme.bodyMedium),
            ),
          ),
        ],
      ),
    );
  }
}
