import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:i_budget_app/models/server_responses/transactions_list_response.dart';

import 'package:i_budget_app/models/transaction_model.dart';

class TransactionsProvider extends ChangeNotifier {
  int _totalTransactions = 0;
  List<Transaction> _transactionsList = [];

  //***** Getters and setters */
  int get totalTransactions => _totalTransactions;
  List<Transaction> get transactionsList => _transactionsList;

  //**** Functions */
  Future<void> getTransactions({required int month, required int year}) async {
    final url = Uri.parse(
        'http://localhost:8000/api/transactions?month=$month&year=$year');

    final response = await http.get(
      url,
      headers: {
        'x-token':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI2M2ZlNTg1MjUyOTA3Y2RlZjJiZDM2ZGYiLCJpYXQiOjE2Nzc2MTMxMzgsImV4cCI6MTcwMzUzMzEzOH0.LHtsDYsaUrrR6gcG98V8X3fmWD8xWW93anLOLldg0i0'
      },
    );

    if (response.statusCode == 200) {
      final TransactionsListResponse transactionsListResponse =
          TransactionsListResponse.fromJson(jsonDecode(response.body));

      //Update provider variables
      _totalTransactions = transactionsListResponse.total;
      _transactionsList = transactionsListResponse.transactions;
    }

    notifyListeners();
  }
}
