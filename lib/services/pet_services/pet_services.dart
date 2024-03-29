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

  static Future<List<PetModel>> fetchPetListByCustomerId(
    int customerId, {
    String? type,
    String? name,
    required String jwt,
  }) async {
    Map<String, dynamic> parameters = {
      'customerId': customerId.toString(),
      'type': type,
      'name': name,
    };
    final response = await http.get(
      Uri.https(API_SERVER_PATH, '/v1/api/pets', parameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
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

  static Future<List<PetModel>> fetchPetListToCreatePost({
    required int customerId,
    int? speciesId,
    String? type,
    String? gender,
    required String jwt,
    int? breedId,
  }) async {
    Map<String, String?> parameters = {
      'customerId': customerId.toString(),
      'type': type ?? 'NORMAL',
      'gender': gender,
    };
    if (breedId != null) {
      parameters.addAll({'breedId': breedId.toString()});
    } else if (speciesId != null) {
      parameters.addAll({
        'speciesId': speciesId.toString(),
      });
    }
    print(parameters);

    final response = await http.get(
      Uri.https(API_SERVER_PATH, '/v1/api/pets/fetch-pet', parameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
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

  static Future deletePetByPetId({
    required int petId,
    required String jwt,
  }) async {
    final response = await http.delete(
      Uri.https(API_SERVER_PATH, '$PET_API_PATH/$petId'),
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

      default:
    }
  }

  static Future<bool> createPet(
      {required int ownerId,
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
      required String jwt}) async {
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

      await Dio().post('https://$API_SERVER_PATH/v1/api/pets',
          data: formData,
          options: Options(headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'multipart/form-data',
            HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
          }));

      return true;
    } on DioError catch (_) {
      return false;
    }
  }

  static Future<bool> updatePet(
      {required int id,
      //required int ownerId,
      //required File? avatarFile,
      required String avatarFilePath,
      required String name,
      required bool isSeed,
      required String gender,
      required DateTime dob,
      String? description,
      // required int breedId,
      //required String status,
      String? color,
      //String? specialMarkings,
      //String? vaccineDescription,
      required String jwt}) async {
    try {
      FormData formData;

      formData = FormData.fromMap({
        'id': id,
        'name': name,
        'dob': dob,
        'gender': gender,
        'description': description ?? '',
        'isSeed': isSeed,
        //'status': status,
        'color': color ?? '',
        //'breedId': breedId,
        //'specialMarkings': specialMarkings ?? '',
        //'avatar': avatarFilePath,
      });
      print({
        'id': id,
        'name': name,
        'dob': dob,
        'gender': gender,
        'description': description ?? '',
        'isSeed': isSeed,
        //'status': status,
        'color': color ?? '',
        //'breedId': breedId,
        //'specialMarkings': specialMarkings ?? '',
        //'avatar': avatarFilePath,
      });
      if (avatarFilePath.isNotEmpty) {
        formData.files.add(
          MapEntry(
            'file',
            await MultipartFile.fromFile(avatarFilePath),
          ),
        );
      }

      await Dio().put('https://$API_SERVER_PATH/v1/api/pets',
          data: formData,
          options: Options(headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'multipart/form-data',
            HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
          }));

      return true;
    } on DioError catch (e) {
      print(e.response);
      return false;
    }
  }

  static Future<List<PetModel>> fetchPetListToCreatePostByCustomerId({
    required int customerId,
    required String postType,
    int? speciesId,
    required String jwt,
  }) async {
    final Map<String, dynamic> parameters = {
      'customerId': customerId,
      'speciesId': speciesId
    };
    final response = await http.get(
      Uri.https(API_SERVER_PATH, PET_TO_CREATE_POST_API_PATH, parameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
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

  static Future<PetModel> fetchPetById({
    required String petId,
    required String jwt,
  }) async {
    final response = await http.get(
      Uri.https(API_SERVER_PATH, '$PET_API_PATH/$petId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
      },
    );
    print(Uri.https(API_SERVER_PATH, '$PET_API_PATH/$petId').path);
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return PetModel.fromJson(json.decode(response.body)['data']);
      default:
        print(response.body);
        throw Exception('Error ${response.statusCode}, cannot get pet');
    }
  }
}
