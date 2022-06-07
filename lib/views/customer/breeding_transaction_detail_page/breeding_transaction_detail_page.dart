import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/breeding_transaction_detail_page_controller.dart';
import 'package:petapp_mobile/services/breeding_transaction_services.dart';
import 'package:petapp_mobile/views/customer/breeding_transaction_detail_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/breeding_transaction_detail_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/breeding_transaction_detail_page/widgets/more_options_widget.dart';
import 'package:petapp_mobile/views/customer/breeding_transaction_detail_page/widgets/popup_widget.dart';
import 'package:petapp_mobile/views/customer/breeding_transaction_detail_page/widgets/review_popup_widget.dart';
import 'package:petapp_mobile/views/customer/breeding_transaction_detail_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/customer/breeding_transaction_detail_page/widgets/web_view.dart';

class BreedingTransactionDetailPage
    extends GetView<BreedingTransactionDetailPageController> {
  const BreedingTransactionDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: GetBuilder<BreedingTransactionDetailPageController>(builder: (_) {
        controller.isLoading.value = true;

        WidgetsBinding.instance!.addPostFrameCallback((_) async {
          controller
            ..breedingTransactionModel =
                await BreedingTransactionService.fetchBreedingTransactionById(
                    breedingTransactionId:
                        int.parse(Get.parameters['breedingTransactionId']!))
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
                            children: const [
                              BreedingTransactionDetailBodyWidget(),
                              BreedingTransactionDetailBottomWidget(),
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
                        BreedingTransactionPopupWidget(),
                        BreedingTransactionReviewPopupWidget(),
                        BreedingTransactionMoreOptionWidget(),
                      ],
                    ),
            ),
          ],
        );
      }),
    );
  }
}
