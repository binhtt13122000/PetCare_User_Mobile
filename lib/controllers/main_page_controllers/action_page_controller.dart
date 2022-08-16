import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/ticket_model/ticket_model.dart';

class ActionPageController extends GetxController {
  AccountModel accountModel = Get.find<AuthController>().accountModel;
  RxBool isLoadingData = false.obs;
  TicketModel? ticketModel;
  RxInt ticketId = (-1).obs;
  RxInt selectedImageIndex = 0.obs;
  int nextTime = 5;
  final PageController pageController = PageController();
  //late Timer timer;

  List<String> imagePathList = [
    PET_GROOMING_PNG,
    PET_SHOWER_PNG,
    PET_VACCINATION_PNG
  ];

  startTimer() {
    // timer =
    Timer.periodic(
      Duration(seconds: nextTime),
      (timer) {
        if (selectedImageIndex.value < 2) {
          pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn);
        } else {
          pageController.animateToPage(0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn);
        }
      },
    );
  }

  // cancelTimer() {
  //   timer.cancel();
  // }

  ActionPageController() {
    // startTimer();
    // pageController.addListener(() {
    //   selectedImageIndex.value = pageController.page!.toInt();
    // });
  }
}
