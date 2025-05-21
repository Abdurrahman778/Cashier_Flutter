import 'package:flutter/material.dart';
import 'package:cashier_project/cashier_page.dart';
import 'package:cashier_project/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cashier App',
      theme: AppTheme.lightTheme,
      home: const CashierPage(),
    );
  }
}
