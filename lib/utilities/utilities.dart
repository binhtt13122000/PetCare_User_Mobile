// ignore_for_file: non_constant_identifier_names

import 'package:intl/intl.dart';

FORMAT_MONEY({required double price}) {
  String moneyText =
      NumberFormat.currency(locale: 'vi', symbol: '₫', decimalDigits: 0)
          .format(price);
  return moneyText;
}
