import 'dart:convert';

import 'package:petapp_mobile/configs/path.dart';
import 'package:http/http.dart' as http;

class PolicyServices {
  static Future<String> fetchPolicy() async {
    final response = await http.get(
      Uri.https(API_SERVER_PATH, '/v1/api/configurations/policy'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return jsonDecode(response.body)['data'];
      default:
        return '';
    }
  }
}
