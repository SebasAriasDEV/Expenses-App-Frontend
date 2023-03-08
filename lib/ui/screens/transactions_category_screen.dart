// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:i_budget_app/models/category_model.dart';
import 'package:i_budget_app/models/transaction_model.dart';
import 'package:i_budget_app/providers/transactions_provider.dart';
import 'package:i_budget_app/utils/colors.dart';
import 'package:i_budget_app/utils/text_themes.dart';
import 'package:i_budget_app/utils/themes.dart';
import 'package:provider/provider.dart';

import '../components/transactions/flexible_app_bar_content.dart';
import '../components/transactions/transaction_card.dart';

class TransactionsCategoryScreen extends StatelessWidget {
  const TransactionsCategoryScreen(
      {super.key, required this.category, required this.categoryTransactions});

  final TCategory category;
  final List<Transaction> categoryTransactions;

  @override
  Widget build(BuildContext context) {
    // final dummyTransactions = Transaction.dummyTransactions;
    final _transactionsProvider = Provider.of<TransactionsProvider>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // pinned: true,
            title: Text(category.name,
                style: headline2.copyWith(color: kWhiteColor)),
            leading: const BackButton(color: kWhiteColor),
            expandedHeight: 250,
            flexibleSpace: const FlexibleSpaceBar(
              // title: Text('Movimientos!!', selectionColor: Colors.red),
              background: FlexibleSpaceContent(
                balance: 50000,
                income: 3000,
                outcome: 2500,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: CustomThemes.horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ...categoryTransactions
                          .map((t) => TransactionCard(
                                transaction: t,
                              ))
                          .toList(),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
