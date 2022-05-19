import 'package:get/get.dart';
import 'package:petapp_mobile/models/normal_transaction_model/normal_transaction_model.dart';
import 'package:petapp_mobile/models/promotion_model.dart/promotion_model.dart';

class TransactionAtCenterDetailPageController extends GetxController {
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
}
