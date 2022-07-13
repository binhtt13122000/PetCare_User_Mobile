import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/enum_config.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostDetailPageController extends GetxController {
  late PostModel postModel;
  RxInt selectedPetImageIndex = 0.obs;
  RxBool isShowDescription = false.obs;
  RxBool isShowLoadingPost = false.obs;
  ScrollController mainScrollController = ScrollController();
  AccountModel accountModel = Get.find<AuthController>().accountModel;
  RxBool isShowMoreOptionWidget = false.obs;
  RxBool isShowConfirmPopup = false.obs;
  String notificationPopupTitle = '';
  RxBool isWaitLoadingDataForeGround = false.obs;
  RxBool isShowNotificationPopup = false.obs;
  late String confirmType;
  RxBool isLoadingData = false.obs;
  String loadingType = LoadingType.INIT.name;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
}
