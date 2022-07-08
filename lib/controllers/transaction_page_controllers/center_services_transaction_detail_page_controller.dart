import 'package:get/get.dart';
import 'package:petapp_mobile/models/order_model/order_model.dart';

class CenterServicesTransactionDetailPageController extends GetxController {
  RxBool isLoadingData = false.obs;
  RxBool isShowThankPopup = false.obs;
  RxInt selectedStar = 0.obs;
  RxString ratingText = 'Rating'.obs;
  RxList<String> quickFeedBackList = <String>[].obs;
  RxBool isShowReviewPopup = false.obs;
  String reviewContent = '';
  late OrderModel orderModel;
  RxBool isWaitingUpdate = false.obs;
  RxBool isViewBranchDetail = false.obs;
  late int transactionId;
  RxBool isViewTransactionDetail = false.obs;

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
