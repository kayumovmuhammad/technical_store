import 'package:flutter/material.dart';
import 'package:technical_store/constants.dart';

ThemeData lightTheme = ThemeData(
  drawerTheme: DrawerThemeData(backgroundColor: Colors.white),
  primaryColor: Colors.orange,
  dialogTheme: DialogThemeData(
    backgroundColor: Colors.white,
  ),
  focusColor: Colors.white,
  iconTheme: IconThemeData(color: Colors.black),
  cardTheme: CardThemeData(
    color: Colors.white
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
  ),
  textTheme: TextTheme(
    titleMedium: TextStyle(
      color: kTextColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
      color: kTextColor,
      fontSize: 17,
      fontWeight: FontWeight.w600,
    ),
    headlineLarge: TextStyle(
      color: kTextColor,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(color: priceColor, fontSize: 20),
    bodySmall: TextStyle(color: kTextColor, fontSize: 20),
    headlineSmall: TextStyle(
      color: kTextColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(color: kTextColor, fontSize: 25),
  ),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kTextColor, width: 1.5),
    ),
    border: OutlineInputBorder(),
  ),
);
