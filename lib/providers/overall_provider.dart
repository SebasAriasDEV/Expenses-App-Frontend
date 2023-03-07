import 'package:flutter/material.dart';

class OverallProvider extends ChangeNotifier {
  int _currentMonth = DateTime.now().month;
  int _currentYear = DateTime.now().year;

  //*** Getters and setters */
  int get currentMonth => _currentMonth;
  int get currentYear => _currentYear;

  set currentMonth(int value) {
    _currentMonth = value;
    notifyListeners();
  }

  set currentYear(int value) {
    _currentYear = value;
    notifyListeners();
  }

  //*** Functions */
}
