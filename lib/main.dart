import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_store/my_app.dart';
import 'package:technical_store/providers/basket_provider.dart';
import 'package:technical_store/providers/data_provider.dart';

Future<void> main() async {
  List data = await initData();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (create) => DataProvider(data: data)),
        ChangeNotifierProvider(create: (create) => BasketProvider()),
      ],
      child: MyApp(),
    ),
  );
}
