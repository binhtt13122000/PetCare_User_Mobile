// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:intl/intl.dart';

const DATE_PATTERN = 'MMM dd yyyy';
const DATE_PATTERN_2 = 'dd/MM/yyyy';

const TIME_PATTERN = 'HH:mm a';
const DATE_TIME_PATTERN = 'MMM dd yyyy, HH:mm a';

FORMAT_MONEY({required int price}) {
  String moneyText =
      NumberFormat.currency(locale: 'vi', symbol: '₫', decimalDigits: 0)
          .format(price);
  return moneyText;
}

FORMAT_DATE_TIME({required DateTime dateTime, required String pattern}) {
  DateFormat dateFormat = DateFormat(pattern);
  return dateFormat.format(dateTime);
}
