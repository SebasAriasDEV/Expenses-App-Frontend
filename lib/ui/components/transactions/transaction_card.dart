import 'package:flutter/material.dart';

import '../../../helpers/custom_functions.dart';
import '../../../models/transaction_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/text_themes.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
    required this.transaction,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                transaction.transactionType == 'INCOME'
                    ? const Icon(Icons.arrow_downward, color: kSuccessColor)
                    : const Icon(Icons.arrow_upward, color: kErrorColor),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(transaction.description, style: paragraph2),
                    Text(transaction.account, style: paragraph7),
                  ],
                ),
              ],
            ),
            Text(
              CustomFunctions.formatNumber(transaction.amount),
              style: headline7.copyWith(
                  color: transaction.transactionType == 'INCOME'
                      ? kSuccessColor
                      : kErrorColor),
            )
          ],
        ));
  }
}
