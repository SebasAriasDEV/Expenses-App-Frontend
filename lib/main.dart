import 'package:flutter/material.dart';
import 'package:i_budget_app/providers/accounts_providers.dart';
import 'package:i_budget_app/providers/categories_providers.dart';
import 'package:i_budget_app/providers/overall_provider.dart';
import 'package:i_budget_app/providers/transactions_provider.dart';
import 'package:i_budget_app/ui/screens/bottom_navigation.dart';
import 'package:i_budget_app/utils/themes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

const testingToken =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI2NDBjODM5NjU2YmM5MjE4MTkzNTlkYjciLCJpYXQiOjE2Nzg1NDE3MTgsImV4cCI6MTcwNDQ2MTcxOH0.0LODcCHwAnkq8yE2Ja45t4-Q8YUzzGk1wmVBAm2kQNA';

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
        ChangeNotifierProvider(create: (_) => OverallProvider(), lazy: true),
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
