import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/breeding_transaction_detail_page_controller.dart';
import 'package:petapp_mobile/services/transaction_services/breeding_transaction_services.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/more_options_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/popup_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/review_popup_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/view_tab_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/web_view.dart';

class BreedingTransactionDetailPage
    extends GetView<BreedingTransactionDetailPageController> {
  const BreedingTransactionDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get.parameters['breedingTransactionId'] != null) {
      controller.breedingTransactionId =
          int.parse(Get.parameters['breedingTransactionId']!);
    }

    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: GetBuilder<BreedingTransactionDetailPageController>(builder: (_) {
        controller.isLoading.value = true;

        WidgetsBinding.instance!.addPostFrameCallback((_) async {
          controller
            ..breedingTransactionModel =
                await BreedingTransactionService.fetchBreedingTransactionById(
                    breedingTransactionId: controller.breedingTransactionId)
            ..isLoading.value = false;
        });
        return Stack(
          children: [
            Column(
              children: [
                const BreedingTransactionDetailTopWidget(),
                Obx(
                  () => controller.isLoading.value
                      ? const Expanded(
                          child: Center(
                            child: SpinKitSpinningLines(
                              color: PRIMARY_COLOR,
                              size: 150,
                            ),
                          ),
                        )
                      : Expanded(
                          child: Column(
                            children: [
                              const BreedingTransactionDetailBodyWidget(),
                              Obx(() => Visibility(
                                  visible: controller.selectedViewTab.value ==
                                      'Transaction details',
                                  child:
                                      const BreedingTransactionDetailBottomWidget())),
                            ],
                          ),
                        ),
                ),
              ],
            ),
            Obx(
              () => controller.isLoading.value
                  ? const SizedBox.shrink()
                  : Stack(
                      children: const [
                        BreedingTransactionDetailWebViewWidget(),
                        BreedingTransactionDetailPopupWidget(),
                        BreedingTransactionDetailReviewPopupWidget(),
                        BreedingTransactionDetailMoreOptionWidget(),
                        BreedingTransactionDetailViewTypeTabWidget(),
                      ],
                    ),
            ),
          ],
        );
      }),
    );
  }
}
