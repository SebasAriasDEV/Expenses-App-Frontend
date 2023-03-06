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
  Future<void> getCategories() async {
    //Http request to backend
    final url = Uri.parse('http://localhost:8000/api/categories');
    //TODO: Cuando el server esta caido, deberia mostrar error
    var response = await http.get(url, headers: {
      'x-token':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI2M2ZlNTg1MjUyOTA3Y2RlZjJiZDM2ZGYiLCJpYXQiOjE2Nzc2MTMxMzgsImV4cCI6MTcwMzUzMzEzOH0.LHtsDYsaUrrR6gcG98V8X3fmWD8xWW93anLOLldg0i0',
    });

    if (response.statusCode == 200) {
      final CategoriesListResponse _categoriesListReponse =
          CategoriesListResponse.fromJson(jsonDecode(response.body));

      //Update provider variables
      _totalCategories = _categoriesListReponse.total;
      _categories = _categoriesListReponse.categories;
    }

    notifyListeners();
  }
}
