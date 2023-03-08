import 'package:flutter/material.dart';
import 'package:i_budget_app/helpers/custom_functions.dart';
import 'package:i_budget_app/providers/transactions_provider.dart';
import 'package:i_budget_app/utils/colors.dart';
import 'package:i_budget_app/utils/text_themes.dart';
import 'package:provider/provider.dart';

class HomeSummaryCard extends StatelessWidget {
  const HomeSummaryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _transactionsProvider = Provider.of<TransactionsProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SummaryItem(
          title: 'Ingreso',
          amount: _transactionsProvider.getOverallIncome(),
          color: kSuccessColor,
        ),
        Container(
          width: 1,
          height: 20,
          color: kGreyColorShade2,
        ),
        SummaryItem(
          title: 'Egreso',
          amount: _transactionsProvider.getOverallOutome(),
          color: kErrorColor,
        ),
        Container(
          width: 1,
          height: 20,
          color: kGreyColorShade2,
        ),
        SummaryItem(
          title: 'Neto',
          amount: _transactionsProvider.getNetTotal(),
          color: kBlackColor,
        ),
      ],
    );
  }
}

class SummaryItem extends StatelessWidget {
  const SummaryItem({
    super.key,
    required this.title,
    required this.amount,
    required this.color,
  });

  final String title;
  final double amount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: headline7.copyWith(color: color),
        ),
        Text(
          CustomFunctions.formatNumber(amount),
          style: headline5.copyWith(
            color: color,
          ),
        ),
      ],
    );
  }
}
