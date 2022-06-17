import 'dart:async';

import 'package:get/get.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/ticket_model/ticket_model.dart';

class ActionPageController extends GetxController {
  AccountModel accountModel = Get.find<AuthController>().accountModel;
  RxBool isLoadingData = false.obs;
  TicketModel? ticketModel;
  RxInt ticketId = (-1).obs;
  RxInt selectedImageIndex = 0.obs;
  int nextTime = 5;

  List<String> imagePathList = [
    PET_GROOMING_PNG,
    PET_SHOWER_PNG,
    PET_VACCINATION_PNG
  ];

  startTimer() {
    Timer.periodic(
      Duration(seconds: nextTime),
      (timer) {
        if (selectedImageIndex.value < 2) {
          selectedImageIndex.value++;
        } else {
          selectedImageIndex.value = 0;
        }
      },
    );
  }

  ActionPageController() {
    startTimer();
  }
}
