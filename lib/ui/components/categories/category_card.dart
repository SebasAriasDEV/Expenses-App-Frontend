// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i_budget_app/helpers/custom_functions.dart';
import 'package:i_budget_app/models/transaction_model.dart';
import 'package:i_budget_app/providers/categories_providers.dart';
import 'package:i_budget_app/providers/transactions_provider.dart';
import 'package:i_budget_app/ui/components/custom_snackbar.dart';
import 'package:i_budget_app/utils/colors.dart';
import 'package:i_budget_app/utils/text_themes.dart';
import 'package:provider/provider.dart';
import '../../screens/transactions_category_screen.dart';

import '../../../models/category_model.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});

  final TCategory category;

  @override
  Widget build(BuildContext context) {
    //** Build - Providers */
    final _monthTransactions =
        Provider.of<TransactionsProvider>(context).transactionsList;
    final CategoriesProvider _categoriesProvider =
        Provider.of<CategoriesProvider>(context);

    //** Build - Variables */
    final _categoryExpense = category.getExpenseForCategory(_monthTransactions);
    final _categoryTransactions =
        category.getTransactionsForCategory(_monthTransactions);

    //** Build - Functions */
    Future<bool> deleteCategory(String uid) async {
      final String response = await _categoriesProvider.deleteCategory(uid);
      if (response == 'OK') {
        return true;
      }
      return false;
    }

    /** Build - Widgets */
    return Dismissible(
      confirmDismiss: (direction) => deleteCategory(category.uid),
      onDismissed: (direction) => ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
            text:
                'El presupuesto ${category.name} ha sido eliminado para el mes seleccionado.'),
      ),
      background: Container(
        margin: const EdgeInsets.only(bottom: 10.0),
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
      key: Key(category.uid),
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => TransactionsCategoryScreen(
                      category: category,
                      categoryTransactions: _categoryTransactions,
                    ))),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: CategoryCardContent(
            category: category,
            categoryExpense: _categoryExpense,
            categoryTransactions: _categoryTransactions,
          ),
        ),
      ),
    );
  }
}

class CategoryCardContent extends StatelessWidget {
  const CategoryCardContent({
    super.key,
    required this.category,
    required this.categoryExpense,
    required this.categoryTransactions,
  });

  final TCategory category;
  final double categoryExpense;
  final List<Transaction> categoryTransactions;

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
                    Text(CustomFunctions.formatNumber(categoryExpense),
                        style: headline6),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${categoryTransactions.length} Movimientos",
                        style: paragraph6),
                    Text(
                        "de ${CustomFunctions.formatNumber(category.monthlyBudget)}",
                        style: paragraph6),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: categoryExpense / category.monthlyBudget,
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
