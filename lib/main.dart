import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:technical_store/constants.dart';
import 'package:technical_store/models/item_model.dart';
import 'package:technical_store/my_app.dart';
import 'package:technical_store/providers/basket_provider.dart';
import 'package:technical_store/providers/data_provider.dart';
import 'package:technical_store/providers/home_provider.dart';
import 'package:technical_store/providers/settings_provider.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Map categories = await initCategories();
  List<ItemModel> products = await getDataByCategory(mainCategory, 0);
  Map settings = await initSettingsData();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (create) => HomeProvider(products: products),
        ),
        ChangeNotifierProvider(
          create: (create) => SettingsProvider(settings: settings),
        ),
        ChangeNotifierProvider(
          create: (create) => DataProvider(categories: categories),
        ),
        ChangeNotifierProvider(create: (create) => BasketProvider()),
      ],
      child: MyApp(),
    ),
  );
}
