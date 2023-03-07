import 'package:flutter/material.dart';
import 'package:i_budget_app/providers/accounts_providers.dart';
import 'package:i_budget_app/providers/categories_providers.dart';
import 'package:i_budget_app/providers/transactions_provider.dart';
import 'package:i_budget_app/ui/screens/bottom_navigation.dart';
import 'package:i_budget_app/utils/themes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AccountsProvider(), lazy: true),
        ChangeNotifierProvider(create: (_) => CategoriesProvider(), lazy: true),
        ChangeNotifierProvider(
            create: (_) => TransactionsProvider(), lazy: true),
      ],
      child: MaterialApp(
        title: 'iBudget App',
        debugShowCheckedModeBanner: false,
        theme: CustomThemes.mainTheme,
        home: const BottomNavigation(),
      ),
    );
  }
}
