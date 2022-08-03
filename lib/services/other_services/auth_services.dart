import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/customer_model/customer_model.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class AuthService {
  static Future<String> signOut({
    required int accountId,
    required String deviceToken,
    required String jwt,
  }) async {
    final response = await http.post(
      Uri.https(API_SERVER_PATH, '$AUTH_API_PATH/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
      },
      body: jsonEncode({
        'id': accountId,
        'fcmToken': deviceToken,
      }),
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return json.decode(response.body)['data']['status'];
      default:
        throw Exception('Error ${response.statusCode}, cannot sign out');
    }
  }

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
      Uri.https(API_SERVER_PATH, AUTH_SIGN_IN_API_PATH),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'accessToken': idToken,
        'fcmToken': userDeviceToken,
      }),
    );

    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        if (json.decode(response.body)['data']['status'] == 'SUCCESS') {
          return getAccount(json.decode(response.body)['data']);
        } else {
          return null;
        }
      default:
        return null;
    }
  }

  static Future<bool> checkPhoneNumber({
    required String phoneNumber,
  }) async {
    final response = await http.get(
      Uri.https(API_SERVER_PATH, '/v1/api/auth/phone-number/$phoneNumber'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return json.decode(response.body)['data'];
      default:
        throw Exception('Error ${response.statusCode}, cannot login');
    }
  }

  static Future<AccountModel?> register({
    required String email,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String address,
    required String gender,
    required String avatarFilePath,
    required String accessToken,
    required String deviceToken,
    required DateTime registerTime,
    DateTime? dateOfBirth,
  }) async {
    try {
      FormData formData;
      formData = FormData.fromMap({
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'address': address,
        'gender': gender,
        'accessToken': accessToken,
        'fcmToken': deviceToken,
        'registerTime': registerTime.toIso8601String(),
        'dateOfBirth': dateOfBirth?.toIso8601String(),
      });
      avatarFilePath.isNotEmpty
          ? formData.files.add(
              MapEntry(
                'file',
                await MultipartFile.fromFile(avatarFilePath),
              ),
            )
          : null;
      Response response =
          await Dio().post('https://$API_SERVER_PATH/v1/api/auth/register',
              data: formData,
              options: Options(headers: <String, String>{
                HttpHeaders.contentTypeHeader: 'multipart/form-data',
              }));

      switch (response.statusCode) {
        case 200:
        case 201:
        case 202:
          return getAccount(response.data['data']);
        default:
          return null;
      }
    } on DioError catch (_) {
      return null;
    }
  }
}
