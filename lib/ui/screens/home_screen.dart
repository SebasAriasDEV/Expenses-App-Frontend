// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:i_budget_app/providers/accounts_providers.dart';
import 'package:i_budget_app/providers/categories_providers.dart';
import 'package:i_budget_app/providers/overall_provider.dart';
import 'package:i_budget_app/providers/transactions_provider.dart';
import 'package:i_budget_app/ui/components/categories/category_card.dart';
import 'package:i_budget_app/utils/colors.dart';
import 'package:i_budget_app/utils/text_themes.dart';
import 'package:i_budget_app/utils/themes.dart';
import 'package:provider/provider.dart';

import '../components/accounts/account_cards_list.dart';
import '../components/categories/new_category_button.dart';
import '../components/change_currency_dialog.dart';
import '../components/home_summary_card.dart';
import '../components/month_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AccountsProvider _accountsProvider;
  late CategoriesProvider _categoriesProvider;
  late TransactionsProvider _transactionsProvider;

  @override
  void initState() {
    super.initState();

    //Get overall provider
    OverallProvider _overallProvider =
        Provider.of<OverallProvider>(context, listen: false);

    // Get initial load of accounts
    _accountsProvider = Provider.of<AccountsProvider>(context, listen: false);
    _accountsProvider.getAccounts();

    //Get initial load of transactions
    _transactionsProvider =
        Provider.of<TransactionsProvider>(context, listen: false);
    _transactionsProvider.getTransactions(
        year: _overallProvider.currentYear,
        month: _overallProvider.currentMonth);

    //Get ininital load of categories
    _categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    _categoriesProvider.getCategories(
        year: _overallProvider.currentYear,
        month: _overallProvider.currentMonth);
  }

  @override
  Widget build(BuildContext context) {
    print('Rebuilt!');

    //** Providers */
    final AccountsProvider _accountsProvider =
        Provider.of<AccountsProvider>(context);
    final CategoriesProvider _categoriesProvider =
        Provider.of<CategoriesProvider>(context);
    final OverallProvider _overallProvider =
        Provider.of<OverallProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tus Finanzas', style: headline2),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (_) => const ChangeCurrencyDialog()),
              child: Text(_overallProvider.overallCurrency),
            ),
          )
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: CustomThemes.horizontalPadding),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                ListAccountCards(accounts: _accountsProvider.accounts),
                const SizedBox(height: 20),
                const MonthIndicator(),
                const SizedBox(height: 10),
                const HomeSummaryCard(),
                const SizedBox(height: 20),
                ..._categoriesProvider.categories
                    .map((c) => CategoryCard(category: c))
                    .toList(),
                const NewCategoryButton(),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
