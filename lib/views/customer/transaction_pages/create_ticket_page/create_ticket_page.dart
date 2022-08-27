import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/create_ticket_page_controller.dart';
import 'package:petapp_mobile/models/service_ticket_model/service_ticket_model.dart';
import 'package:petapp_mobile/services/transaction_services/breeding_transaction_services.dart';
import 'package:petapp_mobile/services/transaction_services/ticket_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/create_ticket_page/widgets/add_services_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/create_ticket_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/create_ticket_page/widgets/pick_time_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/create_ticket_page/widgets/select_pet_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/create_ticket_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/calendar_widget.dart';
import 'package:petapp_mobile/views/widgets/confirm_popup_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:petapp_mobile/views/widgets/notification_popup_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CreateTicketPage extends GetView<CreateTicketPageController> {
  const CreateTicketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get.parameters['breedingTransactionId'] != null) {
      controller.breedingTransactionId =
          int.parse(Get.parameters['breedingTransactionId']!);
    }
    if (Get.parameters['petId'] != null) {
      controller.petId = int.parse(Get.parameters['petId']!);
    }
    if (Get.parameters['serviceId'] != null) {
      controller.serviceId = int.parse(Get.parameters['serviceId']!);
    }
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: [
          Column(
            children: const [
              CreateTicketTopWidget(),
              CreateTicketBodyWidget(),
            ],
          ),
          const PickTimeWidget(),
          const AddServicesWidget(),
          Obx(() => controller.isShowPetList.value
              ? const CreateTicketSelectPetWidget()
              : const SizedBox.shrink()),
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
                        ..isShowCalendar.value = false
                        ..update();
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
                        ..isLoadingForeground.value = true;
                      List<ServiceTicketModel> serviceTicketModelList = [];

                      for (var petIndex in controller.selectPetIndexList) {
                        for (var servicesIndex
                            in controller.selectServicesMap[petIndex]!) {
                          serviceTicketModelList.add(
                            ServiceTicketModel(
                                serviceId: controller
                                    .centerServicesModelList[servicesIndex].id,
                                petId: controller.pets[petIndex].id),
                          );
                        }
                      }
                      controller.ticketId = await TicketServices.createTicket(
                        jwt: controller.accountModel.jwtToken,
                        createdTime: DateTime.now(),
                        meetingDate: controller.bookingServicesDate,
                        startTime: controller
                            .ticketTimeModelList[
                                controller.selectedTicketTimeIndex.value]
                            .startTime,
                        endTime: controller
                            .ticketTimeModelList[
                                controller.selectedTicketTimeIndex.value]
                            .endTime,
                        branchId: controller
                            .branchModelList[controller.selectBranchIndex.value]
                            .id,
                        customerId: controller.accountModel.customerModel.id,
                        serviceTickets: serviceTicketModelList,
                        type: 'SERVICE',
                      );
                      if (controller.breedingTransactionId != null &&
                          controller.ticketId != -1) {
                        await BreedingTransactionService
                            .bookingBreedingServices(
                                jwt: controller.accountModel.jwtToken,
                                breedingTransactionId:
                                    controller.breedingTransactionId!,
                                branchId: controller
                                    .branchModelList[
                                        controller.selectBranchIndex.value]
                                    .id,
                                bookingTime: controller.bookingServicesDate);
                      }
                      controller
                        ..isLoadingForeground.value = false
                        ..isShowSuccessfullyPopup.value = true;
                    })
                : const SizedBox.shrink(),
          ),
          Obx(
            () => controller.isShowSuccessfullyPopup.value
                ? NotificationPopupWidget(
                    onTapBackground: () {},
                    isSuccessNotification: controller.ticketId != -1,
                    onTapOk: () {
                      if (controller.ticketId != -1) {
                        Get.offNamed(
                            '$TICKET_DETAIL_PAGE_ROUTE/${controller.ticketId}');
                      } else {
                        controller
                          ..isShowSuccessfullyPopup.value = false
                          ..isLoadingTicketList.value = true
                          ..update();
                      }
                    },
                    content: controller.ticketId != -1
                        ? 'Booking services ticket successfully! \nRemember to come by appointment.'
                        : 'Booking services ticket failed! \nPlease try another booking time.',
                  )
                : const SizedBox.shrink(),
          ),
          Obx(
            () => Visibility(
              visible: controller.isLoadingForeground.value,
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
