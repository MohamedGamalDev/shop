import 'package:flutter/material.dart';

class AppTheme {
  // Light Colors
  static const Color lightPrimary = Color(0xFFB7935F);
  static const Color white = Color(0xFFF8F8F8);
  static const Color black = Color(0xFF242424);
  static const Color gray = Color(0xFF455A64);

  // Dark Colors
  static const Color darkPrimary = Color(0xFF1B2A6D);
  static const Color gold = Color(0xFFFFD700);

  // Text Styles
  static const TextTheme textTheme = TextTheme(
    headlineSmall: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
    bodyLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
    titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
  );

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    primaryColor: lightPrimary,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: white),
      backgroundColor: lightPrimary,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: black,
        fontSize: 28,
      ),
    ),
    scaffoldBackgroundColor: white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: lightPrimary,
      selectedItemColor: black,
      unselectedItemColor: black.withOpacity(0.6),
    ),
    textTheme: textTheme.apply(bodyColor: black, displayColor: black),
    cardColor: white,
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    primaryColor: darkPrimary,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: darkPrimary),
      backgroundColor: darkPrimary,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: white,
        fontSize: 28,
      ),
    ),
    scaffoldBackgroundColor: darkPrimary,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: darkPrimary,
      selectedItemColor: gold,
      unselectedItemColor: white.withOpacity(0.7),
    ),
    textTheme: textTheme.apply(bodyColor: white, displayColor: white),
    cardColor: gold,
  );
}
