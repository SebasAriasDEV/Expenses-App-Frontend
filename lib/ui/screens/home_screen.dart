// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:i_budget_app/providers/accounts_providers.dart';
import 'package:i_budget_app/providers/categories_providers.dart';
import 'package:i_budget_app/providers/overall_provider.dart';
import 'package:i_budget_app/providers/transactions_provider.dart';
import 'package:i_budget_app/ui/components/category_card.dart';
import 'package:i_budget_app/utils/colors.dart';
import 'package:i_budget_app/utils/text_themes.dart';
import 'package:i_budget_app/utils/themes.dart';
import 'package:provider/provider.dart';

import '../components/account_cards_list.dart';
import '../components/home_summary_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AccountsProvider _accountsProvider;
  late CategoriesProvider _categoriesProvider;
  late TransactionsProvider _transactionsProvider;
  late OverallProvider _overallProvider;

  @override
  void initState() {
    super.initState();

    //Get overall provider
    _overallProvider = Provider.of<OverallProvider>(context, listen: false);

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
        year: _overallProvider.currentMonth,
        month: _overallProvider.currentMonth);
  }

  @override
  Widget build(BuildContext context) {
    final _overallProvider = Provider.of<OverallProvider>(context);
    print(_overallProvider.currentMonth);
    print(_overallProvider.currentYear);

    /***** Providers */
    final AccountsProvider _accountsProvider =
        Provider.of<AccountsProvider>(context);
    final CategoriesProvider _categoriesProvider =
        Provider.of<CategoriesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tus Finanzas',
          style: headline2,
        ),
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
                ListAccountCards(dummyAccounts: _accountsProvider.accounts),
                const SizedBox(height: 30),
                const MonthIndicator(),
                const SizedBox(height: 30),
                const HomeSummaryCard(),
                const SizedBox(height: 20),
                ..._categoriesProvider.categories
                    .map((c) => CategoryCard(category: c))
                    .toList(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MonthIndicator extends StatelessWidget {
  const MonthIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const FaIcon(FontAwesomeIcons.chevronLeft, color: kGreyColorShade1),
        Text('Marzo', style: headline6.copyWith(color: kPrimaryColorDark)),
        const FaIcon(FontAwesomeIcons.chevronRight, color: kGreyColorShade1),
      ],
    );
  }
}
