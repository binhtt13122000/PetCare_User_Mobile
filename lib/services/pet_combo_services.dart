import 'dart:convert';

import 'package:petapp_mobile/configs/path.dart';
import 'package:http/http.dart' as http;

class PetComboServices {
  static Future<String> payment({
    required String message,
    required String locale,
    required String paymentMethod,
    required int comboId,
    required int orderTotal,
    required DateTime paymentTime,
    required DateTime registerTime,
    // int? promotionId,
    // int? paymentPoint,
    //required int provisionalTotal,
    required int branchId,
    required int customerId,
  }) async {
    final queryParameters = {
      'message': message,
      'locale': locale,
      'returnUrl': 'http://$API_SERVER_PATH$PET_COMBO_RETURN_API_PATH'
    };

    final response = await http.post(
      Uri.http(API_SERVER_PATH, PET_COMBO_API_PATH, queryParameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'orderTotal': orderTotal,
        'branchId': branchId,
        'customerId': customerId,
        'point': orderTotal ~/ 1000,
        'paymentTime': paymentTime.toIso8601String(),
        'paymentMethod': paymentMethod,
        'comboId': comboId,
        "petId": 30,
        'registerTime': registerTime.toIso8601String(),
      }),
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return jsonDecode(response.body)['data']['url'];
      default:
        throw Exception('Error ${response.statusCode}, cannot payment');
    }
  }
}
