import 'package:i_budget_app/models/category_model.dart';
import 'package:i_budget_app/models/transaction_model.dart';

//Loop through all the month transactions and find the total expense for the category provided
class CategoryHelpers {
  static List<Transaction> getTransactionsForCategory(
      {required TCategory category,
      required List<Transaction> monthTransactions}) {
    List<Transaction> categoryTransactions = [];
    for (var transaction in monthTransactions) {
      if (transaction.category.uid == category.uid) {
        categoryTransactions.add(transaction);
      }
    }

    return categoryTransactions;
  }
}
