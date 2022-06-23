import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/breeding_transaction_detail_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class BreedingTransactionDetailConfirmPopupWidget
    extends GetView<BreedingTransactionDetailPageController> {
  const BreedingTransactionDetailConfirmPopupWidget({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Obx(
        () => controller.isShowConfirmPopup.value
            ? InkWell(
                onTap: () => controller.isShowConfirmPopup.value = false,
                child: Container(
                  color: DARK_GREY_TRANSPARENT,
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () =>
                                controller.isShowConfirmPopup.value = false,
                          ),
                        ),
                        Container(
                          width: 300,
                          decoration: BoxDecoration(
                            color: WHITE_COLOR,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CUSTOM_TEXT(
                                controller.confirmPopupTitle,
                                textOverflow: TextOverflow.clip,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: MaterialButton(
                                        onPressed: () => controller
                                          ..isShowConfirmPopup.value = false
                                          ..isShowMoreOptionWidget.value =
                                              false,
                                        color: PRIMARY_LIGHT_COLOR,
                                        child: Text(
                                          'Cancel',
                                          style: GoogleFonts.quicksand(
                                            color: PRIMARY_COLOR,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 24,
                                    ),
                                    Expanded(
                                      child: MaterialButton(
                                        onPressed: controller.onTapOk,
                                        color: PRIMARY_COLOR,
                                        child: Text(
                                          'OK',
                                          style: GoogleFonts.quicksand(
                                            color: WHITE_COLOR,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () =>
                                controller.isShowConfirmPopup.value = false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      );
}
