import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/vaccine_list_page_controller.dart';
import 'package:petapp_mobile/services/pet_health_records_services.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class VaccineListPage extends GetView<VaccineListPageController> {
  const VaccineListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: WHITE_COLOR,
        body: Column(
          children: [
            GetBuilder<VaccineListPageController>(builder: (_) {
              controller.isWaitingLoadingData.value = true;
              WidgetsBinding.instance!.addPostFrameCallback((_) async {
                controller
                  ..vaccinesList =
                      await PetHealthRecordsServices.fetchPetHealthRecordList(
                          petId: Get.parameters['petId']!, type: 'VACCINE')
                  ..isWaitingLoadingData.value = false;
              });

              return Obx(
                () => controller.isWaitingLoadingData.value
                    ? Expanded(child: LOADING_WIDGET())
                    : Container(),
              );
            })
          ],
        ),
      );
}
