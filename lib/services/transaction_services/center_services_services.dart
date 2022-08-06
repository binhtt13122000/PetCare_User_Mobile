import 'dart:convert';
import 'dart:io';

import 'package:petapp_mobile/configs/path.dart';
import 'package:http/http.dart' as http;
import 'package:petapp_mobile/models/center_service_model/center_service_model.dart';

class CenterServicesServices {
  static Future<List<CenterServiceModel>> fetchCenterServicesList({
    required String jwt,
  }) async {
    final response = await http.get(
      Uri.https(API_SERVER_PATH, CENTER_SERVICES_API),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + jwt,
      },
    );

    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return getCenterServicesModelList(json.decode(response.body)['data']);
      default:
        throw Exception(
            'Error ${response.statusCode}, cannot not get center services list');
    }
  }

  static List<CenterServiceModel> getCenterServicesModelList(
      List<dynamic> jsonData) {
    final List<CenterServiceModel> centerServicesList = [];
    for (var element in jsonData) {
      centerServicesList.add(CenterServiceModel.fromJson(element));
    }
    return centerServicesList;
  }
}
