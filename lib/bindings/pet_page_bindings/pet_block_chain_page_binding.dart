import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_block_chain_page_controller.dart';

class PetBlockChainPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PetBlockChainPageController>(
        () => PetBlockChainPageController());
  }
}
