import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/breeding_transaction_model/breeding_transaction_model.dart';
import 'package:petapp_mobile/models/order_model/order_model.dart';
import 'package:petapp_mobile/models/sale_transaction_model/sale_transaction_model.dart';

class TransactionListPageController extends GetxController {
  AccountModel accountModel = Get.find<AuthController>().accountModel;
  RxString selectedTransactionType = 'Center\'s services'.obs;
  int page = 1;
  final int limit = 99;

  //*center's services transaction
  late List<OrderModel> orderModelList;
  RxBool isLoadingCenterServicesTransaction = false.obs;

  //*sale transaction
  List<String> saleTransactionTypeList = [
    'Transaction role: [BUYER]',
    'Transaction role: [SELLER]'
  ];
  late RxString selectedSaleTransactionType;
  late List<SaleTransactionModel> saleTransactionModelList;
  RxBool isLoadingSaleTransaction = false.obs;

  //*breeding transaction
  List<String> breedingTransactionTypeList = [
    'Transaction role: [BUYER]',
    'Transaction role: [SELLER]'
  ];
  late RxString selectedBreedingTransactionType;
  late List<BreedingTransactionModel> breedingTransactionModelList;
  RxBool isLoadingBreedingTransaction = false.obs;

  TransactionListPageController() {
    selectedSaleTransactionType = saleTransactionTypeList[0].obs;
    selectedBreedingTransactionType = breedingTransactionTypeList[0].obs;
  }
}
