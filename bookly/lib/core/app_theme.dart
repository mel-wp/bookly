import 'package:flutter/material.dart';

class AppTheme {
  static const Color textLight = Color(0xFF8A8A8A);

  static const Color subtitle = Color(0xFF6B6B6B);

  static const Color pageTitle = Color(0xFF2D2D2D);
  static const Color background = Color(0xFFF8F5F0);

  static const Color primary = Color(0xFF5B3E31);

  static const Color secondary = Color(0xFFD4A373);

  static const Color success = Color(0xFF4CAF50);

  static const Color warning = Color(0xFFFF9800);

  static const Color danger = Color(0xFFE53935);

  static const Color card = Colors.white;

  static const Color border = Color(0xFFE5DDD5);

  static const Color title = Color(0xFF2D2D2D);

  static const Color today = Color(0xFF795548);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: background,
    colorScheme: ColorScheme.fromSeed(seedColor: primary),
  );
}
