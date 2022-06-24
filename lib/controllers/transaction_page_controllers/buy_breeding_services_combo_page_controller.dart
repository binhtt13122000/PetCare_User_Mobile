import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/breeding_transaction_model/breeding_transaction_model.dart';
import 'package:petapp_mobile/models/services_combo_model/services_combo_model.dart';

class BuyBreedingServicesComboPageController extends GetxController {
  AccountModel accountModel = Get.find<AuthController>().accountModel;
  RxBool isWaitLoadingData = false.obs;
  late List<ServicesComboModel> petServicesComboModelList;
  RxInt totalPrice = 0.obs;
  RxBool isWaitLoadingPetServicesComboDetail = false.obs;
  bool isLoadingPetServicesComboDetail = true;
  late ServicesComboModel petServicesComboModel;
  RxBool isShowPopup = false.obs;
  RxBool isViewServicesComboDescriptionWidget = false.obs;
  late int breedingTransactionId;
  RxInt selectPetServicesComboIndex = (-1).obs;
  late BreedingTransactionModel breedingTransactionModel;
  RxBool isWaitLoadingDataForeground = false.obs;
}
