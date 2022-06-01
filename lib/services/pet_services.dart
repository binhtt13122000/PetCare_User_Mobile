// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:petapp_mobile/configs/path.dart';

import 'package:petapp_mobile/models/pet_model/pet_model.dart';
import 'package:http/http.dart' as http;

class PetService {
  static PetModel getPet(Map<String, dynamic> jsonData) =>
      PetModel.fromJson(jsonData);

  static List<PetModel> getPetList(Map<String, dynamic> jsonData) {
    final petListJson = jsonData['pet'] as List;
    final List<PetModel> petList = List.empty(growable: true);
    for (var element in petListJson) {
      petList.add(getPet(element));
    }
    return petList;
  }

  static List<PetModel> getPetListByCustomerId(Map<String, dynamic> jsonData) {
    final petListJson = jsonData['data'] as List;
    final List<PetModel> petList = List.empty(growable: true);
    for (var element in petListJson) {
      petList.add(PetModel.fromJson(element));
    }
    return petList;
  }

  static Future<List<PetModel>> fetchPetListByCustomerId(int customerId) async {
    Map<String, String> parameters = {
      'customerId': customerId.toString(),
    };
    final response = await http.get(
      Uri.http(API_SERVER_PATH, '/v1/api/pets', parameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        print(jsonDecode(response.body));
        return getPetListByCustomerId(jsonDecode(response.body));
      default:
        throw Exception('Error ${response.statusCode}, cannot get pet list');
    }
  }

  static Future<List<PetModel>> fetchPetListToCreatePost(
      int customerId, int? speciesId) async {
    Map<String, String> parameters = {
      'customerId': customerId.toString(),
      'speciesId': speciesId != null ? speciesId.toString() : "",
    };
    final response = await http.get(
      Uri.http(API_SERVER_PATH, '/v1/api/pets/fetch-pet', parameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return getPetListByCustomerId(jsonDecode(response.body));
      default:
        throw Exception('Error ${response.statusCode}, cannot get pet list');
    }
  }

  static Future createPet({
    required int ownerId,
    required String avtarFilePath,
    required String name,
    required bool isSeed,
    required String gender,
    required DateTime dob,
    String? description,
    required int breedId,
    required String status,
    String? color,
    String? specialMarkings,
    String? vaccineDescription,
  }) async {
    try {
      FormData formData;
      formData = FormData.fromMap({
        'name': name,
        'dob': dob,
        'gender': gender,
        'description': description ?? '',
        'isSeed': isSeed,
        'status': status,
        'color': color ?? '',
        'breedId': breedId,
        'ownerId': ownerId,
        'specialMarkings': specialMarkings ?? '',
        'vaccineDescription': vaccineDescription ?? '',
        'file': await MultipartFile.fromFile(avtarFilePath),
      });

      Response response =
          await Dio().post('http://$API_SERVER_PATH/v1/api/pets',
              data: formData,
              options: Options(headers: <String, String>{
                HttpHeaders.contentTypeHeader: 'multipart/form-data',
              }));
      print(response.data);

      return response.statusCode;
    } on DioError catch (e) {
      print(e.error);
      return e.response!.statusCode;
    }
  }
}
