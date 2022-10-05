import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: Colors.white,
    hintColor: Colors.white,
    dividerColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.white,
    canvasColor: Colors.black,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.orange),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.green,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
