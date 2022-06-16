import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/remove_ticks_history_page_controller.dart';
import 'package:petapp_mobile/services/pet_health_records_services.dart';
import 'package:petapp_mobile/views/customer/remove_ticks_history_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/remove_ticks_history_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class RemoveTickHistoryPage extends GetView<RemoveTicksHistoryPageController> {
  const RemoveTickHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: WHITE_COLOR,
        body: Column(
          children: [
            const RemoveTicksHistoryTopWidget(),
            GetBuilder<RemoveTicksHistoryPageController>(builder: (_) {
              controller.isWaitingLoadingData.value = true;
              WidgetsBinding.instance!.addPostFrameCallback((_) async {
                controller
                  ..dewormingList =
                      await PetHealthRecordsServices.fetchPetHealthRecordList(
                          petId: Get.parameters['petId']!, type: 'TICKS')
                  ..sortDewormingList()
                  ..isWaitingLoadingData.value = false;
              });

              return Obx(() => controller.isWaitingLoadingData.value
                  ? Expanded(
                      child: Container(
                          color: SUPPER_LIGHT_BLUE, child: LOADING_WIDGET()))
                  : const RemoveTicksHistoryBodyWidget());
            })
          ],
        ),
      );
}
