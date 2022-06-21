// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'package:petapp_mobile/configs/path.dart';
import 'package:http/http.dart' as http;
import 'package:petapp_mobile/models/pet_chain_model/pet_chain_model.dart';

class PetGenerateQrCodeService {
  static Future<String> fetchDeepLinkFromPetId(
      {required String petId}) async {
    final response = await http.post(
      Uri.http(API_SERVER_PATH, '/v1/api/deep-link/$petId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        print("TETD" + jsonDecode(response.body)['data']['shortLink']);
        return jsonDecode(response.body)['data']['shortLink'];
      default:
        throw Exception('Error ${response.statusCode}, cannot get pet deep link');
    }
  }

}
