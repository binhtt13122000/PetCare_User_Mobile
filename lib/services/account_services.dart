import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petapp_mobile/models/account_model/account_model.dart';

class AccountService {
  static AccountModel getAccount(Map<String, dynamic> jsonData) {
    Map<String, dynamic> userJson = jsonData['user'];
    AccountModel accountModel = AccountModel.fromJson(userJson);
    accountModel.jwtToken = jsonData['accessToken'];
    return accountModel;
  }

  static Future<AccountModel?> signIn({
    required String idToken,
    required String userDeviceToken,
  }) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:4000/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'accessToken': idToken,
        'loginType': 1,
        'fcmToken': userDeviceToken,
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
