import 'package:intl/intl.dart';

class CustomFunctions {
  static String formatNumber(double number) {
    var formatter = NumberFormat('#,###,000');
    return formatter.format(number);
  }
}
