import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petapp_mobile/configs/path.dart';

class PetComboDetailServices {
  static Future<int> updatePetComboDetail({
    required int id,
    DateTime? realTime,
    bool isCompleted = true,
    int star = 0,
    String review = '',
  }) async {
    Map<String, dynamic> jsonBody = {
      'id': id,
      'isCompleted': isCompleted,
      'star': star,
      'review': review,
    };

    if (realTime != null) {
      jsonBody.addAll({'realTime': realTime.toIso8601String()});
    }

    final response = await http.put(
      Uri.http(API_SERVER_PATH, PET_COMBO_DETAIL_API_PATH),
      headers: <String, String>{
        'Content-Type': 'multipart/form-data; charset=UTF-8'
      },
      body: jsonEncode(jsonBody),
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return jsonDecode(response.body)['data']['id'];
      default:
        throw Exception(
            'Error ${response.statusCode}, cannot update pet combo detail');
    }
  }
}
