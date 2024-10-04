import 'package:flutter/material.dart';
import 'package:x_rate_app/core/utils/color_constants.dart';

class ThemeManager {
  final darkTheme = ThemeData(
    fontFamily: 'Comfortaa',
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: primaryAppColor,
      surface: scaffoldBackgroundColor,
      brightness: Brightness.dark,
      error: errorColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: scaffoldBackgroundColor,
      surfaceTintColor: transparentColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryAppColor,
      ),
    ),
  );

  final lightTheme = ThemeData(
      //To be implemented later if decided
      );
}
