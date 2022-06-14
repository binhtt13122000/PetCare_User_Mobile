import 'package:get/get.dart';
import 'package:petapp_mobile/models/pet_health_records_model/pet_health_records_model.dart';

class VaccineListPageController extends GetxController {
  late List<PetHealthRecordModel> vaccinesList;
  RxBool isWaitingLoadingData = false.obs;
}
