import 'package:flutter/material.dart';

abstract class AppTheme {
  static final light = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(color: Colors.blueGrey),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.blueGrey,
    ),
    backgroundColor: const Color.fromARGB(255, 197, 209, 225),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.blueGrey,
      unselectedItemColor: Color.fromARGB(255, 118, 118, 118),
    ),
  );
  static final dark = ThemeData.dark().copyWith(
    cardColor: const Color.fromARGB(255, 57, 57, 57),
    backgroundColor: const Color.fromARGB(255, 47, 47, 47),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.blueGrey,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color.fromARGB(255, 57, 57, 57),
      selectedItemColor: Colors.white,
      unselectedItemColor: Color.fromARGB(255, 118, 118, 118),
    ),
  );
}
