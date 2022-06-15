import 'dart:convert';

import 'package:petapp_mobile/configs/path.dart';
import 'package:http/http.dart' as http;
import 'package:petapp_mobile/models/pet_health_records_model/pet_health_records_model.dart';

class PetHealthRecordsServices {
  static List<PetHealthRecordModel> getPetHealthRecordList(
      List<dynamic> jsonData) {
    final List<PetHealthRecordModel> petHealthRecordList =
        List.empty(growable: true);
    for (var element in jsonData) {
      petHealthRecordList.add(PetHealthRecordModel.fromJson(element));
    }
    return petHealthRecordList;
  }

  static Future<List<PetHealthRecordModel>> fetchPetHealthRecordList({
    required String petId,
    required String type,
  }) async {
    Map<String, dynamic> parameters = {
      'petId': petId,
      'type': type,
    };

    final response = await http.get(
      Uri.http(API_SERVER_PATH, PET_HEALTH_RECORD_API_PATH, parameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return getPetHealthRecordList(json.decode(response.body)['data']);
      default:
        throw Exception(
            'Error ${response.statusCode}, cannot get pet health record list');
    }
  }
}
