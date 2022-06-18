import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/buy_services_combo_page_controller.dart';
import 'package:petapp_mobile/services/other_services/branch_services.dart';
import 'package:petapp_mobile/services/transaction_services/services_combo_services.dart';
import 'package:petapp_mobile/services/pet_services/species_services.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/buy_services_combo_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/buy_services_combo_page/widgets/calendar_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/buy_services_combo_page/widgets/popup_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/buy_services_combo_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/buy_services_combo_page/widgets/web_view_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class BuyServicesComboPage extends GetView<BuyServicesComboPageController> {
  const BuyServicesComboPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.isWaitLoadingData.value = true;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      controller
        ..speciesModelList = await SpeciesService.fetchSpeciesList()
        ..selectedSpeciesId.value = controller.selectedSpeciesId.value == -1
            ? controller.speciesModelList[0].id
            : controller.selectedSpeciesId.value
        ..branchModelList = await BranchServices.fetchBranchList()
        ..selectBranchId.value = controller.branchModelList[0].id
        ..petServicesComboModelList =
            await ServicesComboModelServices.fetchServicesComboList()
        ..selectPetServicesComboIndex.value = 0
        ..totalPrice.value = controller.petServicesComboModelList[0].price
        ..isWaitLoadingData.value = false;
    });
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: [
          Column(
            children: [
              const BuyServicesComboTopWidget(),
              Obx(() => controller.isWaitLoadingData.value
                  ? Expanded(
                      child: Container(
                          color: SUPPER_LIGHT_BLUE, child: LOADING_WIDGET()))
                  : const BuyServicesComboBodyWidget()),
            ],
          ),
          const BuyServicesComboCalendarWidget(),
          const BuyServicesComboWebViewWidget(),
          const BuyServicesComboPopupWidget(),
        ],
      ),
    );
  }
}
