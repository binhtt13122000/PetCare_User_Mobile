import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/buy_services_combo_page_controller.dart';
import 'package:petapp_mobile/models/center_services_transaction_detail_model/center_services_transaction_detail_model.dart';
import 'package:petapp_mobile/services/transaction_services/center_services_transaction_services.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class BuyServicesComboBottomWidget
    extends GetView<BuyServicesComboPageController> {
  const BuyServicesComboBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        color: WHITE_COLOR,
        child: Column(
          children: [
            Container(
              height: 1,
              color: LIGHT_GREY_COLOR.withAlpha(30),
            ),
            paymentWidget(),
          ],
        ),
      );

  Widget paymentWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: InkWell(
          onTap: () async {
            if (controller.registerDateText.value.isNotEmpty &&
                controller.selectedPetIndex.value != -1 &&
                controller.selectBranchIndex.value != -1 &&
                controller.selectPetServicesComboIndex.value != -1) {
              controller.isWaitingLoadingDataForeground.value = true;
              List<CenterServicesTransactionDetailModel>
                  centerServicesTransactionDetailModelList = [
                CenterServicesTransactionDetailModel(
                  petId: controller
                      .petModelList[controller.selectedPetIndex.value].id,
                  petComboId: controller.petServicesComboModel.id,
                  petComboName: controller.petServicesComboModel.name,
                  price: controller.petServicesComboModel.price,
                  quantity: 1,
                  totalPrice: controller.petServicesComboModel.price,
                  registerTime: controller.bookingServicesDate,
                ),
              ];

              controller.centerServicesTransactionId =
                  await CenterServicesTransactionServices
                      .createCenterServicesTransaction(
                          provisionalTotal:
                              controller.petServicesComboModel.price,
                          orderTotal: controller.petServicesComboModel.price,
                          customerId: controller.accountModel.customerModel.id,
                          branchId: controller
                              .branchModelList[
                                  controller.selectBranchIndex.value]
                              .id,
                          description: '',
                          registerTime: DateTime.now(),
                          orderDetails:
                              centerServicesTransactionDetailModelList);
              controller.isWaitingLoadingDataForeground.value = false;
              Get.offNamed(
                  '$PAYMENT_FOR_CENTER_SERVICES_TRANSACTION_PAGE_ROUTE/${controller.centerServicesTransactionId}');
            }
          },
          child: Obx(
            () => Container(
              height: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: controller.registerDateText.value.isNotEmpty &&
                        controller.selectedPetIndex.value != -1 &&
                        controller.selectBranchIndex.value != -1 &&
                        controller.selectPetServicesComboIndex.value != -1
                    ? PRIMARY_COLOR
                    : PRIMARY_COLOR.withOpacity(0.3),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CUSTOM_TEXT(
                    'Go to payment page',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: WHITE_COLOR,
                    letterSpacing: 2,
                    padding: const EdgeInsets.only(right: 10),
                  ),
                  SvgPicture.asset(
                    ICON_PATH + SEND_SVG,
                    color: WHITE_COLOR,
                    height: 18,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
