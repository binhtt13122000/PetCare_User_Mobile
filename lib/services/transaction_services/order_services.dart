import 'dart:convert';
import 'dart:io';

import 'package:petapp_mobile/configs/path.dart';
import 'package:http/http.dart' as http;
import 'package:petapp_mobile/models/order_detail_model/order_detail_model.dart';
import 'package:petapp_mobile/models/order_model/order_model.dart';

class OrderServices {
  static List<OrderModel> getCenterServicesTransactionList(
      List<dynamic> jsonData) {
    final List<OrderModel> centerServicesTransactionModelList =
        List.empty(growable: true);
    for (var element in jsonData) {
      centerServicesTransactionModelList.add(OrderModel.fromJson(element));
    }
    return centerServicesTransactionModelList;
  }

  static Future<int?> fetchOrderByBreedingTransactionId({
    required int breedingTransactionId,
    required String jwt,
  }) async {
    final response = await http.get(
      Uri.https(
        API_SERVER_PATH,
        '$ORDER_BREEDING_TRANSACTION_API_PATH/$breedingTransactionId',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return jsonDecode(response.body)['data']['id'];
      default:
        return null;
    }
  }

  static Future<bool> cancelOrder({
    required int orderId,
    required String reasonCancel,
    required DateTime cancelTime,
    required String jwt,
  }) async {
    final response = await http.put(
      Uri.https(API_SERVER_PATH, ORDER_CANCEL_API_PATH),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
      },
      body: jsonEncode({
        'id': orderId,
        'reasonCancel': reasonCancel,
        'cancelTime': cancelTime.toIso8601String(),
      }),
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return true;
      default:
        return false;
    }
  }

  static Future<int?> createCenterServicesTransaction({
    required int provisionalTotal,
    required int orderTotal,
    required int customerId,
    required int branchId,
    required String? description,
    required DateTime registerTime,
    String status = 'WAITING',
    required String jwt,
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
      Uri.https(
        API_SERVER_PATH,
        ORDER_API_PATH,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
      },
      body: jsonEncode(jsonBodyMap),
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return jsonDecode(response.body)['data']['id'];
      default:
        return null;
    }
  }

  static Future<List<OrderModel>>
      fetchListCenterServicesTransactionByCustomerId({
    required int page,
    required int limit,
    required int customerId,
    required String jwt,
  }) async {
    Map<String, dynamic> parameters = <String, dynamic>{
      'page': page.toString(),
      'limit': limit.toString(),
      'customerId': customerId.toString(),
    };
    final response = await http.get(
      Uri.https(API_SERVER_PATH, ORDER_API_PATH, parameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
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

  static Future<OrderModel> fetchOrderIdByOrderId({
    required int orderId,
    required String jwt,
  }) async {
    final response = await http.get(
      Uri.https(API_SERVER_PATH, '$ORDER_API_PATH/$orderId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
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
    required String jwt,
  }) async {
    final queryParameters = {
      'message': message,
      'locale': locale,
      'returnUrl': 'https://$API_SERVER_PATH$ORDER_RETURN_API_PATH'
    };

    // final response2 = await http.post(Uri.parse(
    //     'https://0842-171-250-113-73.ap.ngrok.io/v1/api/auth/demo-noti?userId=1'));
    // print(response2.body);

    final response = await http.post(
      Uri.https(API_SERVER_PATH, ORDER_PAYMENT_API_PATH, queryParameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
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
        // final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
        // pattern
        //     .allMatches(jsonDecode(response.body)['url'])
        //     .forEach((match) => print(match.group(0)));
        return jsonDecode(response.body)['url'];
      default:
        throw Exception('Error ${response.statusCode}, cannot payment');
    }
  }

  static Future<int> review({
    required int transactionId,
    required int star,
    required String review,
    required String jwt,
  }) async {
    final response = await http.put(
      Uri.https(API_SERVER_PATH, '$ORDER_API_PATH/review'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
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
