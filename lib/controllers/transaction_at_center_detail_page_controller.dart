import 'package:get/get.dart';
import 'package:petapp_mobile/models/normal_transaction_model/normal_transaction_model.dart';
import 'package:petapp_mobile/models/promotion_model.dart/promotion_model.dart';

class TransactionAtCenterDetailPageController extends GetxController {
  RxBool isShowThankPopup = false.obs;
  RxInt selectedStar = 0.obs;
  RxString ratingText = 'Rating'.obs;
  RxList<String> quickFeedBackList = <String>[].obs;
  PromotionModel? selectedPromotion;
  RxInt disccountAmount = 0.obs;
  RxString selectedPromotionName = 'ADD A PROMO'.obs;
  late NormalTransactionModel normalTransactionModel;
  List<PromotionModel> promotionModels = [
    PromotionModel(
      name: 'VS1605',
      discountPercent: 10,
      description: 'Visa discount 5%',
      expDate: DateTime.now().add(
        const Duration(days: 75),
      ),
    ),
    PromotionModel(
      name: 'WELNEW01',
      discountPercent: 5,
      description: 'Discount 5% for new user',
      expDate: DateTime.now().add(
        const Duration(days: 15),
      ),
    ),
  ];
  Function()? refetchGraphql;
  List<int> currentTransactionIdList = [];
  RxBool isShowReviewPopup = false.obs;
  String reviewContent = '';

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
