import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/booking_breeding_service_page_controller.dart';

class BookingBreedingServicesPopupWidget
    extends GetView<BookingBreedingServicesPageController> {
  const BookingBreedingServicesPopupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Obx(
        () => controller.isShowPopup.value
            ? Container(
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
                        controller.popupTitle,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                          textStyle: TextStyle(
                            color: !controller.isErrorPopup
                                ? DARK_GREY_TEXT_COLOR.withOpacity(0.95)
                                : RED_COLOR,
                          ),
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          height: 1.2,
                          letterSpacing: 1,
                        ),
                      ),
                      Icon(
                        !controller.isErrorPopup
                            ? Icons.verified_outlined
                            : Icons.error,
                        size: 70,
                        color: !controller.isErrorPopup
                            ? PRIMARY_COLOR
                            : RED_COLOR,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: InkWell(
                          onTap: controller.onTapPopup,
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: !controller.isErrorPopup
                                  ? PRIMARY_COLOR
                                  : RED_COLOR,
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
            : const SizedBox.shrink(),
      );
}
