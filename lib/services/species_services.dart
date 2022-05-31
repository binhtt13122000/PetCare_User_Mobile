import 'dart:convert';

import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/models/species_model/species_model.dart';
import 'package:http/http.dart' as http;

class SpeciesService {
  static SpeciesModel getSpecies(Map<String, dynamic> jsonData) {
    SpeciesModel speciesModel = SpeciesModel.fromJson(jsonData);
    switch (speciesModel.name) {
      case 'Dog':
      case 'Chó':
        speciesModel.imageUrl = IMAGE_PATH + DOG_PNG;
        break;
      case 'Cat':
      case 'Mèo':
        speciesModel.imageUrl = IMAGE_PATH + CAT_PNG;
        break;
      case 'Fish':
      case 'Cá':
        speciesModel.imageUrl = IMAGE_PATH + FISH_PNG;
        break;
      case 'Bird':
      case 'Chim':
        speciesModel.imageUrl = IMAGE_PATH + BIRD_PNG;
        break;
      case 'Iguana':
      case 'Thằn lằn':
        speciesModel.imageUrl = IMAGE_PATH + IGUANA_PNG;
        break;
      default:
        speciesModel.imageUrl = null;
    }
    return speciesModel;
  }

  static List<SpeciesModel> getSpeciesList(Map<String, dynamic> jsonData) {
    final speciesListJson = jsonData['species'] as List;
    final List<SpeciesModel> speciesList = List.empty(growable: true);
    for (var element in speciesListJson) {
      speciesList.add(getSpecies(element));
    }
    return speciesList;
  }

  static Future<SpeciesModel> fecthSpeciesById({
    required int speciesId,
  }) async {
    final response = await http.get(
      Uri.http(API_SERVER_PATH, '$SPECIES_API_PATH/$speciesId'),
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
}
