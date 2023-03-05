// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:i_budget_app/models/account_model.dart';
import 'package:i_budget_app/models/server_responses/accounts_list_response.dart';

class AccountsProvider extends ChangeNotifier {
  List<Account> _accounts = [];
  int _totalAccounts = 0;

  //******** Getter and setters */
  List<Account> get accounts => _accounts;
  int get totalAccounts => _totalAccounts;

  //******** Functions */
  Future<void> getAccounts() async {
    //Http request to backend
    final url = Uri.parse('http://localhost:8000/api/accounts');

    var response = await http.get(url, headers: {
      'x-token':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI2M2ZlNTg1MjUyOTA3Y2RlZjJiZDM2ZGYiLCJpYXQiOjE2Nzc2MTMxMzgsImV4cCI6MTcwMzUzMzEzOH0.LHtsDYsaUrrR6gcG98V8X3fmWD8xWW93anLOLldg0i0',
    });

    if (response.statusCode == 200) {
      final AccountsListReponse _accountsListReponse =
          AccountsListReponse.fromJson(jsonDecode(response.body));

      //Update provider variables
      _totalAccounts = _accountsListReponse.total;
      _accounts = _accountsListReponse.accounts;
    }

    notifyListeners();
  }
}
