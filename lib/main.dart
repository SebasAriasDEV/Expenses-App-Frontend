import 'package:flutter/material.dart';
import 'package:i_budget_app/ui/screens/home_screen.dart';
import 'package:i_budget_app/utils/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iBudget App',
      debugShowCheckedModeBanner: false,
      theme: CustomThemes.mainTheme,
      home: const HomeScreen(),
    );
  }
}
