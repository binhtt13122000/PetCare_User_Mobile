import 'dart:convert';

import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/models/customer_model/customer_model.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class CustomerService {
  static Future<CustomerModel> fetchCustomerById(
    int customerId, {
    required String jwt,
  }) async {
    final response = await http.get(
      Uri.https(API_SERVER_PATH, '$CUSTOMER_API_PATH/$customerId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return CustomerModel.fromJson(jsonDecode(response.body)['data']);
      default:
        throw Exception('Error ${response.statusCode}, cannot get customer');
    }
  }

  static Future<CustomerModel?> updateProfile(
      {required int id,
      required String email,
      required String firstName,
      required String lastName,
      required String address,
      required String gender,
      required String avatarFilePath,
      required String bankName,
      required String bankCode,
      required String bankBranch,

      // required File? avatarFile,
      required String jwt}) async {
    try {
      FormData formData;
      formData = FormData.fromMap({
        'id': id,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'address': address,
        'gender': gender,
        'bankName': bankName,
        'bankCode': bankCode,
        'bankBranch': bankBranch,
        //'avatar': avatarFilePath,
      });
      print({
        'id': id,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'address': address,
        'gender': gender,
        'bankName': bankName,
        'bankCode': bankCode,
        'bankBranch': bankBranch,
        //'avatar': avatarFilePath,
      });
      if (avatarFilePath.isNotEmpty) {
        formData.files.add(
          MapEntry(
            'file',
            await MultipartFile.fromFile(avatarFilePath),
          ),
        );
      }

      Response response =
          await Dio().put('https://$API_SERVER_PATH$CUSTOMER_API_PATH',
              data: formData,
              options: Options(headers: <String, String>{
                HttpHeaders.contentTypeHeader: 'multipart/form-data',
                HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
              }));

      switch (response.statusCode) {
        case 200:
        case 201:
        case 202:
          return CustomerModel.fromJson(response.data['data']);
        default:
      }
    } on DioError catch (_) {}
    return null;
  }
}
