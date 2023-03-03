import 'package:flutter/material.dart';
import 'package:i_budget_app/models/account_model.dart';
import 'package:i_budget_app/models/transaction_model.dart';
import 'package:i_budget_app/utils/colors.dart';
import 'package:i_budget_app/utils/text_themes.dart';
import 'package:i_budget_app/utils/themes.dart';

import '../components/transactions/flexible_app_bar_content.dart';
import '../components/transactions/transaction_card.dart';

class TransactionsAccountScreen extends StatelessWidget {
  const TransactionsAccountScreen({
    super.key,
    required this.account,
  });

  final Account account;

  @override
  Widget build(BuildContext context) {
    final dummyTransactions = Transaction.dummyTransactions;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // pinned: true,
            title: Text(account.name,
                style: headline2.copyWith(color: kWhiteColor)),
            leading: const BackButton(color: kWhiteColor),
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              // title: Text('Movimientos!!', selectionColor: Colors.red),
              background: FlexibleSpaceContent(
                  balance: account.balance, income: 2500, outcome: 8000),
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
                      ...dummyTransactions
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
