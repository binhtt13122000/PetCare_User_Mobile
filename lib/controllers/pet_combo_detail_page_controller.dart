import 'package:get/get.dart';
import 'package:petapp_mobile/models/pet_combo_model/pet_combo_model.dart';

class PetComboDetailPageController extends GetxController {
  RxBool isWaitLoadingData = false.obs;
  late PetComboModel petComboModel;
}
