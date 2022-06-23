import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/branch_model/branch_model.dart';

class BookingBreedingServicesPageController extends GetxController {
  AccountModel accountModel = Get.find<AuthController>().accountModel;
  RxBool isLoadingData = false.obs;
  RxBool isShowPickTimeWidget = false.obs;
  late List<BranchModel> branchModelList;
  RxInt selectBranchIndex = (-1).obs;
  RxBool isDisplayCalender = false.obs;
  DateTime? bookingServicesDate;
  DateTime? tmpBookingServicesDate;
  RxString bookingServicesDateText = ''.obs;
  late int breedingTransactionId;
  RxBool isShowPopup = false.obs;
  bool isErrorPopup = false;
  late String popupTitle;
  late Function() onTapPopup;
  RxBool isWaitingSendRequest = false.obs;
  RxBool isInitDate = false.obs;
}
