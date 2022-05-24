// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:petapp_mobile/configs/path.dart';

import 'package:petapp_mobile/models/pet_model/pet_model.dart';

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

      Response response = await Dio().post('http://$API_SERVER/v1/api/pets',
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
