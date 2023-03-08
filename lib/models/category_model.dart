import 'package:i_budget_app/models/transaction_model.dart';

class TCategory {
  String name;
  double monthlyBudget;
  String uid;

  TCategory({
    required this.name,
    required this.monthlyBudget,
    required this.uid,
  });

  factory TCategory.fromJson(Map<String, dynamic> json) => TCategory(
        name: json['name'],
        monthlyBudget: json['monthlyBudget'].toDouble(),
        uid: json['uid'] ?? json['_id'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['monthlyBudget'] = monthlyBudget;
    data['uid'] = uid;
    return data;
  }

  //Loop through all the month transactions and find the total expense for the category provided
  double getExpenseForCategory(List<Transaction> monthTransactions) {
    double total = 0;
    for (var transaction in monthTransactions) {
      if (transaction.category.uid == uid) {
        total = total + transaction.amount;
      }
    }

    return total;
  }

//Loop through all the month transactions and filter this category's transactions
  List<Transaction> getTransactionsForCategory(
      List<Transaction> monthTransactions) {
    List<Transaction> categoryTransactions = [];
    for (var transaction in monthTransactions) {
      if (transaction.category.uid == uid) {
        categoryTransactions.add(transaction);
      }
    }

    return categoryTransactions;
  }
}
