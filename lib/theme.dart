import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorSchemeSeed: const Color(0xFF00897B),
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
  cardTheme: const CardThemeData(
    elevation: 1,
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
  ),
  navigationBarTheme: NavigationBarThemeData(
    elevation: 2,
    indicatorShape: const StadiumBorder(),
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    height: 68,
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  ),
  fontFamily: 'Cairo',
);
