import 'dart:io';

import 'package:get/get.dart';
import 'package:petapp_mobile/configs/path.dart';

class RegisterPageController extends GetxController {
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString gender = 'MALE'.obs;
  RxString phoneNumber = ''.obs;
  RxString email = ''.obs;
  RxString address = ''.obs;
  RxBool isSelectPickImageType = false.obs;
  RxString avatarfilePath = ''.obs;
  File? avatarFile;
  RxString selectedAreaCode = '+84'.obs;
  Map<String, String> areaCodeMap = {
    VIETNAM_PNG: '+84',
    UNITED_STATES_PNG: '+1',
  };
}
