import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';

class PurchasePostDetailPageController extends GetxController {
  late PostModel postModel;
  RxInt selectedPetImageIndex = 0.obs;
  RxBool isShowDescription = false.obs;
  ScrollController mainScrollController = ScrollController();
  AccountModel accountModel = Get.find<AuthController>().accountModel;
}
