import 'package:get/get.dart';
import 'package:petapp_mobile/models/breed_model/breed_model.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';
import 'package:petapp_mobile/models/species_model/species_model.dart';

class PurchasePostsPageController extends GetxController {
  late RxList<PostModel> postList;

  List<dynamic> selectedGenderList = ['MALE', 'FEMALE'];

  RxMap<int, RxList<int>> selectedBreedMap = <int, RxList<int>>{}.obs;
  Map<int, RxList<BreedModel>> breedsMap = {};

  RxInt selectedSpeciesId = (-1).obs;
  late List<SpeciesModel> species;

  RxInt ltPrice = 999999999.obs;
  RxInt gtePrice = 0.obs;
  RxString selectedPrices = ''.obs;
  List<String> prices = [
    '< 1 milion',
    '1 milion → 4 milion',
    '4 milion → 7 milion',
    '7 milion → 13 milion',
    '13 milion → 20 milion',
    '> 20 milion',
  ];

  RxInt ltAge = 999999999.obs;
  RxInt gteAge = 0.obs;
  RxString selectedAge = ''.obs;
  List<String> ages = [
    '< 6 month',
    '6 month → 12 month',
    '1 year → 2 year',
    '2 year → 4 year',
    '> 4 year',
  ];

  late RxString selectedSort;
  RxString orderByPrice = 'asc'.obs;
  RxString orderByBreed = ''.obs;
  List<String> sorts = [
    'Price: Low to High',
    'Price: High to Low',
    'Breed: A to Z',
    'Breed: Z to A',
  ];

  PurchasePostsPageController() {
    selectedSort = sorts[0].obs;
  }
}
