import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/booking_breeding_service_page_controller.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/breeding_transaction_detail_page_controller.dart';
import 'package:petapp_mobile/services/transaction_services/breeding_transaction_services.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class BookingBreedingServicesBottomWidget
    extends GetView<BookingBreedingServicesPageController> {
  const BookingBreedingServicesBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(height: 1, color: DARK_GREY_COLOR.withOpacity(0.1)),
          createPostButtonWidget(),
          // managementHistoryButtonWidget(),
        ],
      );

  Widget createPostButtonWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: InkWell(
          onTap: () async {
            controller.isWaitingSendRequest.value = true;
            await BreedingTransactionService.bookingBreedingServices(
                jwt: controller.accountModel.jwtToken,
                breedingTransactionId: controller.breedingTransactionId,
                branchId: controller
                    .branchModelList[controller.selectBranchIndex.value].id,
                bookingTime: controller.bookingServicesDate!);
            controller
              ..isWaitingSendRequest.value = false
              ..isErrorPopup = false
              ..popupTitle = 'Booking breeding service successfully!'
              ..onTapPopup = () {
                Get.back();
                Get.put(BreedingTransactionDetailPageController())
                  ..isShowBottomWidget.value = false
                  ..update();
              }
              ..isShowPopup.value = true;
          },
          child: Obx(
            () => Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 192, 195, 207),
                ),
                borderRadius: BorderRadius.circular(3),
                color: controller.bookingServicesDateText.value.isNotEmpty
                    ? PRIMARY_COLOR
                    : PRIMARY_COLOR.withOpacity(0.3),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CUSTOM_TEXT('Send Booking Request',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2.5,
                      color: WHITE_COLOR,
                      fontSize: 15,
                      padding: const EdgeInsets.only(right: 10)),
                  SvgPicture.asset(
                    ICON_PATH + SEND_SVG,
                    color: WHITE_COLOR,
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
