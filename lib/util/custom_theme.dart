import 'package:flutter/material.dart';

import 'color_set.dart';

class CustomTheme{
  static ThemeData dark = ThemeData(
    scaffoldBackgroundColor: ColorSet.black,
    buttonTheme: const ButtonThemeData(
        buttonColor: ColorSet.transparent,
    ),
    iconTheme: const IconThemeData(color: ColorSet.white),
    inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorSet.white))
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: ColorSet.white),
      bodyLarge: TextStyle(color: ColorSet.white),
      bodySmall: TextStyle(color: ColorSet.white),
    ),
  );
}