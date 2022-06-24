import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/buy_breeding_services_combo_page_controller.dart';
import 'package:petapp_mobile/services/transaction_services/breeding_transaction_services.dart';
import 'package:petapp_mobile/services/transaction_services/services_combo_services.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/buy_breeding_services_combo_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/buy_breeding_services_combo_page/widgets/popup_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/buy_breeding_services_combo_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class BuyBreedingServicesComboPage
    extends GetView<BuyBreedingServicesComboPageController> {
  const BuyBreedingServicesComboPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get.parameters['breedingTransactionId'] != null) {
      controller.breedingTransactionId =
          int.parse(Get.parameters['breedingTransactionId']!);
    }

    controller.isWaitLoadingData.value = true;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      controller
        ..petServicesComboModelList =
            await ServicesComboModelServices.fetchServicesComboListByType(
                serviceType: 'BREED')
        ..breedingTransactionModel =
            await BreedingTransactionService.fetchBreedingTransactionById(
                breedingTransactionId: controller.breedingTransactionId)
        ..selectPetServicesComboIndex.value = -1
        ..totalPrice.value = 0
        ..isWaitLoadingData.value = false;
    });

    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: [
          Column(
            children: [
              const BuyBreedingServicesComboTopWidget(),
              Obx(() => controller.isWaitLoadingData.value
                  ? Expanded(
                      child: Container(
                          color: SUPPER_LIGHT_BLUE, child: LOADING_WIDGET()))
                  : const BuyBreedingServicesComboBodyWidget()),
            ],
          ),
          Obx(
            () => controller.isWaitLoadingDataForeground.value
                ? Container(
                    color: DARK_GREY_TRANSPARENT,
                    child: Container(
                        color: DARK_GREY_TRANSPARENT, child: LOADING_WIDGET()),
                  )
                : const SizedBox.shrink(),
          ),
          const BuyBreedingBreedingServicesComboPopupWidget(),
        ],
      ),
    );
  }
}
