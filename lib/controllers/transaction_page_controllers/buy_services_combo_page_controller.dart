import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/branch_model/branch_model.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';
import 'package:petapp_mobile/models/services_combo_model/services_combo_model.dart';
import 'package:petapp_mobile/models/species_model/species_model.dart';

class BuyServicesComboPageController extends GetxController {
  AccountModel accountModel = Get.find<AuthController>().accountModel;
  RxBool isWaitLoadingData = false.obs;
  late List<ServicesComboModel> petServicesComboModelList;
  RxInt selectPetServicesComboIndex = (-1).obs;
  late List<PetModel> petModelList;
  late List<SpeciesModel> speciesModelList;
  int? initSelectedPetId;
  RxInt selectedPetIndex = (-1).obs;
  RxInt selectedSpeciesId = (-1).obs;
  RxBool isShowPetFilter = false.obs;
  RxBool isShowPetDropdownList = false.obs;
  RxBool isWaitLoadingPet = false.obs;
  bool isLoadingPet = true;
  late List<BranchModel> branchModelList;
  RxInt selectBranchIndex = (-1).obs;
  RxBool isDisplayCalender = false.obs;
  DateTime? bookingServicesDate;
  DateTime? tmpBookingServicesDate;
  RxString registerDateText = ''.obs;
  RxInt totalPrice = 0.obs;
  RxBool isWaitLoadingPetServicesComboDetail = false.obs;
  bool isLoadingPetServicesComboDetail = true;
  late ServicesComboModel petServicesComboModel;
  RxBool isViewServicesComboDescriptionWidget = false.obs;
  RxBool isShowBranchDetail = false.obs;
  late int? centerServicesTransactionId;
  RxBool isWaitingLoadingDataForeground = false.obs;
}
