import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/add_pet_page_controller.dart';
import 'package:petapp_mobile/services/pet_services.dart';

class CreatePetBottomWidget extends GetView<CreatePetPageController> {
  const CreatePetBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        color: WHITE_COLOR,
        child: Column(
          children: [
            Container(
              height: 1,
              color: DARK_GREY_COLOR.withAlpha(50),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: InkWell(
                onTap: () async {
                  controller.isShowLoadingWidget.value = true;
                  await PetService.createPet(
                      ownerId: controller.accountModel.customerModel.id,
                      avtarFilePath: controller.avatarUrl.value,
                      name: controller.petName.value,
                      isSeed: controller.selectedFertility.value == 'YES',
                      gender: controller.selectedGender.value,
                      dob: controller.dateOfBirthTime!,
                      breedId: controller
                          .selectedBreedMap[controller.selectedSpeciesId.value]!
                          .value,
                      status: 'NORMAL');

                  controller.isShowLoadingWidget.value = false;
                  controller.isShowSuccessfullyPopup.value = true;
                },
                child: Obx(
                  () => Container(
                    height: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: controller.petName.value.isNotEmpty &&
                              controller.avatarUrl.value.isNotEmpty &&
                              controller.dayOfBirthText.value.isNotEmpty
                          ? PRIMARY_COLOR
                          : PRIMARY_COLOR.withOpacity(0.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Create A New Pet',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.quicksand(
                            textStyle: const TextStyle(color: WHITE_COLOR),
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            height: 1,
                            letterSpacing: 2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: SvgPicture.asset(
                            ICON_PATH + ADD_SVG,
                            color: WHITE_COLOR,
                            height: 19,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
