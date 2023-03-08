import 'package:i_budget_app/models/category_model.dart';
import 'package:i_budget_app/models/transaction_model.dart';

//Loop through all the month transactions and find the total expense for the category provided
class CategoryHelpers {
  static double getCurrentExpenseForCategory(
      {required TCategory category, required List<Transaction> transactions}) {
    double total = 0;
    for (var transaction in transactions) {
      if (transaction.category.uid == category.uid) {
        total = total + transaction.amount;
      }
    }

    return total;
  }
}
