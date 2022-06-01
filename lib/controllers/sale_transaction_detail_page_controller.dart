import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/sale_transaction_model/sale_transaction_model.dart';

class SaleTransactionDetailPageController extends GetxController {
  RxBool isShowCancelPopup = false.obs;
  RxBool isShowMoreOptions = false.obs;
  late SaleTransactionModel saleTransactionModel;
  RxBool isLoading = false.obs;
  AccountModel accountModel = Get.find<AuthController>().accountModel;
  RxString paymentUrl = ''.obs;
  RxBool isShowPopup = false.obs;
  RxBool isShowReviewPopup = false.obs;
  RxInt selectedStar = 0.obs;
  RxString ratingText = 'Rating'.obs;
  RxList<String> quickFeedBackList = <String>[].obs;
  RxList<String> quickCancelList = <String>[].obs;
  String reviewContent = '';
  RxBool isShowThankPopup = false.obs;
  RxString cancelDescription = ''.obs;
  RxBool isShowCancelResultPopup = false.obs;
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
