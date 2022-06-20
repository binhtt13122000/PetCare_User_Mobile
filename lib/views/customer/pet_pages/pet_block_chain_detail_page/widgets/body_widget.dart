import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_block_chain_page_controller.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_block_chain_detail_page/widgets/health_records_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_block_chain_detail_page/widgets/pet_detail_information_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PetBlockChainDetailBodyWidget
    extends GetView<PetBlockChainPageController> {
  const PetBlockChainDetailBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        controller: controller.detailScrollController,
        child: Column(
          children: [
            petChainWidget(),
            petOwnerGeneralInformation(),
            viewTypeWidget(),
            Obx(() => controller.selectedViewType.value == 'Pet details'
                ? const PetBlockChainDetailInformationWidget()
                : const PetBlockChainDetailHeathRecordsWidget())
          ],
        ),
      ),
    );
  }

  Widget viewTypeWidget() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: controller.viewTypes
            .asMap()
            .entries
            .map((e) => viewTypeItemWidget(viewType: e.value))
            .toList(),
      );

  Widget viewTypeItemWidget({required String viewType, int flex = 1}) =>
      Expanded(
        flex: flex,
        child: Obx(
          () => InkWell(
            onTap: () => controller.selectedViewType.value = viewType,
            child: Column(
              children: [
                Container(
                  height: 30,
                  color: controller.selectedViewType.value == viewType
                      ? PRIMARY_LIGHT_COLOR.withOpacity(0.3)
                      : Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      controller.selectedViewType.value == viewType
                          ? const Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: CircleAvatar(
                                maxRadius: 3,
                                backgroundColor: PRIMARY_COLOR,
                              ),
                            )
                          : const SizedBox.shrink(),
                      Text(
                        viewType,
                        style: GoogleFonts.quicksand(
                          color: controller.selectedViewType.value == viewType
                              ? PRIMARY_COLOR
                              : const Color.fromARGB(255, 116, 122, 143),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 3,
                  color: controller.selectedViewType.value == viewType
                      ? PRIMARY_COLOR
                      : const Color.fromARGB(255, 233, 235, 241),
                ),
              ],
            ),
          ),
        ),
      );

  Widget petChainWidget() => Column(
        children: [
          Container(
            color: WHITE_COLOR,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child: Column(
              children: [
                CUSTOM_TEXT(
                  'Record Information',
                  letterSpacing: 1.5,
                  padding: const EdgeInsets.only(bottom: 10),
                  color: DARK_GREY_TEXT_COLOR.withOpacity(0.95),
                  fontWeight: FontWeight.w700,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CUSTOM_TEXT(
                          'Record time',
                          letterSpacing: 1,
                          fontSize: 14,
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                        ),
                        CUSTOM_TEXT(
                          FORMAT_DATE_TIME(
                              dateTime: DateTime.now(),
                              pattern: DATE_PATTERN_2),
                          letterSpacing: 1,
                          fontSize: 15,
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CUSTOM_TEXT(
                          'Type',
                          letterSpacing: 1,
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                          fontSize: 14,
                        ),
                        CUSTOM_TEXT(
                          controller.petChainValueModel.type == 'UPDATE'
                              ? 'Update pet information'
                              : 'Create pet information',
                          letterSpacing: 1,
                          fontSize: 15,
                          color: controller.petChainValueModel.type == 'UPDATE'
                              ? BLUE_COLOR
                              : GREEN_COLOR,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CUSTOM_TEXT(
                          'Content',
                          letterSpacing: 1,
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                          fontSize: 14,
                          padding: const EdgeInsets.only(right: 85),
                        ),
                        Expanded(
                          child: CUSTOM_TEXT(
                            controller.petChainValueModel
                                .petChainValueContentModel.write,
                            letterSpacing: 1,
                            fontSize: 15,
                            color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                            textOverflow: TextOverflow.clip,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CUSTOM_TEXT('Chain ID',
                              letterSpacing: 1,
                              fontSize: 14,
                              color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                              padding: const EdgeInsets.only(right: 80)),
                          Expanded(
                            child: CUSTOM_TEXT(
                              '#' + controller.petChainValueModel.txId,
                              letterSpacing: 1,
                              fontSize: 15,
                              color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                              textOverflow: controller.isShowFullId.value
                                  ? TextOverflow.clip
                                  : TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Obx(
                      () => InkWell(
                        onTap: () => controller.isShowFullId.value =
                            !controller.isShowFullId.value,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  controller.isShowFullId.value
                                      ? 'Hide full ID'
                                      : 'View full ID',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: PRIMARY_COLOR.withOpacity(0.75),
                                    letterSpacing: 2,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Icon(
                                  controller.isShowFullId.value
                                      ? Icons.keyboard_double_arrow_up_outlined
                                      : Icons
                                          .keyboard_double_arrow_down_outlined,
                                  size: 18,
                                  color: PRIMARY_COLOR.withOpacity(0.75),
                                )
                              ],
                            ),
                            Container(
                              height: 1,
                              margin: const EdgeInsets.only(top: 2),
                              width: 115,
                              color: PRIMARY_COLOR.withOpacity(0.75),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: LIGHT_GREY_COLOR.withAlpha(30),
          ),
          Container(
            height: 16,
            color: SUPPER_LIGHT_BLUE,
          ),
        ],
      );

  Widget avatarWidget({required String url}) => Stack(
        children: [
          GRADIENT_WIDGET(
            child: const CircleAvatar(
              maxRadius: 30,
              minRadius: 30,
            ),
          ),
          CircleAvatar(
            maxRadius: 30,
            minRadius: 30,
            backgroundColor: Colors.transparent,
            child: CircleAvatar(
              maxRadius: 27,
              minRadius: 27,
              backgroundImage: NetworkImage(url),
            ),
          ),
        ],
      );

  Widget petOwnerGeneralInformation() => Column(
        children: [
          Container(
            color: WHITE_COLOR,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child: Column(
              children: [
                CUSTOM_TEXT(
                  'Pet Owner General Information',
                  letterSpacing: 0.5,
                  color: DARK_GREY_TEXT_COLOR.withOpacity(0.95),
                  padding: const EdgeInsets.only(bottom: 10),
                  fontWeight: FontWeight.w700,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CUSTOM_TEXT(
                                'Name',
                                letterSpacing: 1,
                                fontSize: 14,
                                color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                              ),
                              CUSTOM_TEXT(
                                controller
                                        .petChainValueModel
                                        .petChainValueContentModel
                                        .petModel
                                        .currentPetOwner!
                                        .customerModel
                                        .firstName +
                                    ' ' +
                                    controller
                                        .petChainValueModel
                                        .petChainValueContentModel
                                        .petModel
                                        .currentPetOwner!
                                        .customerModel
                                        .lastName,
                                letterSpacing: 1,
                                fontSize: 15,
                                color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CUSTOM_TEXT(
                                'Phone number',
                                letterSpacing: 1,
                                fontSize: 14,
                                color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                              ),
                              CUSTOM_TEXT(
                                controller
                                    .petChainValueModel
                                    .petChainValueContentModel
                                    .petModel
                                    .currentPetOwner!
                                    .customerModel
                                    .phoneNumber,
                                letterSpacing: 1,
                                fontSize: 15,
                                color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CUSTOM_TEXT(
                                'Email',
                                letterSpacing: 1,
                                fontSize: 14,
                                color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                              ),
                              CUSTOM_TEXT(
                                controller
                                        .petChainValueModel
                                        .petChainValueContentModel
                                        .petModel
                                        .currentPetOwner!
                                        .customerModel
                                        .email
                                        .isEmpty
                                    ? 'N/A'
                                    : controller
                                        .petChainValueModel
                                        .petChainValueContentModel
                                        .petModel
                                        .currentPetOwner!
                                        .customerModel
                                        .email,
                                letterSpacing: 1,
                                fontSize: 15,
                                color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: LIGHT_GREY_COLOR.withAlpha(30),
          ),
          Container(
            height: 16,
            color: SUPPER_LIGHT_BLUE,
          ),
        ],
      );
}
