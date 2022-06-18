import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/vaccine_list_page_controller.dart';
import 'package:petapp_mobile/services/pet_services/pet_health_records_services.dart';
import 'package:petapp_mobile/views/customer/pet_pages/vaccine_list_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/vaccine_list_page/widgets/select_vaccine_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/vaccine_list_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class VaccineListPage extends GetView<VaccineListPageController> {
  const VaccineListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: WHITE_COLOR,
        body: Stack(
          children: [
            Column(
              children: [
                const VaccineListPageTopWidget(),
                GetBuilder<VaccineListPageController>(builder: (_) {
                  controller.isWaitingLoadingData.value = true;
                  WidgetsBinding.instance!.addPostFrameCallback((_) async {
                    controller
                      ..vaccinesList = await PetHealthRecordsServices
                          .fetchPetHealthRecordList(
                              petId: Get.parameters['petId']!, type: 'VACCINE')
                      ..setMapVaccines()
                      // ..selectedVaccine.value =
                      //     controller.selectedVaccine.value.isEmpty
                      //         ? controller.vaccinesMapKeys.isNotEmpty
                      //             ? controller.vaccinesMapKeys[0]
                      //             : ''
                      //         : controller.selectedVaccine.value
                      ..sortMapVaccines()
                      ..isWaitingLoadingData.value = false;
                  });

                  return Obx(
                    () => controller.isWaitingLoadingData.value
                        ? Expanded(
                            child: Container(
                                color: SUPPER_LIGHT_BLUE,
                                child: LOADING_WIDGET()))
                        : const VaccineListPageBodyWidget(),
                  );
                })
              ],
            ),
            const VaccineListPageVaccinesWidget(),
          ],
        ),
      );
}
