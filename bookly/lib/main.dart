import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'core/app_theme.dart';

void main() {
  runApp(const BooklyApp());
}

class BooklyApp extends StatelessWidget {
  const BooklyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bookly',
      theme: AppTheme.lightTheme,
      home: const HomePage(),
    );
  }
}
