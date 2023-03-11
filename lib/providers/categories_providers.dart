// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:flutter/material.dart';
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
  //Get all categories from selected month and year
  Future<void> getCategories({required int month, required int year}) async {
    //Http request to backend
    final url = Uri.parse(
        'http://localhost:8000/api/categories?year=$year&month=$month');
    //TODO: Cuando el server esta caido, deberia mostrar error
    final response = await http.get(
      url,
      headers: {
        'x-token':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI2M2ZlNTg1MjUyOTA3Y2RlZjJiZDM2ZGYiLCJpYXQiOjE2Nzc2MTMxMzgsImV4cCI6MTcwMzUzMzEzOH0.LHtsDYsaUrrR6gcG98V8X3fmWD8xWW93anLOLldg0i0',
      },
    );

    if (response.statusCode == 200) {
      final CategoriesListResponse _categoriesListReponse =
          CategoriesListResponse.fromJson(jsonDecode(response.body));

      //Update provider variables
      _totalCategories = _categoriesListReponse.total;
      _categories = _categoriesListReponse.categories;
    }
    notifyListeners();
  }

  // Create a new category
  Future<String> createCategory(
      String name, double monthlyBudget, int month, int year) async {
    final url = Uri.parse('http://localhost:8000/api/categories');
    final Map<String, Object> body = {
      'name': name,
      'monthlyBudget': monthlyBudget,
      'month': month,
      'year': year,
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'x-token':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI2M2ZlNTg1MjUyOTA3Y2RlZjJiZDM2ZGYiLCJpYXQiOjE2Nzc2MTMxMzgsImV4cCI6MTcwMzUzMzEzOH0.LHtsDYsaUrrR6gcG98V8X3fmWD8xWW93anLOLldg0i0'
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return 'OK';
    } else {
      print(response.toString());
      return 'ERROR';
    }
  }
}
