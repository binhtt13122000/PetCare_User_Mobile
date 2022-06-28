import 'dart:convert';

import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/models/breed_model/breed_model.dart';
import 'package:http/http.dart' as http;

class BreedService {
  static List<BreedModel> getBreedList(List<dynamic> jsonData) {
    final List<BreedModel> breedList = List.empty(growable: true);
    for (var element in jsonData) {
      breedList.add(BreedModel.fromJson(element));
    }
    return breedList;
  }

  static Future<BreedModel> fetchBreedById({
    required int breedId,
  }) async {
    final response = await http.get(
      Uri.https(API_SERVER_PATH, '$BREED_API_PATH/$breedId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return BreedModel.fromJson(json.decode(response.body)['data']);
      default:
        throw Exception('Error ${response.statusCode}, cannot get breed');
    }
  }

  static Future<List<BreedModel>> fetchBreedListBySpeciesId({
    required int speciesId,
  }) async {
    final response = await http.get(
      Uri.https(API_SERVER_PATH, '$BREED_API_PATH/species/$speciesId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        return getBreedList(json.decode(response.body)['data']);
      default:
        throw Exception('Error ${response.statusCode}, cannot get breed');
    }
  }
}
