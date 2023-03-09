import 'package:intl/intl.dart';

class CustomFunctions {
  //Converts number to currency with thousand commas
  static String formatNumber(double number) {
    var formatter = NumberFormat.decimalPatternDigits(decimalDigits: 2);
    return formatter.format(number);
  }

  //Converts date to month format
  static String formatMonthNameFromDate(DateTime date) {
    var formatter = DateFormat('MMMM');
    return formatter.format(date);
  }

  //Converts date to month format
  static String formatMonthNameFromNum(int monthNumber) {
    final formatter = DateFormat('MMMM');
    final newDate = DateTime(2023, monthNumber);
    return formatter.format(newDate);
  }
}
