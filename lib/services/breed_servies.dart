import 'package:petapp_mobile/models/breed_model/breed_model.dart';

class BreedService {
  static BreedModel getBreed(Map<String, dynamic> jsonData) =>
      BreedModel.fromJson(jsonData);

  static List<BreedModel> getBreedList(Map<String, dynamic> jsonData) {
    final breedListJson = jsonData['Breed'] as List;
    final List<BreedModel> breedList = List.empty(growable: true);
    for (var element in breedListJson) {
      breedList.add(getBreed(element));
    }
    return breedList;
  }
}
