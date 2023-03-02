import 'package:flutter/material.dart';
import 'package:i_budget_app/helpers/custom_functions.dart';
import 'package:i_budget_app/utils/colors.dart';
import 'package:i_budget_app/utils/text_themes.dart';

class HomeSummaryCard extends StatelessWidget {
  const HomeSummaryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SummaryItem(
          title: 'Ingreso',
          amount: 11000000,
          color: kSuccessColor,
        ),
        Container(
          width: 1,
          height: 20,
          color: kGreyColorShade2,
        ),
        const SummaryItem(
          title: 'Egreso',
          amount: 11000000,
          color: kErrorColor,
        ),
        Container(
          width: 1,
          height: 20,
          color: kGreyColorShade2,
        ),
        const SummaryItem(
          title: 'Neto',
          amount: 11000000,
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
