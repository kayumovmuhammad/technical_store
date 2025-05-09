import 'package:flutter/material.dart';
import 'package:technical_store/screens/home_screen.dart';
import 'package:technical_store/themes/themes.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: Home(),
      // home: Scaffold(),
    );
  }
}
