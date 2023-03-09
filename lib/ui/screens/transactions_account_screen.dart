// ignore_for_file: no_leading_underscores_for_local_identifiers

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
    required this.accountTransactions,
  });

  final Account account;
  final List<Transaction> accountTransactions;

  @override
  Widget build(BuildContext context) {
    final _income = account.getTotalIncome(accountTransactions);
    final _outcome = account.getTotalOutcome(accountTransactions);

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
                balance: account.balance,
                income: _income,
                outcome: _outcome,
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
                      ...accountTransactions
                          .map((t) => TransactionCard(
                                transaction: t,
                                inAccountDetail: true,
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
