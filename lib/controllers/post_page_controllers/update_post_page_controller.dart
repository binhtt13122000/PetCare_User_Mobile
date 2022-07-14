import 'dart:io';

import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/branch_model/branch_model.dart';
import 'package:petapp_mobile/models/media_model/media_model.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:petapp_mobile/models/transaction_fees_model/transaction_fees_model.dart';

class UpdatePostPageController extends GetxController {
  AccountModel accountModel = Get.find<AuthController>().accountModel;
  late int postId;
  late PostModel postModel;
  RxBool isShowPurchaseTransactionFees = false.obs;
  late List<TransactionFeesModel> listPurchaseTransactionFees;
  RxInt selectedPurchaseTransactionFeesId = (-1).obs;
  RxBool isShowMainLoading = false.obs;
  RxBool isLoadingBranch = false.obs;
  RxList<File> evidences = <File>[].obs;
  RxList<MediaModel> evidencesPath = <MediaModel>[].obs;
  RxString title = ''.obs;
  RxString description = ''.obs;
  RxInt price = 0.obs;
  RxInt deposit = 0.obs;
  RxString receivedMoney = ''.obs;
  RxBool isShowSuccessfullyPopup = false.obs;
  List<BranchModel> branchList = [];
  RxInt selectedBranchId = (-1).obs;
  quill.QuillController quillController = quill.QuillController.basic();
  RxList<int> deletedIds = <int>[].obs;
  RxBool isShowConfirmPopup = false.obs;
  RxBool isWaitingUpdate = false.obs;
}
