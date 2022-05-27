import 'package:get/get.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/controllers/sign_in_page_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/normal_transaction_model/normal_transaction_model.dart';
import 'package:petapp_mobile/models/sale_transaction_model/sale_transaction_model.dart';
import 'package:petapp_mobile/models/services_model/services_model.dart';

class TransactionPageController extends GetxController {
  RxString selectedPurchaseTransactionType =
      'Your role in transaction is [BUYER]'.obs;
  List<String> purchaseTransactionTypeList = [
    'Your role in transaction is [BUYER]',
    'Your role in transaction is [SELLER]'
  ];
  late List<SaleTransactionModel> saleTransactionModelList;
  RxBool isLoadingPurchaseTransaction = false.obs;
  AccountModel accountModel = Get.find<SignInPageController>().accountModel!;
  bool isFirstInit = true;
  Function()? refetchGraphql;
  RxString selectedTransactionType = 'All Transactions'.obs;
  List<ServiceModel> services = List.empty(growable: true);
  List<String> sorts = [
    'Recently transaction',
    'Price: Low → High',
    'Price: High → Low',
  ];
  late RxString selectedSort;
  late RxString selectedSevices;
  late RxList<SaleTransactionModel> saleTransactions;
  late List<NormalTransactionModel> normalTransactionList;
  TransactionPageController() {
    selectedSort = sorts[0].obs;
    services.add(
      ServiceModel(
          id: 1,
          name: 'Purchase',
          imageUrl: IMAGE_PATH + HAND_SHAKE_PNG,
          description: 'description',
          status: 1),
    );
    services.add(
      ServiceModel(
          id: 4,
          name: 'Breeding',
          imageUrl: IMAGE_PATH + PET_BABY_PNG,
          description: 'description',
          status: 1),
    );
    services.add(
      ServiceModel(
          id: 2,
          name: 'Veterinary',
          imageUrl: IMAGE_PATH + VERTERINARIAN_PNG,
          description: 'description',
          status: 1),
    );
    services.add(
      ServiceModel(
          id: 3,
          name: 'Grooming',
          imageUrl: IMAGE_PATH + GROOMING_PNG,
          description: 'description',
          status: 1),
    );

    services.add(
      ServiceModel(
          id: 5,
          name: 'Traning',
          imageUrl: IMAGE_PATH + TRANING_PNG,
          description: 'description',
          status: 1),
    );
    selectedSevices = services[0].name.obs;
  }
}
