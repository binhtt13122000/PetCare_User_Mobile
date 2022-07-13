// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:petapp_mobile/configs/enum_config.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/breed_model/breed_model.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';
import 'package:petapp_mobile/models/post_model_hasura/post_model_hasura.dart';
import 'package:petapp_mobile/models/species_model/species_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostListPageController extends GetxController {
  RxBool isLoadingData = false.obs;
  String loadingType = LoadingType.INIT.name;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  int offset = 0;
  final int limit = 8;

  RxList<PostModel> postList = <PostModel>[].obs;
  RxList<PostModelHasura> postHasuraList = <PostModelHasura>[].obs;
  RxString searchText = ''.obs;

  AccountModel accountModel = Get.find<AuthController>().accountModel;

  List<dynamic> selectedGenderList = ['MALE', 'FEMALE'];
  RxBool isShowLoadingPurchasePost = false.obs;

  RxMap<int, RxList<int>> selectedBreedMap = <int, RxList<int>>{}.obs;
  Map<int, List<BreedModel>> breedsMap = <int, List<BreedModel>>{};

  RxInt selectedSpeciesId = (-1).obs;
  late List<SpeciesModel> species;
  RxBool isShowLoadingPetSpecies = false.obs;
  RxBool isShowLoadingBreeds = false.obs;

  RxInt ltPrice = 999999999.obs;
  RxInt gtePrice = 0.obs;
  RxString selectedPrices = ''.obs;
  List<String> prices = [
    '< 1 million',
    '1 million → 4 million',
    '4 million → 7 million',
    '7 million → 13 million',
    '13 million → 20 million',
    '> 20 million',
  ];

  RxString lteDob = 'now()'.obs;
  RxString gteDob = '1700-01-01'.obs;
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

  PostListPageController() {
    selectedSort = sorts[0].obs;
  }
}
