import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_management_page_controller.dart';

class PetManagementConfirmDeletePopupWidget
    extends GetView<PetManagementPageController> {
  const PetManagementConfirmDeletePopupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Obx(
        () => controller.isShowConfirmDeletePopup.value
            ? InkWell(
                onTap: () => controller.isShowConfirmDeletePopup.value = false,
                child: Container(
                  color: DARK_GREY_TRANSPARENT,
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => controller
                                .isShowConfirmDeletePopup.value = false,
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
                                    text: 'Are you sure to ',
                                    style: GoogleFonts.quicksand(
                                      color: DARK_GREY_TEXT_COLOR,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1,
                                    ),
                                    children: <TextSpan>[
                                      const TextSpan(
                                        text: 'Delete ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: RED_COLOR,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: 'pet ',
                                      ),
                                      TextSpan(
                                        text: controller.selectedPetModel.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: PRIMARY_COLOR,
                                          fontSize: 17,
                                        ),
                                      ),
                                      TextSpan(
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: DARK_GREY_TEXT_COLOR
                                                .withOpacity(0.8),
                                            fontSize: 14,
                                          ),
                                          text:
                                              ' (${controller.selectedPetModel.breedModel!.name} - ${controller.selectedPetModel.breedModel!.speciesModel!.name})'),
                                    ],
                                  ),
                                ),
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
                                            .isShowConfirmDeletePopup
                                            .value = false,
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
                                        onPressed: () async {},
                                        color: PRIMARY_COLOR,
                                        child: Text(
                                          'Delete',
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
                                .isShowConfirmDeletePopup.value = false,
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
