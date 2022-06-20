import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/buy_services_combo_page_controller.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';

class BuyServicesComboSelectPetWidget
    extends GetView<BuyServicesComboPageController> {
  const BuyServicesComboSelectPetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
            color: WHITE_COLOR,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Select pet',
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 78, 98, 124),
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '*',
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w800,
                          color: const Color.fromARGB(255, 241, 99, 88),
                          fontSize: 20,
                        ),
                      ),
                      controller.petModelList.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: petItemWidget(
                                petModel: controller.petModelList.firstWhere(
                                    (element) =>
                                        element.id ==
                                        controller.selectedPetId.value),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                'No suitable pet!',
                                style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.w700,
                                  color:
                                      const Color.fromARGB(255, 244, 55, 159),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: InkWell(
                      onTap: () => controller
                        ..isShowPetFilter.value =
                            !controller.isShowPetFilter.value
                        ..isLoadingPet = true
                        ..update(),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: controller.isShowPetFilter.value
                                  ? PRIMARY_COLOR
                                  : const Color.fromARGB(255, 156, 175, 202),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(5),
                            color: controller.isShowPetFilter.value
                                ? PRIMARY_COLOR
                                : WHITE_COLOR),
                        child: Center(
                          child: SvgPicture.asset(
                            ICON_PATH + FILTER_SVG,
                            height: 18,
                            color: controller.isShowPetFilter.value
                                ? WHITE_COLOR
                                : const Color.fromARGB(255, 102, 116, 136),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              controller.petServicesComboModelList.isNotEmpty
                  ? petItemDropdownListWidget()
                  : const SizedBox.shrink(),
            ]),
          ),
          Container(
            height: 1,
            color: LIGHT_GREY_COLOR.withAlpha(30),
          ),
        ],
      );

  Widget petItemDropdownListWidget() {
    ScrollController scrollController = ScrollController();
    late double dropDownHeight;

    switch (controller.petServicesComboModelList.length) {
      case 1:
        dropDownHeight = 52;
        break;
      case 2:
        dropDownHeight = 106;
        break;
      default:
        dropDownHeight = 160;
    }

    return Obx(
      () => Visibility(
        visible: controller.isShowPetDropdownList.value,
        child: Stack(
          children: [
            Positioned(
              right: 15,
              top: 6,
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(45 / 360),
                child: Container(
                  height: 10,
                  width: 10,
                  color: const Color.fromARGB(255, 179, 187, 202),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 18, top: 10),
              height: dropDownHeight,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 179, 187, 202),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: RawScrollbar(
                controller: scrollController,
                isAlwaysShown: true,
                thumbColor: PRIMARY_COLOR.withOpacity(0.7),
                thickness: 2.5,
                radius: const Radius.circular(5),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                      children: controller.petModelList
                          .asMap()
                          .entries
                          .map(
                            (e) => petItemInDropdownListWidget(
                                petModel: e.value,
                                isLastIndex: e.key ==
                                    controller.petModelList.length - 1),
                          )
                          .toList()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget petItemWidget({required PetModel petModel}) =>
      GetBuilder<BuyServicesComboPageController>(
        builder: (_) => InkWell(
          onTap: () {
            controller
              ..isShowPetDropdownList.value =
                  !controller.isShowPetDropdownList.value
              ..isLoadingPet = true;
          },
          child: Container(
            height: 50,
            width: 170,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(color: PRIMARY_COLOR),
                color: PRIMARY_LIGHT_COLOR.withOpacity(0.5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(9.8),
                  child: Image.network(
                    petModel.avatar,
                    height: 50,
                    width: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (_, object, stackTrace) => Image.asset(
                      IMAGE_PATH + NO_IMAGE_PNG,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    petModel.name,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: PRIMARY_COLOR,
                      fontSize: 16,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  color: PRIMARY_COLOR,
                  size: 32,
                ),
              ],
            ),
          ),
        ),
      );

  Widget petItemInDropdownListWidget(
          {required PetModel petModel, required bool isLastIndex}) =>
      Column(
        children: [
          InkWell(
            onTap: () => controller
              ..isShowPetDropdownList.value = false
              ..selectedPetId.value = petModel.id,
            child: Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 247, 248, 250),
                borderRadius: BorderRadius.circular(9.8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 20,
                        height: 45,
                        decoration: BoxDecoration(
                            color: controller.selectedPetId.value == petModel.id
                                ? PRIMARY_COLOR
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            petModel.avatar,
                            height: 45,
                            width: 77.5,
                            fit: BoxFit.cover,
                            errorBuilder: (_, object, stackTrace) =>
                                Image.asset(
                              IMAGE_PATH + NO_IMAGE_PNG,
                              fit: BoxFit.cover,
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Text(
                      petModel.name,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w500,
                        color: controller.selectedPetId.value == petModel.id
                            ? PRIMARY_COLOR
                            : const Color.fromARGB(255, 121, 128, 141),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          !isLastIndex
              ? Container(
                  height: 4,
                  width: 200,
                  color: const Color.fromARGB(255, 247, 248, 250),
                  alignment: Alignment.center,
                  child: Container(
                    height: 1,
                    width: 190,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 179, 187, 202),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      );
}
