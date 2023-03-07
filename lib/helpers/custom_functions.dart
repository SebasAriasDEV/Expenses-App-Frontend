import 'package:intl/intl.dart';

class CustomFunctions {
  //Converts number to currency with thousand commas
  static String formatNumber(double number) {
    var formatter = NumberFormat('#,###,000');
    return formatter.format(number);
  }

  //Converts date to month format
  static String formatMonthName(DateTime date) {
    var formatter = DateFormat('MMMM');
    return formatter.format(date);
  }
}
