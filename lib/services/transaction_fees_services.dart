import 'dart:convert';

import 'package:petapp_mobile/configs/path.dart';
import 'package:http/http.dart' as http;
import 'package:petapp_mobile/models/transaction_fees_model/transaction_fees_model.dart';

class TransactionFeesServices {
  static Future<List<TransactionFeesModel>> fetchTransactionFreesList(
      {required String transactionType}) async {
    Map<String, String> parameters = {
      'type': transactionType,
    };
    final response = await http.get(
      Uri.http(API_SERVER_PATH, SALE_TRANSACTION_FEES_API_PATH, parameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return getTransactionFeesList(json.decode(response.body)['data']);
      default:
        throw Exception(
            'Error ${response.statusCode}, cannot not get transaction fees');
    }
  }

  static List<TransactionFeesModel> getTransactionFeesList(
      List<dynamic> jsonData) {
    final List<TransactionFeesModel> transactionFeesList =
        List.empty(growable: true);
    for (var element in jsonData) {
      transactionFeesList.add(TransactionFeesModel.fromJson(element));
    }
    return transactionFeesList;
  }
}
