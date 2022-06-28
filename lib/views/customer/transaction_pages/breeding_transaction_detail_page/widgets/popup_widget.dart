import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/breeding_transaction_detail_page_controller.dart';

class BreedingTransactionDetailPopupWidget
    extends GetView<BreedingTransactionDetailPageController> {
  const BreedingTransactionDetailPopupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Obx(() => controller.isShowPopup.value
      ? Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: DARK_GREY_TRANSPARENT,
          ),
          child: Container(
            height: 220,
            width: 270,
            decoration: BoxDecoration(
              color: WHITE_COLOR,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    controller.popupTitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                        color: DARK_GREY_TEXT_COLOR,
                      ),
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      height: 1,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const Icon(
                  Icons.verified_outlined,
                  size: 70,
                  color: PRIMARY_COLOR,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: InkWell(
                    onTap: () => controller
                      ..isShowPopup.value = false
                      ..isShowBottomWidget.value = false
                      ..update(),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: PRIMARY_COLOR,
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
        )
      : const SizedBox.shrink());
}
