import 'package:get/get.dart';

class GuestLandingPageController extends GetxController {
  RxBool isShowPolicy = false.obs;
  RxBool isLoadingData = false.obs;
  late String policy;
}
