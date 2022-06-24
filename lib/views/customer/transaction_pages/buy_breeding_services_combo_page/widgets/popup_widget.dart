import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/breeding_transaction_detail_page_controller.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/buy_breeding_services_combo_page_controller.dart';

class BuyBreedingBreedingServicesComboPopupWidget
    extends GetView<BuyBreedingServicesComboPageController> {
  const BuyBreedingBreedingServicesComboPopupWidget({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Obx(
        () => Visibility(
          visible: controller.isShowPopup.value,
          child: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: DARK_GREY_TRANSPARENT,
            ),
            child: Container(
              height: 200,
              width: 250,
              decoration: BoxDecoration(
                color: WHITE_COLOR,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Payment Successfully',
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        color: true ? DARK_GREY_TEXT_COLOR : RED_COLOR,
                      ),
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      height: 1,
                      letterSpacing: 1,
                    ),
                  ),
                  const Icon(
                    true ? Icons.verified_outlined : Icons.error,
                    size: 70,
                    color: true ? PRIMARY_COLOR : RED_COLOR,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: InkWell(
                      onTap: () => true
                          ? () {
                              Get.back();
                              Get.put(BreedingTransactionDetailPageController())
                                  .update();
                            }.call()
                          : controller.isShowPopup.value = false,
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: true ? PRIMARY_COLOR : RED_COLOR,
                        ),
                        child: Text(
                          'OK',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.quicksand(
                            textStyle: const TextStyle(color: WHITE_COLOR),
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            height: 1,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
