import 'dart:convert';

import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/models/customer_model/customer_model.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class CustomerService {
  static Future<CustomerModel> fetchCustomerById(int customerId) async {
    final response = await http.get(
      Uri.http(API_SERVER_PATH, '$CUSTOMER_API_PATH/$customerId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
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

  static Future<CustomerModel?> updateProfile({
    required int id,
    required String email,
    required String firstName,
    required String lastName,
    required String address,
    required String gender,
    required String avatarFilePath,
    required File? avatarFile,
  }) async {
    try {
      FormData formData;
      formData = FormData.fromMap({
        'id': id,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'address': address,
        'gender': gender,
        'bankName': "",
        'bankCode': "",
        'bankBranch': "",
        'avatar': avatarFilePath,
      });
      avatarFile == null
          ? null
          : formData.files.add(
              MapEntry(
                'file',
                await MultipartFile.fromFile(avatarFilePath),
              ),
            );

      Response response =
          await Dio().put('http://$API_SERVER_PATH$CUSTOMER_API_PATH',
              data: formData,
              options: Options(headers: <String, String>{
                HttpHeaders.contentTypeHeader: 'multipart/form-data',
              }));

      switch (response.statusCode) {
        case 200:
        case 201:
        case 202:
          print(response.data);
          return CustomerModel.fromJson(response.data['data']);
        default:
          print(response.data);
      }
    } on DioError catch (e) {
      print(e.error + e.response!.data.toString());
    }
    return null;
  }
}
