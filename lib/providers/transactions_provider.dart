import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:i_budget_app/main.dart';
import 'package:i_budget_app/models/server_responses/transactions_list_response.dart';

import 'package:i_budget_app/models/transaction_model.dart';

class TransactionsProvider extends ChangeNotifier {
  int _totalTransactions = 0;
  List<Transaction> _transactionsList = [];

  //***** Getters and setters */
  int get totalTransactions => _totalTransactions;
  List<Transaction> get transactionsList => _transactionsList;

  //**** Functions */
  //HTTP request for transactions
  Future<void> getTransactions(
      {required int month,
      required int year,
      required String displayCurrency}) async {
    final url = Uri.parse(
        'http://localhost:8000/api/transactions?month=$month&year=$year');

    final response = await http.get(
      url,
      headers: {
        'x-token': testingToken,
      },
    );

    if (response.statusCode == 200) {
      final TransactionsListResponse transactionsListResponse =
          TransactionsListResponse.fromJson(jsonDecode(response.body));

      //Update provider variables
      _totalTransactions = transactionsListResponse.total;
      _transactionsList = transactionsListResponse.transactions;

      //Change display currency on each transaction
      print('********* ${_transactionsList.length}');
      for (var t in _transactionsList) {
        print(t.amount);
      }
      _transactionsList = _transactionsList.map((t) {
        Transaction tran = t;
        if (t.account.currency == displayCurrency) {
          return tran;
        } else {
          if (displayCurrency == 'COP') {
            tran.amount = double.parse((t.amount * 5050).toStringAsFixed(2));
          } else {
            tran.amount = double.parse((t.amount / 5050).toStringAsFixed(2));
          }
          return tran;
        }
      }).toList();
    }
    print('********* ${_transactionsList.length}');
    for (var t in _transactionsList) {
      print(t.amount);
    }

    notifyListeners();
  }

  //Get over income of the month
  double getOverallIncome() {
    double result = 0;

    for (var transaction in _transactionsList) {
      if (transaction.transactionType == 'Income') {
        result += transaction.amount;
      }
    }
    return result;
  }

  //Get over expense of the month
  double getOverallOutome() {
    double result = 0;

    for (var transaction in _transactionsList) {
      if (transaction.transactionType == 'Expense') {
        result += transaction.amount;
      }
    }
    return result;
  }

  //Get over expense of the month
  double getNetTotal() {
    return getOverallIncome() + getOverallOutome();
  }

  //Post a new transaction
  Future<String> createTransaction(
      String categoryUID,
      String accountUID,
      double amount,
      String transactionType,
      String description,
      String date) async {
    final Uri url = Uri.parse('http://localhost:8000/api/transactions');
    final body = {
      'transactionType': transactionType,
      'amount': amount,
      'description': description,
      'date': date,
      'account': accountUID,
      'category': categoryUID,
    };
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'x-token': testingToken,
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return 'OK';
    } else {
      print(response.body);
      return 'ERROR';
    }
  }
}
