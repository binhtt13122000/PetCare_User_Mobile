// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/sign_in_page_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/breed_model/breed_model.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';
import 'package:petapp_mobile/models/species_model/species_model.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class CreatePostPageController extends GetxController {
  RxList<File> evidences = <File>[].obs;
  RxList<String> evidencesPath = <String>[].obs;
  RxList<File> healthChecker = <File>[].obs;
  RxList<String> healthCheckerPath = <String>[].obs;
  RxString title = ''.obs;
  String description = '';
  RxInt price = 0.obs;
  RxString deposit = ''.obs;
  RxString selectedTicketType = 'PURCHASE'.obs;
  bool isFirstInputPrice = true;
  bool isFirstInputTitle = true;
  bool isFirstInputDescription = true;
  RxBool isShowPetFilter = false.obs;
  RxBool isShowPetDropdownList = false.obs;
  RxString receivedMoney = ''.obs;
  RxBool isShowLoadingWidget = false.obs;
  RxBool isShowSuccessfullyPopup = false.obs;

  quill.QuillController quillController = quill.QuillController.basic();

  int selectedSpeciesId = -1;
  late List<SpeciesModel> species;

  Map<int, int> selectedBreedMap = <int, int>{};
  Map<int, List<BreedModel>> breedsMap = <int, List<BreedModel>>{};

  late RxList<PetModel> pets;
  int selectedPetId = -1;

  ScrollController mainScrollController = ScrollController();
  AccountModel accountModel = Get.find<SignInPageController>().accountModel!;
}
