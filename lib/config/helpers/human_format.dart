import 'package:intl/intl.dart';

class HumanFormat {
  static String format(double number) {
    final formatter = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
      locale: 'en',
    ).format(number);

    return formatter;
  }
}