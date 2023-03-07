import 'package:i_budget_app/models/account_model.dart';
import 'package:i_budget_app/models/category_model.dart';
import 'package:i_budget_app/models/user_model.dart';

class Transaction {
  late String transactionType;
  late double amount;
  late DateTime date;
  late String description;
  late int month;
  late int year;
  late User user;
  late Account account;
  late TCategory category;
  late String uid;

  Transaction({
    required this.transactionType,
    required this.amount,
    required this.date,
    required this.description,
    required this.month,
    required this.year,
    required this.user,
    required this.account,
    required this.category,
    required this.uid,
  });

  Transaction.fromJson(Map<String, dynamic> json) {
    transactionType = json['transactionType'];
    amount = json['amount'].toDouble();
    date = DateTime.parse(json['date']);
    description = json['description'];
    month = json['month'];
    year = json['year'];
    user = User.fromJson(json['user']);
    account = Account.fromJson(json['account']);
    category = TCategory.fromJson(json['category']);
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['transactionType'] = transactionType;
    data['amount'] = amount;
    data['date'] = date;
    data['description'] = description;
    data['month'] = month;
    data['year'] = year;
    data['user'] = user.toJson();
    data['account'] = account.toJson();
    data['category'] = category.toJson();
    data['uid'] = uid;
    return data;
  }
}
