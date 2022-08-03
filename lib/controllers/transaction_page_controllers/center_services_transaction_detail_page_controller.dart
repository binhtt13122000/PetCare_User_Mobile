import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/order_model/order_model.dart';

class OrderDetailPageController extends GetxController {
  AccountModel accountModel = Get.find<AuthController>().accountModel;
  RxBool isShowNotificationPopup = false.obs;
  bool isSuccessNotification = true;
  String notificationContent = '';
  Function()? onTapNotification;
  RxBool isLoadingData = false.obs;
  RxBool isShowThankPopup = false.obs;
  RxInt selectedStar = 0.obs;
  RxString ratingText = 'Rating'.obs;
  RxList<String> quickFeedBackList = <String>[].obs;
  RxBool isShowReviewPopup = false.obs;
  RxString reviewContent = ''.obs;
  late OrderModel orderModel;
  RxBool isWaitingUpdate = false.obs;
  RxBool isViewBranchDetail = false.obs;
  late int orderId;
  RxBool isViewTransactionDetail = false.obs;
  RxBool isShowMoreOptions = false.obs;
  RxBool isShowCancelPopup = false.obs;
  RxString cancelDescription = ''.obs;
  RxList<String> quickCancelList = <String>[].obs;

  updateRatingText() {
    switch (selectedStar.value) {
      case 0:
        ratingText.value = 'Rating';
        break;
      case 1:
        ratingText.value = 'Very bad';
        break;
      case 2:
        ratingText.value = 'Bad';
        break;
      case 3:
        ratingText.value = 'Temporarily\ngood';
        break;
      case 4:
        ratingText.value = 'Good';
        break;
      case 5:
        ratingText.value = 'Perfect';
        break;
      default:
    }
  }
}
