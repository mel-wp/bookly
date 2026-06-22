import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF4054C9);
  static const Color background = Color(0xFFF4F4F4);
  static const Color card = Colors.white;

  static const Color success = Color(0xFF2ECC71);
  static const Color warning = Color(0xFFFF8A3D);
  static const Color danger = Color(0xFFE74C3C);

  static const Color textDark = Color(0xFF222222);
  static const Color textLight = Color(0xFF777777);
  static const Color today = Color(0xFF4054C9); //tirar depois talvez
  static const Color border = Color(0xFFE0E0E0);

  static const TextStyle pageTitle = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle title = TextStyle(
    color: textDark,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subtitle = TextStyle(color: textLight, fontSize: 13);

  static const TextStyle body = TextStyle(color: textDark, fontSize: 14);
}
