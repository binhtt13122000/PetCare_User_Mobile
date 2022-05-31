import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/sale_transaction_detail_page_controller.dart';
import 'package:petapp_mobile/services/breed_servies.dart';
import 'package:petapp_mobile/services/sale_transaction_services.dart';
import 'package:petapp_mobile/services/species_services.dart';
import 'package:petapp_mobile/views/customer/sale_transaction_detail_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/sale_transaction_detail_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/sale_transaction_detail_page/widgets/more_options_widget.dart';
import 'package:petapp_mobile/views/customer/sale_transaction_detail_page/widgets/popup_widget.dart';
import 'package:petapp_mobile/views/customer/sale_transaction_detail_page/widgets/review_popup_widget.dart';
import 'package:petapp_mobile/views/customer/sale_transaction_detail_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/customer/sale_transaction_detail_page/widgets/web_view.dart';

class SaleTransactionDetailPage
    extends GetView<SaleTransactionDetailPageController> {
  const SaleTransactionDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: GetBuilder<SaleTransactionDetailPageController>(builder: (_) {
        controller.isLoading.value = true;

        WidgetsBinding.instance!.addPostFrameCallback((_) async {
          controller.saleTransactionModel =
              await SaleTransactionService.fecthSaleTransactionById(
                  saleTransactionId:
                      int.parse(Get.parameters['saleTransactionId']!));
          controller.saleTransactionModel.petModel!.breedModel =
              await BreedService.fecthBreedById(
                  breedId: controller.saleTransactionModel.petModel!.breedId!);
          controller.saleTransactionModel.petModel!.breedModel!.speciesModel =
              await SpeciesService.fecthSpeciesById(
                  speciesId: controller
                      .saleTransactionModel.petModel!.breedModel!.speciesId!);

          controller.isLoading.value = false;
        });
        return Stack(
          children: [
            Column(
              children: [
                const SaleTransactionDetailTopWidget(),
                Obx(
                  () => controller.isLoading.value
                      ? Expanded(
                          child: Container(
                            color: const Color.fromARGB(106, 198, 188, 201),
                            alignment: Alignment.center,
                            child: const SpinKitSpinningLines(
                              color: PRIMARY_COLOR,
                              size: 150,
                            ),
                          ),
                        )
                      : Expanded(
                          child: Column(
                            children: const [
                              SaleTransactionDetaiBodyWidget(),
                              SaleTransactionDetailBottomWidget(),
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
                        SaleTransactionDetailWebViewWidget(),
                        SaleTransactionPopupWidget(),
                        SaleTransactionReviewPopupWidget(),
                        SaleTransactionMoreOptionWidget(),
                      ],
                    ),
            ),
          ],
        );
      }),
    );
  }
}
