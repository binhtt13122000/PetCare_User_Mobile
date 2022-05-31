import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/center_services_transaction_model/center_services_transaction_model.dart';
import 'package:petapp_mobile/models/promotion_model.dart/promotion_model.dart';

class PaymentForTransactionAtCenterPageController extends GetxController {
  AccountModel accountModel = Get.find<AuthController>().accountModel;
  RxBool isShowPopup = false.obs;
  late Function() refetchGraphql;
  late CenterServicesTransactionModel centerServicesTransactionModel;
  String uriReturn = '/v1/api/orders/vnpay_return';
  PromotionModel? selectedPromotion;
  RxInt discountAmount = 0.obs;
  RxString selectedPromotionName = 'ADD A PROMO'.obs;
  RxString paymentUrl = ''.obs;
  List<PromotionModel> promotionModels = [
    PromotionModel(
      name: 'VS1605',
      discountPercent: 10,
      description: 'Visa discount 10%',
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
  late InAppWebViewController inAppWebViewController;
}
