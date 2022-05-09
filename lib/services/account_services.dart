import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/customer_model/customer_model.dart';
import 'package:dio/dio.dart';
import 'dart:io';

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
      Uri.parse('http://10.1.72.127:4000/v1/api/auth/login/phone-number'),
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
        print(response.body);
        print('idtoken::::::' + idToken);
        print('device::::::' + userDeviceToken);
        return getAccount(json.decode(response.body)['data']);
      default:
        throw Exception('Error ${response.statusCode}, cannot login');
    }
  }

  static Future<bool> checkPhoneNumber({
    required String phoneNumber,
  }) async {
    final response = await http.get(
      Uri.parse(
          'http://10.1.72.127:4000/v1/api/auth/phone-number/$phoneNumber'),
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

  static Future register({
    required String email,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String adrress,
    required String gender,
    required String avatarFilePath,
    required String accessToken,
  }) async {
    try {
      FormData formData;
      formData = FormData.fromMap({
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'address': adrress,
        'gender': gender,
        'password': '213123',
        'conFirmPassword': '213123',
        'dateOfBirth': DateTime.now(),
        'accessToken': accessToken,
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
          await Dio().post('http://10.1.72.127:4000/v1/api/auth/register',
              data: formData,
              options: Options(headers: <String, String>{
                HttpHeaders.contentTypeHeader: 'multipart/form-data',
              }));

      return response.data;
    } on DioError catch (e) {
      print(e.error + e.response!.data.toString());
      return e.response!.statusCode;
    }
  }
}
