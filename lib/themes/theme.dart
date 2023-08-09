import 'package:flutter/material.dart';

ThemeData lightModeTheme = ThemeData(
  fontFamily: 'Nunito',
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.blue[700],
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    showSelectedLabels: true,
    showUnselectedLabels: false,
    elevation: 20,
    selectedItemColor: Colors.blue[800],
    unselectedItemColor: Colors.blue[100],
  ),
);
