import 'package:i_budget_app/models/transaction_model.dart';

class TransactionsListResponse {
  late int total;
  late List<Transaction> transactions;

  TransactionsListResponse({required this.total, required this.transactions});

  TransactionsListResponse.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['transactions'] != null) {
      transactions = [];
      json['transactions'].forEach((v) {
        transactions.add(Transaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['total'] = total;
    data['transactions'] = transactions.map((v) => v.toJson()).toList();

    return data;
  }
}
