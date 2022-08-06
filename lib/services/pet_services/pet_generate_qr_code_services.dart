// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:petapp_mobile/configs/path.dart';
import 'package:http/http.dart' as http;

class PetGenerateQrCodeService {
  static Future<String> fetchDeepLinkFromPetId({
    required String petId,
    required String jwt,
  }) async {
    final response = await http.post(
      Uri.https(API_SERVER_PATH, '/v1/api/deep-link/$petId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
      },
    );
    print(response.body);
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return jsonDecode(response.body)['data']['shortLink'];
      default:
        throw Exception(
            'Error ${response.statusCode}, cannot get pet deep link');
    }
  }
}
