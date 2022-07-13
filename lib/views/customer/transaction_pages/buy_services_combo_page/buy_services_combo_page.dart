import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/buy_services_combo_page_controller.dart';
import 'package:petapp_mobile/services/other_services/branch_services.dart';
import 'package:petapp_mobile/services/transaction_services/services_combo_services.dart';
import 'package:petapp_mobile/services/pet_services/species_services.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/buy_services_combo_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/buy_services_combo_page/widgets/calendar_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/buy_services_combo_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class BuyServicesComboPage extends GetView<BuyServicesComboPageController> {
  const BuyServicesComboPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get.parameters['petId'] != null) {
      controller.initSelectedPetId = int.parse(Get.parameters['petId']!);
    }

    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: [
          Column(
            children: const [
              BuyServicesComboTopWidget(),
              BuyServicesComboBodyWidget(),
            ],
          ),
          const BuyServicesComboCalendarWidget(),
          Obx(
            () => Visibility(
              visible: controller.isWaitingLoadingDataForeground.value,
              child: Container(
                color: DARK_GREY_TRANSPARENT,
                child: LOADING_WIDGET(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
