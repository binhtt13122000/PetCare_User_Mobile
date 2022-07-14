import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/booking_breeding_service_page_controller.dart';
import 'package:petapp_mobile/services/other_services/branch_services.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/booking_breeding_service_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/booking_breeding_service_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/booking_breeding_service_page/widgets/calendar_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/booking_breeding_service_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:petapp_mobile/views/widgets/notification_popup_widget.dart';

class BookingBreedingServicesPage
    extends GetView<BookingBreedingServicesPageController> {
  const BookingBreedingServicesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get.parameters['breedingTransactionId'] != null) {
      controller.breedingTransactionId =
          int.parse(Get.parameters['breedingTransactionId']!);
    }

    controller.isLoadingData.value = true;

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      controller
        ..branchModelList = await BranchServices.fetchBranchList()
        ..selectBranchIndex.value = 0
        ..isLoadingData.value = false;
    });

    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: [
          Column(
            children: [
              const BookingBreedingServicesTopWidget(),
              Obx(
                () => controller.isLoadingData.value
                    ? Expanded(child: LOADING_WIDGET())
                    : Expanded(
                        child: Column(
                          children: const [
                            BookingBreedingServicesBodyWidget(),
                            BookingBreedingServicesBottomWidget(),
                          ],
                        ),
                      ),
              )
            ],
          ),
          const BookingBreedingServicesCalendarWidget(),
          Obx(
            () => Visibility(
              visible: controller.isWaitingSendRequest.value,
              child: Container(
                color: DARK_GREY_TRANSPARENT,
                child: LOADING_WIDGET(),
              ),
            ),
          ),
          Obx(
            () => controller.isShowPopup.value
                ? NotificationPopupWidget(
                    onTapBackground: () {},
                    onTapOk: controller.onTapPopup,
                    content: controller.popupTitle,
                    isSuccessNotification: true,
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
