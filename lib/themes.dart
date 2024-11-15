import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Colors.amber;
  static const Color secondaryColor = Colors.grey;
  static const Color backgroundColor = Color(0xFF121212);
  static const Color textColor = Colors.white;
  static const Color textColorButtonPrimary = Colors.black;
  static const Color hintColor = Colors.grey;
  static const Color inputFillColor = Color(0xFF424242);

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      bodyMedium: TextStyle(
        color: textColor,
      ),
      titleMedium: TextStyle(
        color: hintColor,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: textColor),
      hintStyle: const TextStyle(color: hintColor),
      filled: true,
      fillColor: inputFillColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: primaryColor),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: textColorButtonPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: secondaryColor,
        side: const BorderSide(color: secondaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    iconTheme: const IconThemeData(
      color: hintColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      elevation: 4,
      iconTheme: IconThemeData(color: textColor),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    expansionTileTheme: const ExpansionTileThemeData(
      iconColor: primaryColor,
      collapsedIconColor: primaryColor,
      backgroundColor: inputFillColor,
      childrenPadding: EdgeInsets.all(16),
      tilePadding: EdgeInsets.symmetric(horizontal: 8.0),
    ),
    listTileTheme: const ListTileThemeData(iconColor: primaryColor),
  );
}
