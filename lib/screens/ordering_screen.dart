import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:technical_store/constants.dart';
import 'package:technical_store/providers/basket_provider.dart';
import 'package:technical_store/providers/settings_provider.dart';
import 'package:technical_store/screens/home_screen.dart';

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

TextStyle textStyle = TextStyle(
  color: kTextColor,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);
TextStyle inputTextStyle = TextStyle(color: kTextColor, fontSize: 20);

class _OrderingScreenState extends State<OrderingScreen> {
  String number = '', address = '', name = '', note = '';

  TextStyle textStyle = TextStyle(
    color: kTextColor,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  TextStyle inputTextStyle = TextStyle(color: kTextColor, fontSize: 20);

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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
        title: Text(
          "Оформление заказа",
          style: TextStyle(
            color: kTextColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              child: ListView(
                children: [
                  Text("Номер телефона:", style: textStyle),
                  TextField(
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9+]')),
                    ],
                    controller: TextEditingController(text: number),
                    onChanged: (value) {
                      number = value;
                    },
                    style: inputTextStyle,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Text("Адрес:", style: textStyle),
                  TextField(
                    controller: TextEditingController(text: address),
                    onChanged: (value) {
                      address = value;
                    },
                    style: inputTextStyle,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Text("Имя:", style: textStyle),
                  TextField(
                    controller: TextEditingController(text: name),
                    onChanged: (value) {
                      name = value;
                    },
                    style: inputTextStyle,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Text("Примечание к заказу:", style: textStyle),
                  TextField(
                    maxLines: 3,
                    controller: TextEditingController(text: note),
                    onChanged: (value) {
                      note = value;
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                      ),
                      border: OutlineInputBorder(),
                    ),
                    style: inputTextStyle,
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
              onPressed: () {
                settingsProvider.updateSettings({
                  'number': number,
                  'address': address,
                  'name': name,
                });

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
              child: Text(
                "Оформить Заказ",
                style: TextStyle(color: kTextColor, fontSize: 25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
