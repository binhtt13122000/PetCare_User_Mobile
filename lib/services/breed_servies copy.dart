import 'dart:convert';

import 'package:petapp_mobile/configs/path.dart';
import 'package:http/http.dart' as http;
import 'package:petapp_mobile/models/breed_model/breed_model.dart';

class BreedService {
  static BreedModel getBreed(Map<String, dynamic> jsonData) =>
      BreedModel.fromJson(jsonData);

  static List<BreedModel> getBreedList(Map<String, dynamic> jsonData) {
    final breedListJson = jsonData['breed'] as List;
    final List<BreedModel> breedList = List.empty(growable: true);
    for (var element in breedListJson) {
      breedList.add(getBreed(element));
    }
    return breedList;
  }

  static Future<BreedModel> fecthBreedById({
    required int breedId,
  }) async {
    final response = await http.get(
      Uri.http(API_SERVER, '$GET_BREED/$breedId'),
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
}
