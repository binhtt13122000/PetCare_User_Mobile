import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_block_chain_page_controller.dart';
import 'package:petapp_mobile/models/pet_chain_value_model/pet_chain_value_model.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/customer/pet_pages/pet_block_chain/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PetBlockChainBodyWidget extends GetView<PetBlockChainPageController> {
  const PetBlockChainBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const PetBlockChainTopWidget(),
          petIdWidget(),
          Expanded(
            child: controller.petChainModel != null
                ? SingleChildScrollView(
                    controller: controller.scrollController,
                    child: Column(
                      children: [
                        petGeneralInformation(),
                        vaccinationsTimeLineWidget(),
                      ],
                    ))
                : Center(
                    child: CUSTOM_TEXT('No data'),
                  ),
          ),
        ],
      ),
    );
  }

  Widget petIdWidget() => Container(
        color: SUPPER_LIGHT_BLUE,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CUSTOM_TEXT(
              'Pet ID',
              fontSize: 13,
              color: DARK_GREY_TEXT_COLOR.withOpacity(0.7),
            ),
            CUSTOM_TEXT(
              (controller.petId < 10 ? '#' : '#') + controller.petId.toString(),
              fontSize: 13,
              color: DARK_GREY_TEXT_COLOR.withOpacity(0.7),
            ),
          ],
        ),
      );

  Widget petDetailAvatarWidget() => Stack(
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
              backgroundImage: NetworkImage(controller.petModel.avatar),
            ),
          ),
        ],
      );

  Widget petGeneralInformation() => Column(
        children: [
          Container(
            color: WHITE_COLOR,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child: Column(
              children: [
                CUSTOM_TEXT('Pet General Information',
                    letterSpacing: 1,
                    color: DARK_GREY_TEXT_COLOR.withOpacity(0.95),
                    fontWeight: FontWeight.w700,
                    padding: const EdgeInsets.only(bottom: 10)),
                Row(
                  children: [
                    // petDetailAvatarWidget(),
                    // const SizedBox(
                    //   width: 10,
                    // ),
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
                              ),
                              Row(
                                children: [
                                  CUSTOM_TEXT(
                                    controller.petModel.name,
                                    letterSpacing: 1,
                                    fontSize: 15,
                                    color:
                                        DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                                  ),
                                  CUSTOM_TEXT(
                                    ' (' +
                                        (controller.petModel.gender == 'MALE'
                                            ? 'Male'
                                            : 'Female') +
                                        ')',
                                    letterSpacing: 1,
                                    fontSize: 15,
                                    color: controller.petModel.gender == 'MALE'
                                        ? BLUE_COLOR
                                        : PINK_COLOR,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CUSTOM_TEXT(
                                'Breed',
                                letterSpacing: 1,
                                fontSize: 14,
                              ),
                              CUSTOM_TEXT(
                                controller.petModel.breedModel!.name +
                                    ' - ' +
                                    controller.petModel.breedModel!
                                        .speciesModel!.name,
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
                                'Microchip ID',
                                letterSpacing: 1,
                                fontSize: 14,
                              ),
                              CUSTOM_TEXT(
                                controller.petModel.specialMarkings ?? 'N/A',
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

  Widget vaccinationsTimeLineWidget() {
    DateTime currentTime = DateTime.now();
    return Container(
      color: WHITE_COLOR,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          CUSTOM_TEXT(
            'Pet History Timeline',
            letterSpacing: 1,
            padding: const EdgeInsets.only(bottom: 20),
            color: DARK_GREY_TEXT_COLOR.withOpacity(0.95),
            fontWeight: FontWeight.w700,
          ),
          Column(
            children: controller.petChainModel!.valueModelList
                .asMap()
                .entries
                .map((e) => vaccinationsTimeLineItemWidget(
                      petChainValueModel: e.value,
                      currentTime: currentTime,
                      index: e.key + 1,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget vaccinationsTimeLineItemWidget(
      {required PetChainValueModel petChainValueModel,
      required DateTime currentTime,
      required int index}) {
    int durationDays =
        (currentTime.difference(petChainValueModel.date).inHours / 24).ceil();

    String durationText = '';
    String durationUnit = '';

    if (durationDays >= 365) {
      durationText = (durationDays / 365).ceil().toString();
      durationUnit = ' years ago';
    } else if (durationDays >= 30) {
      durationText = (durationDays / 30).ceil().toString();
      durationUnit = ' months ago';
    } else if (durationDays != 0) {
      durationText = durationDays.toString();
      durationUnit = ' days ago';
    } else {
      durationText = 'Today';
      durationUnit = '';
    }

    Color backgroundColor = Colors.primaries[index].withOpacity(0.8);

    late final String chainStatusText;
    late final Color chainColor;

    switch (petChainValueModel.type) {
      case 'UPDATE':
        chainColor = BLUE_COLOR;
        chainStatusText = 'Update information';
        break;
      case 'CREATE':
        chainColor = GREEN_COLOR;
        chainStatusText = 'Init data';
        break;
      case 'CHANGE_OWNER':
        chainColor = YELLOW_COLOR;
        chainStatusText = 'Change owner';
        break;
      default:
        chainColor = YELLOW_COLOR;
        chainStatusText = petChainValueModel.type;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 80,
          height: 30,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: backgroundColor,
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              children: [
                CUSTOM_TEXT(
                  durationText,
                  textAlign: TextAlign.center,
                  color: WHITE_COLOR,
                  fontWeight: FontWeight.w700,
                ),
                CUSTOM_TEXT(
                  durationUnit,
                  textAlign: TextAlign.center,
                  color: WHITE_COLOR,
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: 30,
              child: CircleAvatar(
                backgroundColor: backgroundColor,
                minRadius: 10,
                maxRadius: 10,
              ),
            ),
            Container(
              height: 85,
              width: 2,
              margin: const EdgeInsets.symmetric(vertical: 10),
              color: LIGHT_GREY_COLOR.withOpacity(0.3),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CUSTOM_TEXT(
                  FORMAT_DATE_TIME(
                      dateTime: petChainValueModel.date,
                      pattern: DATE_PATTERN_2),
                  fontSize: 15,
                  color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
                Row(
                  children: [
                    CUSTOM_TEXT(
                      'Chain ID: ',
                      textOverflow: TextOverflow.clip,
                      fontSize: 14,
                      color: DARK_GREY_TEXT_COLOR.withOpacity(0.7),
                    ),
                    Expanded(
                      child: CUSTOM_TEXT(
                        '#' + petChainValueModel.txId,
                        textOverflow: TextOverflow.ellipsis,
                        fontSize: 15,
                        color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    CUSTOM_TEXT(
                      'Type: ',
                      textOverflow: TextOverflow.clip,
                      fontSize: 14,
                      color: DARK_GREY_TEXT_COLOR.withOpacity(0.7),
                    ),
                    CUSTOM_TEXT(
                      chainStatusText,
                      textOverflow: TextOverflow.clip,
                      fontSize: 15,
                      color: chainColor,
                    ),
                  ],
                ),
                RichText(
                  text: TextSpan(
                      text: 'Content: ',
                      style: GoogleFonts.quicksand(
                        fontSize: 14,
                        color: DARK_GREY_TEXT_COLOR.withOpacity(0.7),
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: petChainValueModel
                              .petChainValueContentModel.write,
                          style: TextStyle(
                            fontSize: 15,
                            color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                          ),
                        )
                      ]),
                ),
                showDescriptionWidget(
                  backgroundColor: backgroundColor,
                  index: index,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget showDescriptionWidget({
    required Color backgroundColor,
    required int index,
  }) =>
      InkWell(
        onTap: () {
          controller.chainIndex = index - 1;
          Get.toNamed('$PET_BLOCK_CHAIN_DETAIL_PAGE_ROUTE/${index - 1}');
        },
        child: SizedBox(
          width: 200,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'View details',
                    style: GoogleFonts.quicksand(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: backgroundColor.withOpacity(0.5),
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    Icons.keyboard_double_arrow_right,
                    size: 18,
                    color: backgroundColor.withOpacity(0.5),
                  )
                ],
              ),
              Container(
                height: 1,
                width: 130,
                color: backgroundColor.withOpacity(0.5),
                margin: const EdgeInsets.only(top: 2),
              ),
            ],
          ),
        ),
      );
}
