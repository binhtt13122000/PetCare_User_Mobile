import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/customer_model/customer_model.dart';

class AccountService {
  static AccountModel getAccount(Map<String, dynamic> jsonData) {
    Map<String, dynamic> userJson = jsonData['user'];
    AccountModel accountModel = AccountModel.fromJson(userJson);
    accountModel.jwtToken = jsonData['accessToken'];
    accountModel.refreshToken = jsonData['refreshToken'];
    accountModel.customerModel =
        CustomerModel.fromJson(jsonData['information']);
    return accountModel;
  }

  static Future<AccountModel?> signIn({
    required String idToken,
    required String userDeviceToken,
  }) async {
    final response = await http.post(
      Uri.parse('http://192.168.137.1:4000/v1/api/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'accessToken': idToken,
        'loginType': 1,
        'fcmToken': userDeviceToken,
        'role': 'CUSTOMER'
      }),
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return getAccount(json.decode(response.body)['data']);
      default:
        throw Exception('Error ${response.statusCode}, cannot login');
    }
  }
}
