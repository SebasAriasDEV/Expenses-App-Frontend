import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i_budget_app/helpers/custom_functions.dart';
import 'package:i_budget_app/utils/colors.dart';
import 'package:i_budget_app/utils/text_themes.dart';
import '../screens/transactions_category_screen.dart';

import '../../models/category_model.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {super.key, required this.category, required this.currentExpense});

  final TCategory category;
  final double currentExpense;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => TransactionsCategoryScreen(category: category))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: CategoryCardContent(
            category: category, currentExpense: currentExpense),
      ),
    );
  }
}

class CategoryCardContent extends StatelessWidget {
  const CategoryCardContent(
      {super.key, required this.category, required this.currentExpense});

  final TCategory category;
  final double currentExpense;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          const CategoryIconBox(),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(category.name, style: headline6),
                    Text(CustomFunctions.formatNumber(currentExpense),
                        style: headline6),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("20 Movimientos", style: paragraph6),
                    Text(
                        "de ${CustomFunctions.formatNumber(category.monthlyBudget)}",
                        style: paragraph6),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: currentExpense / category.monthlyBudget,
                  backgroundColor: kPurpleColorLight,
                  color: kPurpleColor,
                  minHeight: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryIconBox extends StatelessWidget {
  const CategoryIconBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: kPurpleColorLight,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SvgPicture.asset(
        'assets/Apple.svg',
        height: 20,
        width: 20,
        color: kPurpleColor,
      ),
    );
  }
}
