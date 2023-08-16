
import 'package:intl/intl.dart';

class FormatNumber{
  static String numberFormatToString(double n) {
    return NumberFormat.currency(customPattern: '#,###.#', decimalDigits: n.truncateToDouble() == n ? 0 : 2)
        .format(n);
    //return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }

  static String stringFormatNumber(String value) {
    double n = double.parse( value);
    return NumberFormat.currency(customPattern: '#,###.#', decimalDigits: n.truncateToDouble() == n ? 0 : 2)
        .format(n);
    //return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }
}