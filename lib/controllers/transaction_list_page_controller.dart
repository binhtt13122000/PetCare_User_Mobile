import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/normal_transaction_model/normal_transaction_model.dart';
import 'package:petapp_mobile/models/sale_transaction_model/sale_transaction_model.dart';

class TransactionListPageController extends GetxController {
  AccountModel accountModel = Get.find<AuthController>().accountModel;

  RxString selectedTransactionType = 'All Transactions'.obs;
  RxInt page = 1.obs;
  final int limit = 10;

  List<String> purchaseTransactionTypeList = [
    'Transaction role: [BUYER]',
    'Transaction role: [SELLER]'
  ];
  RxString selectedPurchaseTransactionType = 'Transaction role: [BUYER]'.obs;

  late List<SaleTransactionModel> saleTransactionModelList;
  late List<NormalTransactionModel> normalTransactionList;

  RxBool isLoadingPurchaseTransaction = false.obs;
  late RxList<SaleTransactionModel> saleTransactionList;
}
