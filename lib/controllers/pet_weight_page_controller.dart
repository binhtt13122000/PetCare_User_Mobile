import 'package:get/get.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';

class PetWeightPageController extends GetxController {
  late PetModel petModel;
  RxBool isLoadingData = false.obs;
}
