import 'package:flutter/material.dart';

class OverallProvider extends ChangeNotifier {
  int _currentMonth = DateTime.now().month;
  int _currentYear = DateTime.now().year;
  String _overallCurrency = 'COP';

  //*** Getters and setters */
  int get currentMonth => _currentMonth;
  int get currentYear => _currentYear;
  String get overallCurrency => _overallCurrency;

  set currentMonth(int value) {
    _currentMonth = value;
    notifyListeners();
  }

  set currentYear(int value) {
    _currentYear = value;
    notifyListeners();
  }

  set overallCurrency(String value) {
    _overallCurrency = value;
    notifyListeners();
  }

  //*** Functions */
}
