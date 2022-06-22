// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'package:petapp_mobile/configs/path.dart';
import 'package:http/http.dart' as http;
import 'package:petapp_mobile/models/pet_chain_model/pet_chain_model.dart';

class PetChainService {
  static Future<PetChainModel?> fetchPetChainByPetId(
      {required String petId}) async {
    final response = await http.get(
      Uri.http(API_SERVER_PATH, '$PET_CHAIN_API/$petId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return PetChainModel.fromJson(jsonDecode(response.body)['data']);
      default:
        return null;
    }
  }

  static Future<PetChainModel> fetchPetChainByHashPetId(
      {required String petId}) async {
    final response = await http.get(
      Uri.http(API_SERVER_PATH, '$PET_CHAIN_HASH_API/$petId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return PetChainModel.fromJson(jsonDecode(response.body)['data']);
      default:
        throw Exception('Error ${response.statusCode}, cannot get pet chain');
    }
  }
}
