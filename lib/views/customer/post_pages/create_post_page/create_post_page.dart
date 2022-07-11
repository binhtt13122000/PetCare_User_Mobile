import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/create_post_page_controller.dart';
import 'package:petapp_mobile/services/other_services/branch_services.dart';
import 'package:petapp_mobile/services/transaction_services/transaction_fees_services.dart';
import 'package:petapp_mobile/views/customer/post_pages/create_post_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/create_post_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/create_post_page/widgets/calendar_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/create_post_page/widgets/loading_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/create_post_page/widgets/media_picker_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/create_post_page/widgets/popup_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/create_post_page/widgets/sale_transaction_fees.dart';
import 'package:petapp_mobile/views/customer/post_pages/create_post_page/widgets/select_pet_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/create_post_page/widgets/select_branch_widget.dart';
import 'package:petapp_mobile/views/customer/post_pages/create_post_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class CreatePostPage extends GetView<CreatePostPageController> {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.isShowMainLoading.value = true;
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      controller
        ..listPurchaseTransactionFees =
            await TransactionFeesServices.fetchTransactionFreesList(
                transactionType: controller.selectedPostType.value)
        ..branchModelList = await BranchServices.fetchBranchList()
        ..isShowMainLoading.value = false;
    });

    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Obx(
        () => controller.isShowMainLoading.value
            ? LOADING_WIDGET()
            : Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CreatePostTopWidget(),
                      Expanded(
                        child: Scrollbar(
                          controller: controller.mainScrollController,
                          isAlwaysShown: true,
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
                                // DescriptionWidget(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const CreatePostBottomWidget(),
                    ],
                  ),
                  const CreatePostLoadingWidget(),
                  const CreatePostPopupWidget(),
                  const CreatePostSaleTransactionFeesWidget(),
                  const CreatePostCalendarWidget(),
                ],
              ),
      ),
    );
  }

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
