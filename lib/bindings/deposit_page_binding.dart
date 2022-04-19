import 'package:get/get.dart';

class DepositPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DepositPageBinding>(() => DepositPageBinding());
  }
}
