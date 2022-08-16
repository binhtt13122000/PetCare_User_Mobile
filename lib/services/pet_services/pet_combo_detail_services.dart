import 'dart:convert';
import 'dart:io';
import 'package:petapp_mobile/configs/path.dart';
import 'package:http/http.dart' as http;

class PetComboDetailServices {
  static Future<bool> updatePetComboDetail(
      {required int id,
      required DateTime realTime,
      required bool isCompleted,
      int star = 0,
      String review = '',
      required bool isAllCompleted,
      required String jwt}) async {
    final response = await http.put(
      Uri.https(API_SERVER_PATH, PET_COMBO_DETAIL_API_PATH),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // HttpHeaders.contentTypeHeader: 'multipart/form-data',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
      },
      body: jsonEncode(
        {
          'id': id,
          'isCompleted': isCompleted,
          'star': star,
          'review': review,
          'isAllCompleted': isAllCompleted,
          'realTime': realTime.toIso8601String(),
        },
      ),
    );
    print(response.body);
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return true;
      default:
        return false;
    }
    // try {
    //   Map<String, dynamic> jsonData = {
    //     'id': id,
    //     'isCompleted': isCompleted,
    //     'star': star,
    //     'review': review,
    //     'isAllCompleted': isAllCompleted,
    //   };
    //   // print(jsonData);
    //   // return true;
    //   if (realTime != null) {
    //     jsonData.addAll({'realTime': realTime.toIso8601String()});
    //   }
    //   FormData formData;
    //   formData = FormData.fromMap(jsonData);
    //   Response response =
    //       await Dio().put('https://$API_SERVER_PATH$PET_COMBO_DETAIL_API_PATH',
    //           data: formData,
    //           options: Options(headers: <String, String>{
    //             HttpHeaders.contentTypeHeader: 'multipart/form-data',
    //             HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
    //           }));
    //   switch (response.statusCode) {
    //     case 200:
    //     case 201:
    //     case 202:
    //       return response.data['success'];
    //     default:
    //       return false;
    //   }
    // } on DioError catch (_) {
    //   return false;
    // }
  }

  // static Future<bool> updatePetComboDetail({
  //   required int id,
  //   DateTime? realTime,
  //   bool isCompleted = true,
  //   int star = 0,
  //   String review = '',
  // }) async {
  //   Map<String, dynamic> jsonBody = {
  //     'id': id,
  //     'isCompleted': isCompleted,
  //     'star': star,
  //     'review': review,
  //   };

  //   if (realTime != null) {
  //     jsonBody.addAll({'realTime': realTime.toIso8601String()});
  //   }

  //   final response = await http.put(
  //     Uri.https(API_SERVER_PATH, PET_COMBO_DETAIL_API_PATH),
  //     headers: <String, String>{'Content-Type': 'multipart/form-data'},
  //     body: jsonBody,
  //   );
  //   switch (response.statusCode) {
  //     case 200:
  //     case 201:
  //     case 202:
  //       return jsonDecode(response.body)['success'];
  //     default:
  //       throw Exception(
  //           'Error ${response.statusCode}, cannot update pet combo detail');
  //   }
  // }
}
