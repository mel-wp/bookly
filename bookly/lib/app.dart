import 'package:flutter/material.dart';
import 'core/app_theme.dart';

class BooklyApp extends StatelessWidget {
  const BooklyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppTheme.background,
        primaryColor: AppTheme.primary,
      ),
      home: const Scaffold(body: Center(child: Text('Bookly iniciado'))),
    );
  }
}
