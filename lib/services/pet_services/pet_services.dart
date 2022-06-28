// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:http/http.dart' as http;
import 'package:petapp_mobile/models/pet_model/pet_model.dart';

class PetService {
  static List<PetModel> getPetList(List<dynamic> jsonData) {
    final List<PetModel> petList = List.empty(growable: true);
    for (var element in jsonData) {
      petList.add(PetModel.fromJson(element));
    }
    return petList;
  }

  static Future<List<PetModel>> fetchPetListByCustomerId(int customerId,
      {String? type, String? name}) async {
    Map<String, dynamic> parameters = {
      'customerId': customerId.toString(),
      'type': type,
      'name': name,
    };
    final response = await http.get(
      Uri.https(API_SERVER_PATH, '/v1/api/pets', parameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return getPetList(jsonDecode(response.body)['data']);
      default:
        throw Exception('Error ${response.statusCode}, cannot get pet list');
    }
  }

  static Future<List<PetModel>> fetchPetListToCreatePost(
      {required int customerId,
      int? speciesId,
      String? type,
      String? gender}) async {
    Map<String, String?> parameters = {
      'customerId': customerId.toString(),
      'speciesId': speciesId != null ? speciesId.toString() : "",
      'type': type,
      'gender': gender,
    };
    final response = await http.get(
      Uri.https(API_SERVER_PATH, '/v1/api/pets/fetch-pet', parameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return getPetList(jsonDecode(response.body)['data']);
      default:
        throw Exception('Error ${response.statusCode}, cannot get pet list');
    }
  }

  static Future<int> deletePetByPetId({required int petId}) async {
    final response = await http.delete(
      Uri.https(API_SERVER_PATH, '$PET_API_PATH/$petId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return jsonDecode(response.body)['data']['id'];
      default:
        throw Exception('Error ${response.statusCode}, cannot not delete pet');
    }
  }

  static Future createPet({
    required int ownerId,
    required String avatarFilePath,
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
        'file': await MultipartFile.fromFile(avatarFilePath),
      });

      Response response =
          await Dio().post('https://$API_SERVER_PATH/v1/api/pets',
              data: formData,
              options: Options(headers: <String, String>{
                HttpHeaders.contentTypeHeader: 'multipart/form-data',
              }));

      return response.statusCode;
    } on DioError catch (e) {
      return e.response!.statusCode;
    }
  }

  static Future updatePet({
    required int id,
    required int ownerId,
    required File? avatarFile,
    required String avatarFilePath,
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
      print({
        'id': id,
        'name': name,
        'dob': dob,
        'gender': gender,
        'description': description ?? '',
        'isSeed': isSeed,
        'status': status,
        'color': color ?? '',
        'breedId': breedId,
        'specialMarkings': specialMarkings ?? '',
        'vaccineDescription': vaccineDescription ?? '',
        'avatar': avatarFilePath,
      });
      formData = FormData.fromMap({
        'id': id,
        'name': name,
        'dob': dob,
        'gender': gender,
        'description': description ?? '',
        'isSeed': isSeed,
        'status': status,
        'color': color ?? '',
        'breedId': breedId,
        'specialMarkings': specialMarkings ?? '',
        'vaccineDescription': vaccineDescription ?? '',
        'avatar': avatarFilePath,
      });

      if (avatarFile != null) {
        formData.files.add(
          MapEntry(
            'file',
            await MultipartFile.fromFile(avatarFilePath),
          ),
        );
      }

      Response response =
          await Dio().put('https://$API_SERVER_PATH/v1/api/pets',
              data: formData,
              options: Options(headers: <String, String>{
                HttpHeaders.contentTypeHeader: 'multipart/form-data',
              }));
      print(response.toString());

      return response.statusCode;
    } on DioError catch (e) {
      print(e.error);
      print(e.error.toString());

      return e.response!.statusCode;
    }
  }

  static Future<List<PetModel>> fetchPetListToCreatePostByCustomerId({
    required int customerId,
    required String postType,
    int? speciesId,
  }) async {
    final Map<String, dynamic> parameters = {
      'customerId': customerId,
      'speciesId': speciesId
    };
    final response = await http.get(
      Uri.https(API_SERVER_PATH, PET_TO_CREATE_POST_API_PATH, parameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return getPetList(json.decode(response.body)['data']);
      default:
        throw Exception('Error ${response.statusCode}, cannot get pet list');
    }
  }

  static Future<PetModel> fetchPetById({required String petId}) async {
    final response = await http.get(
      Uri.https(API_SERVER_PATH, '$PET_API_PATH/$petId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return PetModel.fromJson(json.decode(response.body)['data']);
      default:
        throw Exception('Error ${response.statusCode}, cannot get pet');
    }
  }
}
