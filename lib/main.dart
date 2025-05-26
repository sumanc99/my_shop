import 'package:flutter/material.dart';
import 'package:my_shop/screens/home_screen.dart';
import 'package:my_shop/theme/app_theme.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Shop',
      theme: AppTheme.lightTheme,
      home: const MyHomePage(title: 'My Shop'),
      debugShowCheckedModeBanner: false, // Hides the "DEBUG" banner
    );
  }
}

