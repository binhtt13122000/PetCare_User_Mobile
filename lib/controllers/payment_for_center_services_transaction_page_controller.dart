import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/center_services_transaction_model/center_services_transaction_model.dart';
import 'package:petapp_mobile/models/promotion_model.dart/promotion_model.dart';

class PaymentForCenterServicesTransactionPageController extends GetxController {
  RxBool isLoadingData = false.obs;
  AccountModel accountModel = Get.find<AuthController>().accountModel;
  RxBool isShowPopup = false.obs;
  late CenterServicesTransactionModel centerServicesTransactionModel;
  PromotionModel? selectedPromotion;
  RxInt discountAmount = 0.obs;
  RxString selectedPromotionName = ''.obs;
  RxString paymentUrl = ''.obs;
  late List<PromotionModel> promotionModels;
  late InAppWebViewController inAppWebViewController;
}
