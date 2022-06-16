import 'package:get/get.dart';
import 'package:petapp_mobile/models/pet_health_records_model/pet_health_records_model.dart';

class RemoveTicksHistoryPageController extends GetxController {
  late List<PetHealthRecordModel> dewormingList;
  RxBool isWaitingLoadingData = false.obs;
  RxList<int> showDescriptionIndexList = <int>[].obs;
  sortDewormingList() {
    dewormingList
        .sort((b, a) => a.dateOfInjection.compareTo(b.dateOfInjection));
  }
}
