// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i_budget_app/providers/accounts_providers.dart';
import 'package:i_budget_app/providers/overall_provider.dart';
import 'package:i_budget_app/providers/transactions_provider.dart';
import 'package:provider/provider.dart';

import '../../../helpers/custom_functions.dart';
import '../../../models/transaction_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/text_themes.dart';
import '../custom_snackbar.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
    required this.transaction,
    this.inAccountDetail = false,
  });

  final Transaction transaction;
  final bool inAccountDetail;

  @override
  Widget build(BuildContext context) {
    //** Build - Providers */
    final TransactionsProvider _transactionsProvider =
        Provider.of<TransactionsProvider>(context);
    final AccountsProvider _accountsProvider =
        Provider.of<AccountsProvider>(context);
    final OverallProvider _overallProvider =
        Provider.of<OverallProvider>(context);

    //** Build - Functions */
    Future<bool> deleteTransaction(String uid) async {
      final String response =
          await _transactionsProvider.deleteTransaction(uid);
      await _accountsProvider.getAccounts(_overallProvider.overallCurrency);
      await _transactionsProvider.getTransactions(
          month: _overallProvider.currentMonth,
          year: _overallProvider.currentYear,
          displayCurrency: _overallProvider.overallCurrency);
      if (response == 'OK') {
        return true;
      }
      return false;
    }

    //** Build - Widgets */
    return Dismissible(
      confirmDismiss: (direction) => deleteTransaction(transaction.uid),
      onDismissed: (direction) {
        ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
            text:
                'La transacción ${transaction.description} ha sido eliminada.'));
        Navigator.pop(context);
      },
      background: Container(
        margin: const EdgeInsets.only(top: 10.0),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: kErrorColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: const Align(
          alignment: Alignment.centerRight,
          child: FaIcon(
            FontAwesomeIcons.trash,
            textDirection: TextDirection.rtl,
            color: kWhiteColor,
          ),
        ),
      ),
      direction: DismissDirection.endToStart,
      key: Key(transaction.uid),
      child: Container(
          margin: const EdgeInsets.only(top: 12.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  transaction.transactionType == 'Income'
                      ? const FaIcon(FontAwesomeIcons.arrowDown,
                          color: kSuccessColor)
                      : const FaIcon(FontAwesomeIcons.arrowUpFromBracket,
                          color: kErrorColor),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(transaction.description, style: paragraph2),
                      Text(
                          inAccountDetail
                              ? transaction.category.name
                              : transaction.account.name,
                          style: paragraph7),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    CustomFunctions.formatNumber(transaction.amount),
                    style: headline7.copyWith(
                        color: transaction.transactionType == 'Income'
                            ? kSuccessColor
                            : kErrorColor),
                  ),
                  Text(
                    CustomFunctions.formatFullDate(transaction.date.toLocal()),
                    style: paragraph7,
                  )
                ],
              )
            ],
          )),
    );
  }
}
