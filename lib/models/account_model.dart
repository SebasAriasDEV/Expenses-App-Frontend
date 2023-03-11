import 'package:i_budget_app/models/transaction_model.dart';

class Account {
  String name;
  String type;
  String currency;
  String uid;
  double balance;

  static List<Account> get dummyAccounts => [
        Account(
          name: 'Scotiabank Nomina',
          type: 'Debito',
          currency: 'COP',
          uid: 'AAA',
          balance: 9000000,
        ),
        Account(
          name: 'Nequi',
          type: 'Debito',
          currency: 'COP',
          uid: 'AAA',
          balance: 500000,
        ),
        Account(
          name: 'Santander BCN',
          type: 'Debito',
          currency: 'EUR',
          uid: 'AAA',
          balance: 720,
        ),
      ];

  Account({
    required this.name,
    required this.type,
    required this.currency,
    required this.uid,
    required this.balance,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        name: json['name'],
        type: json['type'],
        currency: json['currency'],
        uid: json['uid'] ?? json['_id'],
        balance: json['balance'].toDouble(),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = type;
    data['currency'] = currency;
    data['uid'] = uid;
    data['balance'] = balance;
    return data;
  }

  //Loop through all the month transactions and filter this account's transactions
  List<Transaction> getTransactionsForAccount(
      List<Transaction> monthTransactions) {
    List<Transaction> accountTransactions = [];
    for (var transaction in monthTransactions) {
      if (transaction.account.uid == uid) {
        accountTransactions.add(transaction);
      }
    }
    return accountTransactions;
  }

  //Loop through all the month transactions and get total income
  double getTotalIncome(List<Transaction> accountTransactions) {
    double result = 0;
    for (var transaction in accountTransactions) {
      if (transaction.transactionType == 'Income') {
        result += transaction.amount;
      }
    }
    return result;
  }

  //Loop through all the month transactions and get total income
  double getTotalOutcome(List<Transaction> accountTransactions) {
    double result = 0;
    for (var transaction in accountTransactions) {
      if (transaction.transactionType == 'Expense') {
        result += transaction.amount;
      }
    }
    return result;
  }
}
