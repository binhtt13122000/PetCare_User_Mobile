import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_combo_detail_page_controller.dart';
import 'package:petapp_mobile/services/transaction_services/ticket_services.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PetComboDetailCreateRequestWidget
    extends GetView<PetComboDetailPageController> {
  const PetComboDetailCreateRequestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Obx(() {
        return controller.isShowCreateTicketPopup.value
            ? InkWell(
                onTap: () => controller.isShowCreateTicketPopup.value = false,
                child: Container(
                  color: DARK_GREY_TRANSPARENT,
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: 330,
                      height: 340,
                      decoration: BoxDecoration(
                        color: WHITE_COLOR,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                CUSTOM_TEXT(
                                  'Booking Ticket',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  letterSpacing: 1.5,
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CUSTOM_TEXT(
                                        'Booking service',
                                        fontSize: 15,
                                        padding: const EdgeInsets.only(
                                          right: 10,
                                        ),
                                      ),
                                      Expanded(
                                        child: CUSTOM_TEXT(
                                          controller.selectedPetComboDetailModel
                                              .centerServiceModel.name,
                                          fontSize: 15,
                                          textOverflow: TextOverflow.clip,
                                          padding: const EdgeInsets.only(
                                            right: 10,
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                estimateTimeWidget(),
                                bookingDateWidget(),
                                Container(
                                  padding:
                                      const EdgeInsets.only(top: 20, left: 12),
                                  color: WHITE_COLOR,
                                  child: Row(
                                    children: [
                                      CUSTOM_TEXT('Time booking services'),
                                      CUSTOM_TEXT(
                                        '*',
                                        color: RED_COLOR,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ],
                                  ),
                                ),
                                GetBuilder<PetComboDetailPageController>(
                                    builder: (_) {
                                  controller.isLoadingBookingTicketTimeData
                                      .value = true;
                                  WidgetsBinding.instance!
                                      .addPostFrameCallback((_) async {
                                    controller
                                      ..ticketModelList = await TicketServices
                                          .fetchTicketListByBranch(
                                        jwt: controller.accountModel.jwtToken,
                                        branchId:
                                            controller.petComboModel.branchId,
                                        bookingTime:
                                            controller.bookingServicesDate,
                                      )
                                      ..setTicketTimeModelList()
                                      ..isLoadingBookingTicketTimeData.value =
                                          false;
                                  });

                                  return Obx(() => controller
                                          .isLoadingBookingTicketTimeData.value
                                      ? Expanded(
                                          child: LOADING_WIDGET(size: 40))
                                      : Expanded(child: timeItemWidget()));
                                }),
                              ],
                            ),
                          ),
                          bottomButtonWidget(),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink();
      });

  Widget timeItemWidget() => Obx(() {
        return controller.selectedTicketTimeIndex.value != -1
            ? Container(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 20, left: 12, right: 12),
                color: WHITE_COLOR,
                child: InkWell(
                  onTap: () => controller.isShowPickTimeWidget.value = true,
                  child: Center(
                    child: Container(
                      width: 200,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: LIGHT_GREY_COLOR.withOpacity(0.3),
                          ),
                          color: WHITE_COLOR),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CUSTOM_TEXT(
                              (controller
                                                  .ticketTimeModelList[controller
                                                      .selectedTicketTimeIndex
                                                      .value]
                                                  .startTime ~/
                                              60 +
                                          7)
                                      .toString() +
                                  ':' +
                                  ((controller
                                                  .ticketTimeModelList[controller
                                                      .selectedTicketTimeIndex
                                                      .value]
                                                  .startTime %
                                              60) ==
                                          0
                                      ? '00'
                                      : '30') +
                                  ((controller
                                                      .ticketTimeModelList[
                                                          controller
                                                              .selectedTicketTimeIndex
                                                              .value]
                                                      .startTime ~/
                                                  60 +
                                              7) <=
                                          12
                                      ? ' AM'
                                      : ' PM'),
                              fontSize: 17,
                              textAlign: TextAlign.right,
                            ),
                          ),
                          CUSTOM_TEXT(
                            ' - ',
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            fontSize: 17,
                          ),
                          Expanded(
                            child: CUSTOM_TEXT(
                              (controller
                                                  .ticketTimeModelList[controller
                                                      .selectedTicketTimeIndex
                                                      .value]
                                                  .endTime ~/
                                              60 +
                                          7)
                                      .toString() +
                                  ':' +
                                  ((controller
                                                  .ticketTimeModelList[controller
                                                      .selectedTicketTimeIndex
                                                      .value]
                                                  .endTime %
                                              60) ==
                                          0
                                      ? '00'
                                      : '30') +
                                  ((controller
                                                      .ticketTimeModelList[
                                                          controller
                                                              .selectedTicketTimeIndex
                                                              .value]
                                                      .endTime ~/
                                                  60 +
                                              7) <=
                                          12
                                      ? ' AM'
                                      : ' PM'),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              fontSize: 17,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          const Icon(
                            Icons.arrow_drop_down,
                            color: DARK_GREY_TEXT_COLOR,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Container(
                padding: const EdgeInsets.only(top: 10),
                color: WHITE_COLOR,
                child: Center(
                  child: CUSTOM_TEXT(
                    'There are currently no available time!\nPlease choose another date.',
                    color: PINK_COLOR,
                    fontSize: 13,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
      });

  Widget bookingDateWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            CUSTOM_TEXT(
              'Booking date',
              fontSize: 15,
              padding: const EdgeInsets.only(right: 10),
            ),
            Expanded(
              child: InkWell(
                onTap: () => controller.isShowCalendar.value = true,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 167, 181, 201),
                      width: 1.2,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: WHITE_COLOR,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Obx(
                            () => CUSTOM_TEXT(
                              controller.bookingServicesDateText.value,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.calendar_month_rounded,
                          color: PRIMARY_COLOR,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget estimateTimeWidget() {
    String timeText = '';
    int hours = controller
            .selectedPetComboDetailModel.centerServiceModel.estimatedTime ~/
        60;
    int minutes = controller
            .selectedPetComboDetailModel.centerServiceModel.estimatedTime %
        60;

    if (hours > 0 && minutes > 0) {
      timeText = '$hours hours $minutes minutes';
    } else if (hours > 0) {
      timeText = '$hours hours';
    } else {
      timeText = '$minutes minutes';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      color: WHITE_COLOR,
      child: Row(
        children: [
          CUSTOM_TEXT(
            'Estimate time to\nperform services',
            fontSize: 15,
            padding: const EdgeInsets.only(right: 10),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: LIGHT_GREY_COLOR.withOpacity(0.3),
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: CUSTOM_TEXT(
                timeText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomButtonWidget() => SizedBox(
        height: 40,
        child: Column(
          children: [
            Container(
              height: 1.5,
              color: LIGHT_GREY_COLOR.withAlpha(30),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () =>
                          controller.isShowCreateTicketPopup.value = false,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: WHITE_COLOR,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CUSTOM_TEXT(
                              'CANCEL',
                              textAlign: TextAlign.start,
                              color: PRIMARY_COLOR,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 2,
                    color: LIGHT_GREY_COLOR.withAlpha(30),
                  ),
                  Obx(
                    () => Expanded(
                      child: InkWell(
                        onTap: () {
                          if (controller.selectedTicketTimeIndex.value != -1) {
                            controller.isShowConfirmPopup.value = true;
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color:
                                controller.selectedTicketTimeIndex.value != -1
                                    ? PRIMARY_COLOR.withOpacity(0.9)
                                    : PRIMARY_COLOR.withOpacity(0.3),
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CUSTOM_TEXT(
                                'OK',
                                textAlign: TextAlign.start,
                                color: WHITE_COLOR,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
