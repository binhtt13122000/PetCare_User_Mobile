import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/models/services_combo_model/services_combo_model.dart';

class ServicesComboModelServices {
  static List<ServicesComboModel> getServicesComboModelList(
      List<dynamic> jsonData) {
    final List<ServicesComboModel> servicesComboModelList =
        List.empty(growable: true);
    for (var element in jsonData) {
      servicesComboModelList.add(ServicesComboModel.fromJson(element));
    }
    return servicesComboModelList;
  }

  static Future<List<ServicesComboModel>> fetchServicesComboList() async {
    final response = await http.get(
      Uri.http(API_SERVER_PATH, SERVICES_COMBO_API_PATH),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return getServicesComboModelList(json.decode(response.body)['data']);
      default:
        throw Exception(
            'Error ${response.statusCode}, cannot get services combo list');
    }
  }

  static Future<ServicesComboModel> fetchServicesComboById(
      {required int id}) async {
    final response = await http.get(
      Uri.http(API_SERVER_PATH, '$SERVICES_COMBO_API_PATH/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return ServicesComboModel.fromJson(json.decode(response.body)['data']);
      default:
        throw Exception(
            'Error ${response.statusCode}, cannot get services combo');
    }
  }
}
