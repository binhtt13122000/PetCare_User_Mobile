import 'package:get/get.dart';
import 'package:petapp_mobile/models/pet_health_records_model/pet_health_records_model.dart';

class VaccineListPageController extends GetxController {
  late List<PetHealthRecordModel> vaccinesList;
  RxBool isWaitingLoadingData = false.obs;
  late Map<String, List<PetHealthRecordModel>> vaccinesMap;
  late List<String> vaccinesMapKeys;
  late RxString selectedVaccine = 'All vaccines'.obs;
  RxBool isShowVaccinesList = false.obs;
  RxList<int> showDescriptionIndexList = <int>[].obs;

  setMapVaccines() {
    vaccinesMapKeys = ['All vaccines'];
    vaccinesMap = {'All vaccines': vaccinesList};

    for (var element in vaccinesList) {
      if (vaccinesMapKeys.contains(element.vaccineModel!.name)) {
        vaccinesMap[element.vaccineModel!.name]!.add(element);
      } else {
        vaccinesMapKeys.add(element.vaccineModel!.name);
        List<PetHealthRecordModel> tmpVaccinesList = [element];
        vaccinesMap.addEntries(
            {MapEntry(element.vaccineModel!.name, tmpVaccinesList)});
      }
    }
  }

  sortMapVaccines() {
    vaccinesMap[selectedVaccine.value]!
        .sort((b, a) => a.dateOfInjection.compareTo(b.dateOfInjection));
  }
}
