import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/models/species_model/species_model.dart';

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
}
