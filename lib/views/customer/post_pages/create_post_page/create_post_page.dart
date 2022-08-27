import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/create_post_page_controller.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/post_management_page_controller.dart';
import 'package:petapp_mobile/services/other_services/branch_services.dart';
import 'package:petapp_mobile/services/transaction_services/ticket_services.dart';
import 'package:petapp_mobile/services/transaction_services/transaction_fees_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/customer/post_pages/create_post_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/create_post_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/create_post_page/widgets/description_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/create_post_page/widgets/loading_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/create_post_page/widgets/media_picker_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/create_post_page/widgets/transaction_fees.dart';
import 'package:petapp_mobile/views/customer/post_pages/create_post_page/widgets/select_pet_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/create_post_page/widgets/select_branch_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/create_post_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/calendar_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:petapp_mobile/views/widgets/notification_popup_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CreatePostPage extends GetView<CreatePostPageController> {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CreatePostTopWidget(),
              GetBuilder<CreatePostPageController>(builder: (_) {
                controller.isShowMainLoading.value = true;
                WidgetsBinding.instance!.addPostFrameCallback((_) async {
                  controller
                    ..listPurchaseTransactionFees =
                        await TransactionFeesServices.fetchTransactionFreesList(
                            jwt: controller.accountModel.jwtToken,
                            transactionType: controller.selectedPostType.value)
                    ..branchModelList = await BranchServices.fetchBranchList(
                      jwt: controller.accountModel.jwtToken,
                    )
                    ..ticketModel =
                        await TicketServices.fetchTicketByCustomerId(
                            jwt: controller.accountModel.jwtToken,
                            customerId:
                                controller.accountModel.customerModel.id);

                  if (controller.ticketModel != null) {
                    for (var element
                        in controller.ticketModel!.serviceTicketModelList!) {
                      if (!controller.petIdInTicket.contains(element.petId)) {
                        controller.petIdInTicket.add(element.petId);
                      }
                    }
                  }
                  controller.isShowMainLoading.value = false;
                });

                return Obx(
                  () => controller.isShowMainLoading.value
                      ? Expanded(
                          child: Container(
                              color: SUPPER_LIGHT_BLUE,
                              child: LOADING_WIDGET()),
                        )
                      : bodyWidget(),
                );
              }),
            ],
          ),
          const CreatePostLoadingWidget(),
          Obx(
            () => controller.isShowSuccessfullyPopup.value
                ? NotificationPopupWidget(
                    onTapBackground: () {},
                    onTapOk: () => Get
                      ..back()
                      ..find<PostManagementPageController>().update(),
                    content:
                        'Create ${controller.selectedPostType.value == 'SALE' ? 'sale' : 'breeding'} post for pet ${controller.pets[controller.selectedPetIndex.value].name} successfully.',
                    isSuccessNotification: true,
                  )
                : const SizedBox.shrink(),
          ),
          const CreatePostTransactionFeesWidget(),
          Obx(
            () => Visibility(
              visible: controller.isShowCalendar.value,
              child: CalendarWidget(
                title: 'Meeting date',
                onTapBackGround: () {
                  controller
                    ..tmpMeetingTimeText.value =
                        controller.meetingTimeText.value
                    ..tmpMeetingTime = controller.meetingTime
                    ..isShowCalendar.value = false;
                },
                onSelectionChanged: (DateRangePickerSelectionChangedArgs
                    dateRangePickerSelectionChangedArgs) {
                  controller
                    ..tmpMeetingTime = DateTime.parse(
                        dateRangePickerSelectionChangedArgs.value.toString())
                    ..tmpMeetingTimeText.value = FORMAT_DATE_TIME(
                        dateTime: controller.tmpMeetingTime!,
                        pattern: DATE_PATTERN_2);
                },
                initialDisplayDate: <DateTime>() => controller.meetingTime,
                initialSelectedDate: <DateTime>() => controller.meetingTime,
                onTapCancel: () {
                  controller
                    ..tmpMeetingTimeText.value =
                        controller.meetingTimeText.value
                    ..tmpMeetingTime = controller.meetingTime
                    ..isShowCalendar.value = false;
                },
                onTapOk: () {
                  controller
                    ..meetingTime = controller.tmpMeetingTime
                    ..meetingTimeText.value =
                        controller.tmpMeetingTimeText.value
                    ..isShowCalendar.value = false;
                },
                maxDate: DateTime.now().add(
                  const Duration(days: 5),
                ),
                isAvailableOkButton: <bool>() =>
                    controller.tmpMeetingTimeText.value.isNotEmpty,
                minDate: DateTime.now(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bodyWidget() => Expanded(
        child: Column(
          children: [
            Expanded(
              child: SmartRefresher(
                controller: RefreshController(),
                onRefresh: () => controller.update(),
                child: SingleChildScrollView(
                  controller: controller.mainScrollController,
                  child: Column(
                    children: [
                      //VideoApp(),
                      const CreatePostBodyWidget(),
                      const SelectPetWidget(),
                      const MediaPickerWidget(),
                      Container(
                        color: WHITE_COLOR,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 12),
                        child: Row(
                          children: [
                            registerDateTitleWidget(),
                            bookingDateWidget(),
                          ],
                        ),
                      ),
                      const SelectBranchWidget(),
                      const DescriptionWidget(),
                    ],
                  ),
                ),
              ),
            ),
            const CreatePostBottomWidget(),
          ],
        ),
      );

  Widget registerDateTitleWidget() => Row(
        children: [
          CUSTOM_TEXT('Meeting date'),
          CUSTOM_TEXT(
            '*',
            color: RED_COLOR,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ],
      );

  Widget bookingDateWidget() => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
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
                          controller.meetingTimeText.value.isNotEmpty
                              ? controller.meetingTimeText.value
                              : 'dd/MM/yyyy',
                          textAlign: TextAlign.left,
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
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
      );
}
