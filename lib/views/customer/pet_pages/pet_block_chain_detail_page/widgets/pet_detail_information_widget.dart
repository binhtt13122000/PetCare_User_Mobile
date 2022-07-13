import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_block_chain_page_controller.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PetBlockChainDetailInformationWidget
    extends GetView<PetBlockChainPageController> {
  const PetBlockChainDetailInformationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        color: WHITE_COLOR,
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  speciesCardWidget(),
                  textCardWidget(
                    keyText: 'Breed',
                    valueText: controller.petChainValueModel
                        .petChainValueContentModel.petModel.breedModel!.name,
                  ),
                  genderCardWidget(),
                  textCardWidget(
                    keyText: 'Date of birth',
                    valueText: FORMAT_DATE_TIME(
                      dateTime: controller.petChainValueModel
                          .petChainValueContentModel.petModel.dob,
                      pattern: DATE_PATTERN,
                    ),
                  ),
                  textCardWidgetWithInfoIcon(
                    keyText: 'Age range',
                    valueText: controller.petChainValueModel
                        .petChainValueContentModel.petModel.ageRange,
                  ),
                  textCardWidget(
                    keyText: 'Weight',
                    valueText: '7.5 Kilogram',
                  ),
                  textCardWidget(
                      keyText: 'Color',
                      valueText: controller
                                      .petChainValueModel
                                      .petChainValueContentModel
                                      .petModel
                                      .color !=
                                  null &&
                              controller
                                  .petChainValueModel
                                  .petChainValueContentModel
                                  .petModel
                                  .color!
                                  .isNotEmpty
                          ? controller.petChainValueModel
                              .petChainValueContentModel.petModel.color!
                          : 'N/A',
                      valueColor: controller
                                      .petChainValueModel
                                      .petChainValueContentModel
                                      .petModel
                                      .color !=
                                  null &&
                              controller
                                  .petChainValueModel
                                  .petChainValueContentModel
                                  .petModel
                                  .color!
                                  .isNotEmpty
                          ? DARK_GREY_TEXT_COLOR
                          : DARK_GREY_COLOR.withOpacity(0.5)),
                  textCardWidget(
                    keyText: 'Fertility',
                    valueText: controller.petChainValueModel
                            .petChainValueContentModel.petModel.isFertility
                        ? 'Available'
                        : 'Not available',
                    valueColor: controller.petChainValueModel
                            .petChainValueContentModel.petModel.isFertility
                        ? GREEN_COLOR
                        : RED_COLOR,
                  ),

                  textCardWidget(
                    keyText: 'Microchip ID',
                    valueText: controller
                                    .petChainValueModel
                                    .petChainValueContentModel
                                    .petModel
                                    .specialMarkings !=
                                null &&
                            controller
                                .petChainValueModel
                                .petChainValueContentModel
                                .petModel
                                .specialMarkings!
                                .isNotEmpty
                        ? controller.petChainValueModel
                            .petChainValueContentModel.petModel.specialMarkings!
                        : 'N/A',
                  ),
                  //  descriptionCardWidget(),
                ],
              ),
            ),
          ],
        ),
      );

  Widget textCardWidget({
    required String keyText,
    required String valueText,
    Color valueColor = DARK_GREY_TEXT_COLOR,
  }) =>
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CUSTOM_TEXT(
              keyText,
              fontSize: 15,
              color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
            ),
            CUSTOM_TEXT(
              valueText,
              fontSize: 15,
              color: valueColor,
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
                  controller.petChainValueModel.petChainValueContentModel
                      .petModel.breedModel!.speciesModel!.imageUrl!,
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    controller.petChainValueModel.petChainValueContentModel
                        .petModel.breedModel!.speciesModel!.name,
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
                  controller.petChainValueModel.petChainValueContentModel
                              .petModel.gender ==
                          'MALE'
                      ? ICON_PATH + MALE_SVG
                      : ICON_PATH + FEMALE_SVG,
                  height: 13,
                  color: controller.petChainValueModel.petChainValueContentModel
                              .petModel.gender ==
                          'MALE'
                      ? BLUE_COLOR
                      : PINK_COLOR,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    controller.petChainValueModel.petChainValueContentModel
                        .petModel.gender,
                    style: GoogleFonts.quicksand(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: controller.petChainValueModel
                                  .petChainValueContentModel.petModel.gender ==
                              'MALE'
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
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 86, 104, 126),
                  ),
                ),
                const SizedBox(width: 5),
                const Icon(
                  Icons.info_outline_rounded,
                  size: 15,
                  color: Color.fromARGB(255, 135, 151, 172),
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
