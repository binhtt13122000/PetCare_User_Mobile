import 'dart:convert';

import 'package:petapp_mobile/configs/path.dart';
import 'package:http/http.dart' as http;
import 'package:petapp_mobile/models/order_detail_model/order_detail_model.dart';
import 'package:petapp_mobile/models/order_model/order_model.dart';

class CenterServicesTransactionServices {
  static List<OrderModel> getCenterServicesTransactionList(
      List<dynamic> jsonData) {
    final List<OrderModel> centerServicesTransactionModelList =
        List.empty(growable: true);
    for (var element in jsonData) {
      centerServicesTransactionModelList.add(OrderModel.fromJson(element));
    }
    return centerServicesTransactionModelList;
  }

  static Future<int> createCenterServicesTransaction({
    required int provisionalTotal,
    required int orderTotal,
    required int customerId,
    required int branchId,
    required String? description,
    required DateTime registerTime,
    String status = 'WAITING',
    required List<OrderDetailModel> orderDetails,
  }) async {
    List<Map<String, dynamic>> orderDetailsJsonMapList = [];
    for (var element in orderDetails) {
      orderDetailsJsonMapList.add(element.toJson());
    }

    Map<String, dynamic> jsonBodyMap = {
      'provisionalTotal': provisionalTotal,
      'orderTotal': orderTotal,
      'customerId': customerId,
      'branchId': branchId,
      'description': description ?? '',
      'registerTime': registerTime.toIso8601String(),
      'status': status,
      'orderDetails': orderDetailsJsonMapList,
    };
    final response = await http.post(
      Uri.http(
        API_SERVER_PATH,
        CENTER_SERVICES_TRANSACTION_API_PATH,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(jsonBodyMap),
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return jsonDecode(response.body)['data']['id'];
      default:
        print(response.body);
        return -1;
    }
  }

  static Future<List<OrderModel>>
      fetchListCenterServicesTransactionByCustomerId({
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
        throw Exception(
            'Error ${response.statusCode}, cannot get transaction list');
    }
  }

  static Future<OrderModel> fetchCenterServicesTransactionByTransactionId({
    required int transactionId,
  }) async {
    final response = await http.get(
      Uri.http(API_SERVER_PATH,
          '$CENTER_SERVICES_TRANSACTION_API_PATH/$transactionId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return OrderModel.fromJson(jsonDecode(response.body)['data']);
      default:
        throw Exception('Error ${response.statusCode}, cannot get transaction');
    }
  }

  static Future<String> payment({
    required String message,
    required String locale,
    required String paymentMethod,
    required int transactionId,
    required int orderTotal,
    required DateTime paymentTime,
    int? promotionId,
    int? paymentPoint,
    required int provisionalTotal,
    required int branchId,
    required int customerId,
  }) async {
    final queryParameters = {
      'message': message,
      'locale': locale,
      'returnUrl':
          'http://$API_SERVER_PATH$CENTER_SERVICES_TRANSACTION_RETURN_API_PATH'
    };

    final response = await http.post(
      Uri.http(API_SERVER_PATH, CENTER_SERVICES_TRANSACTION_PAYMENT_API_PATH,
          queryParameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'provisionalTotal': provisionalTotal,
        'orderTotal': orderTotal,
        'branchId': branchId,
        'customerId': customerId,
        'point': orderTotal ~/ 1000,
        'paymentTime': paymentTime.toIso8601String(),
        'paymentMethod': paymentMethod,
        'payment': orderTotal,
        'id': transactionId,
        'promotionId': promotionId,
        'paymentPoint': paymentPoint,
      }),
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return jsonDecode(response.body)['url'];
      default:
        throw Exception('Error ${response.statusCode}, cannot payment');
    }
  }

  static Future<int> update({
    required int transactionId,
    required int star,
    required String review,
  }) async {
    final response = await http.post(
      Uri.http(API_SERVER_PATH, CENTER_SERVICES_TRANSACTION_API_PATH),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'id': transactionId,
        'star': star,
        'review': review,
      }),
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return jsonDecode(response.body)['data']['id'];
      default:
        throw Exception('Error ${response.statusCode}, cannot update');
    }
  }
}
