import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/center_services_transaction_model/center_services_transaction_model.dart';
import 'package:petapp_mobile/models/sale_transaction_model/sale_transaction_model.dart';

class TransactionListPageController extends GetxController {
  AccountModel accountModel = Get.find<AuthController>().accountModel;
  RxString selectedTransactionType = 'Center\'s services'.obs;
  int page = 1;
  final int limit = 100;

  List<String> purchaseTransactionTypeList = [
    'Transaction role: [BUYER]',
    'Transaction role: [SELLER]'
  ];
  RxString selectedPurchaseTransactionType = 'Transaction role: [BUYER]'.obs;

  late List<SaleTransactionModel> saleTransactionModelList;
  late List<CenterServicesTransactionModel> centerServicesTransactionList;

  RxBool isLoadingPurchaseTransaction = false.obs;
  RxBool isLoadingCenterServicesTransaction = false.obs;
  late RxList<SaleTransactionModel> saleTransactionList;
}
