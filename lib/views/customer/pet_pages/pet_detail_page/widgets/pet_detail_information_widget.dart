import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_detail_page_controller.dart';
import 'package:petapp_mobile/services/pet_services/pet_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PetDetailInformationWidget extends GetView<PetDetailPageController> {
  const PetDetailInformationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      GetBuilder<PetDetailPageController>(builder: (_) {
        controller.isLoadingPetDetail.value = true;

        WidgetsBinding.instance!.addPostFrameCallback((_) async {
          controller
            ..petModel = await PetService.fetchPetById(
              jwt: controller.accountModel.jwtToken,
              petId: controller.petModel.id.toString(),
            )
            ..isLoadingPetDetail.value = false;
        });
        return Obx(() => controller.isLoadingPetDetail.value
            ? Padding(
                padding: const EdgeInsets.only(top: 200),
                child: LOADING_WIDGET(),
              )
            : petDetailWidget());
      });

  Widget petDetailWidget() => Container(
        color: WHITE_COLOR,
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            petGeneralInformationWidget(),
            Container(
              height: 1,
              color: DARK_GREY_COLOR.withAlpha(30),
            ),
            Container(
              height: 10,
              color: SUPPER_LIGHT_BLUE,
              margin: const EdgeInsets.only(bottom: 20),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                children: [
                  speciesCardWidget(),
                  textCardWidget(
                    keyText: 'Breed',
                    valueText: controller.petModel.breedModel!.name,
                  ),
                  genderCardWidget(),
                  textCardWidget(
                    keyText: 'Date of birth',
                    valueText: FORMAT_DATE_TIME(
                      dateTime: controller.petModel.dob,
                      pattern: DATE_PATTERN,
                    ),
                  ),
                  textCardWidget(
                    keyText: 'Age range',
                    valueText: controller.petModel.ageRange,
                  ),
                  // textCardWidget(
                  //   keyText: 'Weight',
                  //   valueText: '7.5 Kilogram',
                  // ),
                  textCardWidget(
                    keyText: 'Color',
                    valueText: controller.petModel.color != null &&
                            controller.petModel.color!.isNotEmpty
                        ? controller.petModel.color!
                        : 'N/A',
                  ),
                  textCardWidget(
                    keyText: 'Fertility',
                    valueText: controller.petModel.isFertility
                        ? 'Available'
                        : 'Not available',
                  ),

                  textCardWidget(
                    keyText: 'Microchip ID',
                    valueText: controller.petModel.specialMarkings != null &&
                            controller.petModel.specialMarkings!.isNotEmpty
                        ? '#' + controller.petModel.specialMarkings!
                        : 'N/A',
                  ),
                  //  descriptionCardWidget(),
                ],
              ),
            ),
          ],
        ),
      );

  Widget descriptionCardWidget() => Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Obx(
          () => Column(
            children: [
              InkWell(
                onTap: () => controller.isViewPetPapers.value =
                    !controller.isViewPetPapers.value,
                child: SizedBox(
                  width: 180,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.isViewPetPapers.value
                                ? 'Hide pet papers'
                                : 'View pet papers',
                            style: GoogleFonts.quicksand(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: PRIMARY_COLOR,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Icon(
                            controller.isViewPetPapers.value
                                ? Icons.keyboard_double_arrow_up_outlined
                                : Icons.keyboard_double_arrow_down_outlined,
                            size: 18,
                            color: PRIMARY_COLOR,
                          )
                        ],
                      ),
                      Container(
                        height: 1,
                        color: PRIMARY_COLOR,
                        margin: const EdgeInsets.only(
                          top: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget petGeneralInformationWidget() {
    late String petStatusText;
    late Color petStatusColor;
    switch (controller.petModel.status) {
      case 'NORMAL':
        petStatusText = 'Normal';
        petStatusColor = GREEN_COLOR;
        break;
      case 'IN_POST':
        petStatusText = 'In a post';
        petStatusColor = YELLOW_COLOR;
        break;
      case 'IN_BREED':
        petStatusText = 'Breeding';
        petStatusColor = PINK_COLOR;
        break;
      default:
        petStatusText = controller.petModel.status;
        petStatusColor = YELLOW_COLOR;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          petGeneralInformationCardWidget(
            title: 'Status',
            content: petStatusText,
            contentColor: petStatusColor,
          ),
          petGeneralInformationCardWidget(
            title: 'Gender',
            content: controller.petModel.gender == 'MALE' ? 'Male' : 'Female',
            contentColor:
                controller.petModel.gender == 'MALE' ? BLUE_COLOR : PINK_COLOR,
          ),
          petGeneralInformationCardWidget(
            title: 'Age',
            content: controller.petModel.ageRange,
          ),
          petGeneralInformationCardWidget(
            title: 'Fertility',
            content:
                controller.petModel.isFertility ? 'Available' : 'Not available',
            contentColor:
                controller.petModel.isFertility ? GREEN_COLOR : RED_COLOR,
          ),
        ],
      ),
    );
  }

  Widget petGeneralInformationCardWidget({
    required String title,
    required String content,
    Color contentColor = DARK_GREY_TEXT_COLOR,
  }) =>
      Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(
            width: 1,
            color: Colors.black12,
          ),
          color: WHITE_COLOR.withOpacity(0.6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CUSTOM_TEXT(
              title,
              fontSize: 14,
              letterSpacing: 1,
              color: DARK_GREY_TEXT_COLOR.withOpacity(0.6),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: CUSTOM_TEXT(
                content,
                fontSize: 14,
                letterSpacing: 1,
                color: contentColor,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      );

  Widget textCardWidget({
    required String keyText,
    required String valueText,
  }) =>
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              keyText,
              style: GoogleFonts.quicksand(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: DARK_GREY_TEXT_COLOR.withOpacity(0.95),
              ),
            ),
            Expanded(
              child: CUSTOM_TEXT(
                valueText,
                fontSize: 15,
                textAlign: TextAlign.end,
              ),
            )
          ],
        ),
      );

  Widget speciesCardWidget() => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Species',
              style: GoogleFonts.quicksand(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 86, 104, 126),
              ),
            ),
            Row(
              children: [
                Image.asset(
                  controller.petModel.breedModel!.speciesModel!.imageUrl!,
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    controller.petModel.breedModel!.speciesModel!.name,
                    style: GoogleFonts.quicksand(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 86, 104, 126),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget genderCardWidget() => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Gender',
              style: GoogleFonts.quicksand(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 86, 104, 126),
              ),
            ),
            Row(
              children: [
                SvgPicture.asset(
                  controller.petModel.gender == 'MALE'
                      ? ICON_PATH + MALE_SVG
                      : ICON_PATH + FEMALE_SVG,
                  height: 13,
                  color: controller.petModel.gender == 'MALE'
                      ? BLUE_COLOR
                      : PINK_COLOR,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    controller.petModel.gender == 'MALE' ? 'Male' : 'Female',
                    style: GoogleFonts.quicksand(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: controller.petModel.gender == 'MALE'
                          ? BLUE_COLOR
                          : PINK_COLOR,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget textCardWidgetWithInfoIcon({
    required String keyText,
    required String valueText,
  }) =>
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  keyText,
                  style: GoogleFonts.quicksand(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: DARK_GREY_TEXT_COLOR.withOpacity(0.95),
                  ),
                ),
                const SizedBox(width: 5),
                const Icon(
                  Icons.info_outline_rounded,
                  size: 15,
                  color: DARK_GREY_TEXT_COLOR,
                ),
              ],
            ),
            Text(
              valueText,
              textAlign: TextAlign.right,
              style: GoogleFonts.quicksand(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 86, 104, 126),
              ),
            ),
          ],
        ),
      );

  Widget colorCardWidget() => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Colors',
              style: GoogleFonts.quicksand(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 86, 104, 126),
              ),
            ),
            Row(
              children: [
                Row(
                  children: [
                    Container(
                      height: 12,
                      width: 12,
                      margin: const EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        color: Colors.brown.withOpacity(0.5),
                        border: Border.all(
                          width: 1,
                          color: LIGHT_GREY_COLOR,
                        ),
                      ),
                    ),
                    Text(
                      'Brown ,',
                      style: GoogleFonts.quicksand(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 86, 104, 126),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 12,
                      width: 12,
                      margin: const EdgeInsets.only(
                        right: 5,
                        left: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 1,
                          color: LIGHT_GREY_COLOR,
                        ),
                      ),
                    ),
                    Text(
                      'White',
                      style: GoogleFonts.quicksand(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 86, 104, 126),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
}
