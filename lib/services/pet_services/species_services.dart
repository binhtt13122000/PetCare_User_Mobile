import 'dart:convert';

import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/models/species_model/species_model.dart';
import 'package:http/http.dart' as http;

class SpeciesService {
  static List<SpeciesModel> getSpeciesList(List<dynamic> jsonData) {
    final List<SpeciesModel> speciesList = List.empty(growable: true);
    for (var element in jsonData) {
      speciesList.add(SpeciesModel.fromJson(element));
    }
    return speciesList;
  }

  static Future<SpeciesModel> fetchSpeciesById({
    required int speciesId,
  }) async {
    final response = await http.get(
      Uri.https(API_SERVER_PATH, '$SPECIES_API_PATH/$speciesId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return SpeciesModel.fromJson(json.decode(response.body)['data']);
      default:
        throw Exception('Error ${response.statusCode}, cannot get species');
    }
  }

  static Future<List<SpeciesModel>> fetchSpeciesList(
      {bool isActive = true}) async {
    Map<String, dynamic> parameters = {'isActive': isActive.toString()};
    final response = await http.get(
      Uri.https(API_SERVER_PATH, SPECIES_API_PATH, parameters),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return getSpeciesList(json.decode(response.body)['data']);
      default:
        throw Exception('Error ${response.statusCode}, cannot get species');
    }
  }
}
