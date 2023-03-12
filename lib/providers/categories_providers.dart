// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:i_budget_app/main.dart';
import 'package:i_budget_app/models/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:i_budget_app/models/server_responses/categories_list_response.dart';

class CategoriesProvider extends ChangeNotifier {
  int _totalCategories = 0;
  List<TCategory> _categories = [];

  //******** Getter and setters */
  List<TCategory> get categories => _categories;
  int get totalCategories => _totalCategories;

  //******** Functions */
  //GET - Get all categories from selected month and year
  Future<void> getCategories(
      {required int month,
      required int year,
      required String displayCurrency}) async {
    //Http request to backend
    final url = Uri.parse(
        'http://192.168.0.31:8000/api/categories?year=$year&month=$month');
    //TODO: Cuando el server esta caido, deberia mostrar error
    final response = await http.get(
      url,
      headers: {
        'x-token': testingToken,
      },
    );

    if (response.statusCode == 200) {
      final CategoriesListResponse _categoriesListReponse =
          CategoriesListResponse.fromJson(jsonDecode(response.body));

      //Update provider variables
      _totalCategories = _categoriesListReponse.total;
      _categories = _categoriesListReponse.categories;

      //Change display currency of categories
      changeCategoriesDisplayCurrency(displayCurrency);
    }
    notifyListeners();
  }

  //POST - Create a new category
  Future<String> createCategory(String name, double monthlyBudget, int month,
      int year, String currency) async {
    final url = Uri.parse('http://192.168.0.31:8000/api/categories');
    final Map<String, Object> body = {
      'name': name,
      'monthlyBudget': monthlyBudget,
      'month': month,
      'year': year,
      'currency': currency,
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

  //DELETE - Create a new category
  Future<String> deleteCategory(String uid) async {
    final url = Uri.parse('http://192.168.0.31:8000/api/categories/$uid');

    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'x-token': testingToken,
      },
    );

    if (response.statusCode == 200) {
      return 'OK';
    } else {
      print(response.body);
      return 'ERROR';
    }
  }

  //Change display currency of categories
  void changeCategoriesDisplayCurrency(String displayCurrency) {
    _categories = _categories.map((c) {
      TCategory category = c;
      if (c.currency == displayCurrency) {
        return c;
      } else {
        if (displayCurrency == 'COP') {
          category.monthlyBudget =
              double.parse((c.monthlyBudget * 5050).toStringAsFixed(2));
        } else {
          category.monthlyBudget =
              double.parse((c.monthlyBudget / 5050).toStringAsFixed(2));
        }
        return category;
      }
    }).toList();

    notifyListeners();
  }
}
