import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/breeding_transaction_detail_page_controller.dart';
import 'package:petapp_mobile/services/transaction_services/breeding_transaction_services.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/confirm_pop_up_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/more_options_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/popup_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/review_popup_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/view_detail_popup_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/view_tab_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/web_view.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class BreedingTransactionDetailPage
    extends GetView<BreedingTransactionDetailPageController> {
  const BreedingTransactionDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get.parameters['breedingTransactionId'] != null) {
      controller.breedingTransactionId =
          int.parse(Get.parameters['breedingTransactionId']!);
    }
    controller.isWaitingLoadingInitData.value = true;

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      controller
        ..breedingTransactionModel =
            await BreedingTransactionService.fetchBreedingTransactionById(
                breedingTransactionId: controller.breedingTransactionId)
        ..sortComboList()
        ..isWaitingLoadingInitData.value = false;
    });

    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: [
          Column(
            children: [
              const BreedingTransactionDetailTopWidget(),
              Obx(
                () => controller.isWaitingLoadingInitData.value
                    ? Expanded(
                        child: LOADING_WIDGET(),
                      )
                    : const BreedingTransactionDetailBodyWidget(),
              ),
            ],
          ),
          const BreedingTransactionDetailWebViewWidget(),
          const BreedingTransactionDetailPopupWidget(),
          const BreedingTransactionDetailReviewPopupWidget(),
          const BreedingTransactionDetailMoreOptionWidget(),
          const BreedingTransactionDetailViewTypeTabWidget(),
          const BreedingTransactionDetailConfirmPopupWidget(),
          const BreedingTransactionViewDetailPopupWidget(),
          Obx(
            () => Visibility(
              visible: controller.isWaitingForeground.value,
              child: Container(
                  color: DARK_GREY_TRANSPARENT, child: LOADING_WIDGET()),
            ),
          ),
        ],
      ),
    );
  }
}
