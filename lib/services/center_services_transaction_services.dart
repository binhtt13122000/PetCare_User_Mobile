import 'dart:convert';

import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/models/center_services_transaction_model/center_services_transaction_model.dart';
import 'package:http/http.dart' as http;

class CenterServicesTransactionServices {
  static List<CenterServicesTransactionModel> getCenterServicesTransactionList(
      List<dynamic> jsonData) {
    final List<CenterServicesTransactionModel>
        centerServicesTransactionModelList = List.empty(growable: true);
    for (var element in jsonData) {
      centerServicesTransactionModelList
          .add(CenterServicesTransactionModel.fromJson(element));
    }
    return centerServicesTransactionModelList;
  }

  static Future<List<CenterServicesTransactionModel>>
      fetchListCenterServicesTransactionBuyCustomerId({
    required int page,
    required int limit,
    required int customerId,
  }) async {
    Map<String, dynamic> parameters = <String, dynamic>{
      'page': page.toString(),
      'limit': limit.toString(),
      'customerId': customerId.toString(),
    };
    final response = await http.get(
      Uri.http(
          API_SERVER_PATH, CENTER_SERVICES_TRANSACTION_API_PATH, parameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return getCenterServicesTransactionList(
            jsonDecode(response.body)['data']['content']);
      default:
        throw Exception('Error ${response.statusCode}, cannot get branch list');
    }
  }
}
