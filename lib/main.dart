import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:technical_store/my_app.dart';
import 'package:technical_store/providers/basket_provider.dart';
import 'package:technical_store/providers/data_provider.dart';
import 'package:technical_store/providers/settings_provider.dart';

Future<void> main() async {
  await Hive.initFlutter();
  List data = await initData();
  Map settings = await initSettingsData();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (create) => SettingsProvider(settings: settings)),
        ChangeNotifierProvider(create: (create) => DataProvider(data: data)),
        ChangeNotifierProvider(create: (create) => BasketProvider()),
      ],
      child: MyApp(),
    ),
  );
}
