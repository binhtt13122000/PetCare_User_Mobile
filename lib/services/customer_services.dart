import 'dart:convert';

import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/customer_model/customer_model.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class CustomerService {

  static Future<CustomerModel?> updateProfile({
    required int id,
    required String email,
    required String firstName,
    required String lastName,
    required String adrress,
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
        'address': adrress,
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
      Response response = await Dio().put('http://$API_SERVER/v1/api/customer',
          data: formData,
          options: Options(headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'multipart/form-data',
          }));

      switch (response.statusCode) {
        case 200:
        case 201:
        case 202:
          return response.data;
        default:
          print(response.data);
      }
    } on DioError catch (e) {
      print(e.error + e.response!.data.toString());
      return null;
    }
    return null;
  }
}
