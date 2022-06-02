import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/branch_model/branch_model.dart';
import 'package:petapp_mobile/models/breed_model/breed_model.dart';
import 'package:petapp_mobile/models/media_model/media_model.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:petapp_mobile/models/species_model/species_model.dart';
import 'package:petapp_mobile/models/transaction_fees_model/transaction_fees_model.dart';

class UpdateSalePostPageController extends GetxController {
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController receiveMoneyEditingController = TextEditingController();
  TextEditingController depositEditingController = TextEditingController();
  late PostModel postModel;
  ScrollController mainScrollController = ScrollController();
  AccountModel accountModel = Get.find<AuthController>().accountModel;

  RxBool isShowPurchaseTransactionFeees = false.obs;
  late List<TransactionFeesModel> listPurchaseTransactionFees;
  RxInt selectedPurchaseTransactionFeesId = (-1).obs;
  RxBool isShowMainLoading = false.obs;
  RxBool isLoadingBranch = false.obs;
  RxBool isShowLoadingPet = false.obs;
  RxBool isShowLoadingPetSpecies = false.obs;
  RxBool isLoadingBreeds = false.obs;
  RxList<File> evidences = <File>[].obs;
  RxList<MediaModel> evidencesPath = <MediaModel>[].obs;
  RxString title = ''.obs;
  RxString description = ''.obs;
  RxInt price = 0.obs;
  RxInt deposit = 0.obs;
  RxString selectedPostType = 'SALE'.obs;

  bool isFirstInputTitle = true;
  RxBool isShowPetFilter = false.obs;
  RxBool isShowPetDropdownList = false.obs;
  RxString receivedMoney = ''.obs;
  RxBool isShowLoadingWidget = false.obs;
  RxBool isShowSuccessfullyPopup = false.obs;
  List<BranchModel> branchList = [];
  RxInt selectedBranchId = (-1).obs;

  quill.QuillController quillController = quill.QuillController.basic();

  int? selectedSpeciesId;
  late List<SpeciesModel> species;

  Map<int, int> selectedBreedMap = <int, int>{};
  Map<int, List<BreedModel>> breedsMap = <int, List<BreedModel>>{};

  late List<PetModel> pets;
  RxList<int> deletedIds = <int>[].obs;
  RxInt selectedPetId = (-1).obs;
}
