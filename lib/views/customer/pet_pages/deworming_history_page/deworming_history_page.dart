import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/deworming_history_page_controller.dart';
import 'package:petapp_mobile/services/pet_services/pet_health_records_services.dart';
import 'package:petapp_mobile/views/customer/pet_pages/deworming_history_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/deworming_history_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class DewormingHistoryPage extends GetView<DewormingHistoryPageController> {
  const DewormingHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: WHITE_COLOR,
        body: Column(
          children: [
            const DewormingHistoryTopWidget(),
            GetBuilder<DewormingHistoryPageController>(builder: (_) {
              controller.isWaitingLoadingData.value = true;
              WidgetsBinding.instance!.addPostFrameCallback((_) async {
                controller
                  ..dewormingList =
                      await PetHealthRecordsServices.fetchPetHealthRecordList(
                          petId: Get.parameters['petId']!, type: 'HELMINTHIC')
                  ..sortDewormingList()
                  ..isWaitingLoadingData.value = false;
              });

              return Obx(() => controller.isWaitingLoadingData.value
                  ? Expanded(
                      child: Container(
                          color: SUPPER_LIGHT_BLUE, child: LOADING_WIDGET()))
                  : const DewormingHistoryBodyWidget());
            })
          ],
        ),
      );
}
