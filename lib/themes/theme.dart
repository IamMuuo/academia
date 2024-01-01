import 'package:flutter/material.dart';

ThemeData lightModeTheme = ThemeData(
  fontFamily: 'Nunito',
  primarySwatch: Colors.blueGrey,
  scaffoldBackgroundColor: Colors.grey[200],
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    showSelectedLabels: true,
    showUnselectedLabels: false,
    elevation: 20,
    selectedItemColor: Colors.blueGrey,
    unselectedItemColor: Colors.blueGrey,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      minimumSize: const Size(327, 60),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.blueGrey,
  ),
  dataTableTheme: DataTableThemeData(
    headingRowColor:
        MaterialStateColor.resolveWith((states) => Colors.blueGrey),
    headingTextStyle: const TextStyle(
      color: Colors.white,
    ),
  ),
);
