import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/breeding_transaction_detail_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class BreedingTransactionViewDetailPopupWidget
    extends GetView<BreedingTransactionDetailPageController> {
  const BreedingTransactionViewDetailPopupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Obx(
        () => controller.isShowDetailPopup.value
            ? InkWell(
                onTap: () => controller.isShowDetailPopup.value = false,
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: DARK_GREY_TRANSPARENT,
                  ),
                  child: Column(
                    children: [
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          color: WHITE_COLOR,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(horizontal: 10),
                            //   child: Html(
                            //       data: controller.detailPopupContent ?? 'N/A'),
                            // ),
                            CUSTOM_TEXT(controller.detailPopupTitle ?? 'N/A',
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10)),
                            controller.detailPopupEvidence != null
                                ? ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(10),
                                    ),
                                    child: Image.network(
                                      controller.detailPopupEvidence!,
                                      width: 300,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              )
            : const SizedBox.shrink(),
      );
}
