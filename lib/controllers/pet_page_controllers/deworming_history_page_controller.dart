import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/pet_health_records_model/pet_health_records_model.dart';

class DewormingHistoryPageController extends GetxController {
  AccountModel accountModel = Get.find<AuthController>().accountModel;
  late List<PetHealthRecordModel> dewormingList;
  RxBool isWaitingLoadingData = false.obs;
  RxList<int> showDescriptionIndexList = <int>[].obs;
  sortDewormingList() {
    dewormingList
        .sort((b, a) => a.dateOfInjection.compareTo(b.dateOfInjection));
  }
}
