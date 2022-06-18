import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_combo_detail_page_controller.dart';

class PetComboDetailNotificationPopupWidget
    extends GetView<PetComboDetailPageController> {
  const PetComboDetailNotificationPopupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Obx(
        () => controller.isShowNotificationPopup.value
            ? InkWell(
                onTap: () => controller.isShowNotificationPopup.value = false,
                child: Container(
                  color: DARK_GREY_TRANSPARENT,
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => controller.isShowPopup.value = false,
                          ),
                        ),
                        Container(
                          width: 340,
                          decoration: BoxDecoration(
                            color: WHITE_COLOR,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: controller.notificationTitle,
                                    style: GoogleFonts.quicksand(
                                      color: DARK_GREY_TEXT_COLOR,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: controller
                                            .selectedPetComboDetailModel
                                            .centerServiceModel
                                            .name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: PRIMARY_COLOR,
                                          fontSize: 17,
                                        ),
                                      ),
                                      const TextSpan(text: ' successfully!'),
                                    ],
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Icon(
                                  Icons.verified,
                                  color: PRIMARY_COLOR,
                                  size: 70,
                                ),
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
                                        onPressed: () async {
                                          controller
                                            ..isShowNotificationPopup.value =
                                                false
                                            ..update();
                                        },
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
                            onTap: () => controller
                                .isShowNotificationPopup.value = false,
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
