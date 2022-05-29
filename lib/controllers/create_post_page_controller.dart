// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/sign_in_page_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/branch_model/branch_model.dart';
import 'package:petapp_mobile/models/breed_model/breed_model.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';
import 'package:petapp_mobile/models/species_model/species_model.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:petapp_mobile/models/transaction_fees_model/transaction_fees_model.dart';

class CreatePostPageController extends GetxController {
  RxBool isShowPurchaseTransactionFeees = false.obs;
  late List<TransactionFeesModel> listPurchaseTransactionFees;
  RxInt selectedPurchaseTransactionFeesId = (-1).obs;
  RxBool isShowMainLoading = false.obs;
  RxBool isLoadingBranch = false.obs;
  RxBool isShowLoadingPet = false.obs;
  RxBool isShowLoadingPetSpecies = false.obs;
  RxList<File> evidences = <File>[].obs;
  RxList<String> evidencesPath = <String>[].obs;
  RxString title = ''.obs;
  String description = '';
  RxInt price = 0.obs;
  RxString deposit = ''.obs;
  RxString selectedPostType = 'PURCHASE'.obs;

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
  int? selectedPetId;

  ScrollController mainScrollController = ScrollController();
  AccountModel accountModel = Get.find<SignInPageController>().accountModel!;
}
