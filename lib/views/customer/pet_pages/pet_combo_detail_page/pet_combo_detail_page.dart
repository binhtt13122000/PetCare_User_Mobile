import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_combo_detail_page_controller.dart';
import 'package:petapp_mobile/models/ticket_model/ticket_model.dart';
import 'package:petapp_mobile/services/transaction_services/ticket_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_combo_detail_page/widgets/body_widget.dart';
import 'package:petapp_mobile/services/pet_services/pet_combo_services.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_combo_detail_page/widgets/create_ticket_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_combo_detail_page/widgets/notification_popup_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_combo_detail_page/widgets/pet_services_list_status.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_combo_detail_page/widgets/pop_up_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_combo_detail_page/widgets/rating_popup_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_combo_detail_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/calendar_widget.dart';
import 'package:petapp_mobile/views/widgets/confirm_popup_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:petapp_mobile/views/widgets/notification_popup_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PetComboDetailPage extends GetView<PetComboDetailPageController> {
  const PetComboDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.isWaitLoadingData.value = true;
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      TicketModel? ticketModel = await TicketServices.fetchTicketByCustomerId(
          jwt: controller.accountModel.jwtToken,
          customerId: controller.accountModel.customerModel.id);
      controller
        ..petComboModel = await PetComboServices.fetchPetComboById(
            jwt: controller.accountModel.jwtToken,
            petComboId: Get.parameters['petComboId']!)
        ..petComboStatus.value =
            controller.petComboModel.isCompleted ? 'Completed' : 'Not completed'
        ..ticketId.value = ticketModel != null ? ticketModel.id : -1
        ..isWaitLoadingData.value = false;
    });

    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: [
          Column(
            children: [
              const PetComboDetailTopWidget(),
              Obx(() => controller.isWaitLoadingData.value
                  ? Expanded(
                      child: Container(
                          color: SUPPER_LIGHT_BLUE, child: LOADING_WIDGET()))
                  : const PetComboDetailBodyWidget()),
            ],
          ),
          const PetServicesListStatusBarWidget(),
          const PetComboDetailRatingPopupWidget(),
          const PetComboDetailPopupWidget(),
          const PetComboDetailNotificationPopupWidget(),
          const PetComboDetailCreateRequestWidget(),
          Obx(
            () => controller.isShowCalendar.value
                ? CalendarWidget(
                    title: 'Meeting date',
                    onTapBackGround: () {
                      controller
                        ..tmpMeetingTimeText.value =
                            controller.bookingServicesDateText.value
                        ..tmpBookingServicesDate =
                            controller.bookingServicesDate
                        ..isShowCalendar.value = false;
                    },
                    onSelectionChanged: (DateRangePickerSelectionChangedArgs
                        dateRangePickerSelectionChangedArgs) {
                      controller
                        ..tmpBookingServicesDate = DateTime.parse(
                            dateRangePickerSelectionChangedArgs.value
                                .toString())
                        ..tmpMeetingTimeText.value = FORMAT_DATE_TIME(
                            dateTime: controller.tmpBookingServicesDate,
                            pattern: DATE_PATTERN_2);
                    },
                    initialDisplayDate: <DateTime>() =>
                        controller.bookingServicesDate,
                    initialSelectedDate: <DateTime>() =>
                        controller.bookingServicesDate,
                    onTapCancel: () {
                      controller
                        ..tmpMeetingTimeText.value =
                            controller.bookingServicesDateText.value
                        ..tmpBookingServicesDate =
                            controller.bookingServicesDate
                        ..isShowCalendar.value = false;
                    },
                    onTapOk: () {
                      controller
                        ..bookingServicesDate =
                            controller.tmpBookingServicesDate
                        ..bookingServicesDateText.value =
                            controller.tmpMeetingTimeText.value
                        ..isShowCalendar.value = false;
                    },
                    isAvailableOkButton: <bool>() =>
                        controller.tmpMeetingTimeText.value.isNotEmpty,
                    minDate: DateTime.now().add(
                      const Duration(days: 1),
                    ),
                    maxDate: DateTime.now().add(
                      const Duration(days: 6),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          Obx(
            () => controller.isShowConfirmPopup.value
                ? ConfirmPopupWidget(
                    onTapBackground: () {
                      controller.isShowConfirmPopup.value = false;
                    },
                    title: 'Booking Ticket',
                    content: 'Are you sure to booking ticket?',
                    onTapSubmit: () async {
                      controller
                        ..isShowConfirmPopup.value = false
                        ..isWaitLoadingDataForeGround.value = true;

                      controller.ticketId.value =
                          await TicketServices.createTicket(
                                jwt: controller.accountModel.jwtToken,
                                createdTime: DateTime.now(),
                                meetingDate: controller.bookingServicesDate,
                                startTime: controller
                                    .ticketTimeModelList[controller
                                        .selectedTicketTimeIndex.value]
                                    .startTime,
                                endTime: controller
                                    .ticketTimeModelList[controller
                                        .selectedTicketTimeIndex.value]
                                    .endTime,
                                branchId: controller.petComboModel.branchId,
                                customerId:
                                    controller.accountModel.customerModel.id,
                                servicesIdList: [
                                  controller
                                      .selectedPetComboDetailModel.serviceId
                                ],
                                type: 'COMBO',
                              ) ??
                              -1;

                      controller
                        ..isWaitLoadingDataForeGround.value = false
                        ..isShowSuccessfullyPopup.value = true;
                    })
                : const SizedBox.shrink(),
          ),
          Obx(
            () => controller.isShowSuccessfullyPopup.value
                ? NotificationPopupWidget(
                    onTapBackground: () {},
                    onTapOk: () => Get.offNamed(
                        '$TICKET_DETAIL_PAGE_ROUTE/${controller.ticketId}'),
                    content:
                        'Create booking services ticket successfully! \nRemember to come by appointment.',
                  )
                : const SizedBox.shrink(),
          ),
          Obx(
            () => Visibility(
              visible: controller.isWaitLoadingDataForeGround.value,
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
