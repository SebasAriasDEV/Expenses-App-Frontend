// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:i_budget_app/main.dart';

import 'package:i_budget_app/models/account_model.dart';
import 'package:i_budget_app/models/server_responses/accounts_list_response.dart';

class AccountsProvider extends ChangeNotifier {
  List<Account> _accounts = [];
  int _totalAccounts = 0;

  //******** Getter and setters */
  List<Account> get accounts => _accounts;
  int get totalAccounts => _totalAccounts;

  //******** Functions */
  Future<void> getAccounts(String displayCurrency) async {
    //Http request to backend
    final url = Uri.parse(
        'http://192.168.0.31:8000/api/accounts?displayCurrency=$displayCurrency');
    //TODO: Cuando el server esta caido, deberia mostrar error
    var response = await http.get(url, headers: {
      'x-token': testingToken,
    });

    if (response.statusCode == 200) {
      final AccountsListReponse _accountsListReponse =
          AccountsListReponse.fromJson(jsonDecode(response.body));

      //Update provider variables
      _totalAccounts = _accountsListReponse.total;
      _accounts = _accountsListReponse.accounts;
    } else {
      print(response.body);
    }

    notifyListeners();
  }

  //POST - Create a new account
  //Post a new transaction
  Future<String> createAccount(
    String name,
    String type,
    String currency,
    double balance,
  ) async {
    final Uri url = Uri.parse('http://192.168.0.31:8000/api/accounts');
    final body = {
      'name': name,
      'type': type,
      'currency': currency,
      'balance': balance,
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
