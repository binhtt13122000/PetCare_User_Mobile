// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/branch_model/branch_model.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';
import 'package:petapp_mobile/models/species_model/species_model.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:petapp_mobile/models/transaction_fees_model/transaction_fees_model.dart';

class CreatePostPageController extends GetxController {
  RxBool isShowPurchaseTransactionFees = false.obs;
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
  RxString selectedPostType = 'SALE'.obs;
  RxBool isFirstInputReceivedMoney = true.obs;
  bool isFirstInputTitle = true;
  bool isShowPetFilter = false;
  RxBool isShowPetDropdownList = false.obs;
  RxString receivedMoney = ''.obs;
  RxBool isShowLoadingWidget = false.obs;
  RxBool isShowSuccessfullyPopup = false.obs;

  late List<BranchModel> branchModelList;
  RxInt selectBranchIndex = (-1).obs;
  RxBool isShowBranchDetail = false.obs;

  quill.QuillController quillController = quill.QuillController.basic();

  RxInt selectedSpeciesId = (-1).obs;
  late List<SpeciesModel> species;

  late List<PetModel> pets;
  RxInt selectedPetId = (-1).obs;

  ScrollController mainScrollController = ScrollController();
  AccountModel accountModel = Get.find<AuthController>().accountModel;
  DateTime? meetingTime;
  DateTime? tmpMeetingTime;
  RxString meetingTimeText = ''.obs;
  RxBool isShowCalendar = false.obs;
}
