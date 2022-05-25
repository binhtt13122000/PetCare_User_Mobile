import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petapp_mobile/configs/path.dart';

class PaymentServices {
  static Future<String> payment({
    required String message,
    required String locale,
    required String paymentMethod,
    required int transactionId,
    required int customerId,
    required int branchId,
    required int orderTotal,
    required DateTime paymentTime,
  }) async {
    final queryParameters = {
      'message': message,
      'locale': locale,
      'returnUrl': 'http://$API_SERVER/v1/api/orders/vnpay_return'
    };

    final response = await http.post(
      Uri.http(API_SERVER, '/v1/api/orders/payment', queryParameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "orderTotal": orderTotal,
        "branchId": branchId,
        "customerId": customerId,
        "id": transactionId,
        "paymentTime": paymentTime.toIso8601String(),
        "paymentMethod": paymentMethod,
        "payment": orderTotal,
        'point': orderTotal ~/ 100000
      }),
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return jsonDecode(response.body)['data']['url'];
      default:
        print(response.body);
        throw Exception('Error ${response.statusCode}, cannot payment');
    }
  }
}
