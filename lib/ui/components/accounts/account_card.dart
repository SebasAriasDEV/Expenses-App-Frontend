// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:i_budget_app/helpers/custom_functions.dart';
import 'package:i_budget_app/models/account_model.dart';
import 'package:i_budget_app/providers/overall_provider.dart';
import 'package:i_budget_app/ui/screens/transactions_account_screen.dart';
import 'package:i_budget_app/utils/colors.dart';
import 'package:i_budget_app/utils/text_themes.dart';
import 'package:provider/provider.dart';

import '../../../providers/transactions_provider.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({super.key, required this.account});

  final Account account;

  @override
  Widget build(BuildContext context) {
    //** Build - Providers */
    final _monthTransactions =
        Provider.of<TransactionsProvider>(context).transactionsList;

    //** Build - Widgets */
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => TransactionsAccountScreen(
                    account: account,
                    accountTransactions:
                        account.getTransactionsForAccount(_monthTransactions),
                  ))),
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(10.0),
          gradient: const LinearGradient(
            colors: [kPrimaryColorLight, kPrimaryColor, kPrimaryColorDark],
          ),
        ),
        child: CardContent(account: account),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  const CardContent({super.key, required this.account});

  final Account account;

  @override
  Widget build(BuildContext context) {
    //** Build - Providers */
    final _overallProvider = Provider.of<OverallProvider>(context);
    //** Build - Widgets */
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                account.type,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: kWhiteColor),
              ),
              Expanded(
                child: Text(
                  account.name,
                  textAlign: TextAlign.end,
                  style: const TextStyle(color: kWhiteColor),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Balance:',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: kWhiteColor),
              ),
              Row(
                children: [
                  Text(
                    '${_overallProvider.overallCurrency}:',
                    overflow: TextOverflow.ellipsis,
                    style: paragraph6.copyWith(color: kWhiteColor),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    CustomFunctions.formatNumber(account.balance),
                    overflow: TextOverflow.ellipsis,
                    style: headline3.copyWith(color: kWhiteColor),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
