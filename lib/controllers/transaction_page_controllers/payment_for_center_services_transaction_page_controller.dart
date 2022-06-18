import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/center_services_transaction_model/center_services_transaction_model.dart';
import 'package:petapp_mobile/models/promotion_model.dart/promotion_model.dart';

class PaymentForCenterServicesTransactionPageController extends GetxController {
  AccountModel accountModel = Get.find<AuthController>().accountModel;
  RxBool isLoadingData = false.obs;
  RxBool isShowPopup = false.obs;
  late CenterServicesTransactionModel centerServicesTransactionModel;
  RxInt discountAmount = 0.obs;
  RxInt usedPoint = 0.obs;
  RxString paymentUrl = ''.obs;
  late InAppWebViewController inAppWebViewController;
  late List<PromotionModel> promotionModels;
  RxInt selectedPromotionIndex = (-1).obs;
  RxBool isWaitingPayment = false.obs;
}
