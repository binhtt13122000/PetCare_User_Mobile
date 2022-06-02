import 'package:get/get.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';

class PetDetailPageController extends GetxController {
  late PetModel petModel;
  RxBool isLoadingData = false.obs;
}
