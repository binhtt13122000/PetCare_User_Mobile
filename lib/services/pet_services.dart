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

  static Future INSERT_PET(
      {required int accountId,
      required String filePath,
      required String name,
      required bool isSeed,
      required String gender,
      required DateTime dob,
      required String description,
      required int categoryId,
      required int ageRange}) async {
    try {
      FormData formData;
      formData = FormData.fromMap({
        'ageRange': ageRange,
        'breedId': categoryId,
        'color': 'black',
        'vaccineDescription': '',
        'description': description,
        'dob': dob,
        'gender': gender,
        'isSeed': isSeed,
        'name': name,
        'specialMarkings': '',
        'status': 'NOT_VERIFIED',
        'ownerId': accountId,
        'file': await MultipartFile.fromFile(filePath),
      });

      Response response = await Dio().post('$API_SERVER/pets',
          data: formData,
          options: Options(headers: <String, String>{
            HttpHeaders.contentTypeHeader: 'multipart/form-data',
          }));

      return response.statusCode;
    } on DioError catch (e) {
      print(e.error);
      return e.response!.statusCode;
    }
  }
}
