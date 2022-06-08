import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/ticket_page_controller.dart';
import 'package:petapp_mobile/services/ticket_services.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class CreateTicketBottomWidget extends GetView<CreateTicketPageController> {
  const CreateTicketBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 1,
          color: LIGHT_GREY_COLOR.withAlpha(30),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: InkWell(
            onTap: () async {
              if (controller.selectedTicketTimeIndex.value != -1 &&
                  controller.selectCenterServicesIndexList.isNotEmpty) {
                List<int> servicesIdList = [];
                for (var element in controller.selectCenterServicesIndexList) {
                  servicesIdList
                      .add(controller.centerServicesModelList[element].id);
                }
                controller.isWaitingSendTicket.value = true;
                await TicketServices.createTicket(
                  createdTime: DateTime.now(),
                  meetingDate: DateTime.now().add(
                      Duration(days: controller.selectedDateIndex.value + 1)),
                  startTime: controller
                      .ticketTimeModelList[
                          controller.selectedTicketTimeIndex.value]
                      .startTime,
                  endTime: controller
                      .ticketTimeModelList[
                          controller.selectedTicketTimeIndex.value]
                      .endTime,
                  branchId: controller.selectBranchId.value,
                  customerId: controller.accountModel.customerModel.id,
                  servicesIdList: servicesIdList,
                );
                controller
                  ..isWaitingSendTicket.value = false
                  ..isShowPopupWidget.value = true;
              }
            },
            child: Obx(
              () => Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: controller.selectedTicketTimeIndex.value != -1 &&
                              controller
                                  .selectCenterServicesIndexList.isNotEmpty
                          ? PRIMARY_COLOR
                          : PRIMARY_COLOR.withOpacity(0.3),
                      width: 1),
                  color: controller.selectedTicketTimeIndex.value != -1 &&
                          controller.selectCenterServicesIndexList.isNotEmpty
                      ? PRIMARY_COLOR
                      : PRIMARY_COLOR.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CUSTOM_TEXT(
                      'SEND TICKET',
                      color: WHITE_COLOR,
                      textAlign: TextAlign.center,
                      letterSpacing: 3,
                    ),
                    const SizedBox(width: 10),
                    SvgPicture.asset(
                      ICON_PATH + SEND_SVG,
                      height: 20,
                      color: WHITE_COLOR,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
