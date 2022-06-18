import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/create_post_page_controller.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';
import 'package:petapp_mobile/models/species_model/species_model.dart';
import 'package:petapp_mobile/services/pet_services/pet_services.dart';
import 'package:petapp_mobile/services/pet_services/species_services.dart';

class SelectPetWidget extends GetView<CreatePostPageController> {
  const SelectPetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreatePostPageController>(builder: (_) {
      controller.isShowLoadingPet.value = true;

      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        if (controller.isShowPetFilter) {
          controller.species = await SpeciesService.fetchSpeciesList();
          controller.selectedSpeciesId.value == -1
              ? controller.selectedSpeciesId.value = controller.species[0].id
              : null;
          controller
            ..pets = await PetService.fetchPetListToCreatePost(
              customerId: controller.accountModel.customerModel.id,
              speciesId: controller.selectedSpeciesId.value,
              type: controller.selectedPostType.value,
              gender:
                  controller.selectedPostType.value == 'BREED' ? 'MALE' : null,
            )
            ..isShowPetDropdownList.value = true;
        } else {
          controller
            ..pets = await PetService.fetchPetListToCreatePost(
              customerId: controller.accountModel.customerModel.id,
              type: controller.selectedPostType.value,
              gender:
                  controller.selectedPostType.value == 'BREED' ? 'MALE' : null,
            )
            ..isShowPetDropdownList.value = true;
        }

        controller
          ..selectedPetId.value =
              controller.pets.isNotEmpty ? controller.pets[0].id : -1
          ..petOwnerVaccinationDescription =
              controller.selectedPetId.value != -1
                  ? (controller.pets[0].vaccineDescription ?? '')
                  : ''
          ..vaccinationDescription =
              controller.isUsePetOwnerVaccinationDescription.value
                  ? controller.petOwnerVaccinationDescription
                  : ''
          ..vaccinationDescriptionTextEditingController.text =
              controller.vaccinationDescription
          ..isShowLoadingPet.value = false;
      });
      return Obx(() => controller.isShowLoadingPet.value
          ? const SpinKitSpinningLines(
              color: PRIMARY_COLOR,
              size: 40,
            )
          : Column(
              children: [
                selectPetWidget(),
                !controller.isShowPetFilter
                    ? const SizedBox.shrink()
                    : petFilterWidget(),
                petVaccinationDescriptionWidget()
              ],
            ));
    });
  }

  Widget petVaccinationDescriptionWidget() {
    return Obx(
      () => controller.selectedPetId.value == -1
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.only(top: 20, right: 12, left: 12),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Vaccination description',
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 61, 78, 100),
                              fontSize: 16,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Icon(
                              Icons.info_outline_rounded,
                              size: 15,
                              color: DARK_GREY_COLOR.withAlpha(100),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: 100,
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 167, 181, 201),
                        width: 1.2,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Obx(
                              () => Container(
                                width: 20,
                                height: 20,
                                margin: const EdgeInsets.only(right: 5),
                                child: Checkbox(
                                  value: controller
                                      .isUsePetOwnerVaccinationDescription
                                      .value,
                                  onChanged: (isCheck) {
                                    controller
                                        .isUsePetOwnerVaccinationDescription
                                        .value = isCheck!;
                                    if (isCheck) {
                                      controller
                                        ..vaccinationDescription = controller
                                            .petOwnerVaccinationDescription
                                        ..vaccinationDescriptionTextEditingController
                                                .text =
                                            controller.vaccinationDescription;
                                    }
                                  },
                                  activeColor: PRIMARY_COLOR,
                                ),
                              ),
                            ),
                            Text(
                              'Use pet owner vaccination description',
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 85, 103, 128),
                                fontSize: 13,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TextFormField(
                                minLines: 3,
                                maxLines: 3,
                                maxLength: 40,
                                controller: controller
                                    .vaccinationDescriptionTextEditingController,
                                onChanged: (String text) {
                                  controller.vaccinationDescription = text;
                                },
                                keyboardType: TextInputType.multiline,
                                cursorColor: PRIMARY_COLOR,
                                style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      const Color.fromARGB(255, 113, 135, 168),
                                  fontSize: 15,
                                  letterSpacing: 1,
                                ),
                                decoration: InputDecoration(
                                  hintText:
                                      'Type pet vaccination description here...',
                                  hintStyle: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.w500,
                                    color: const Color.fromARGB(
                                        255, 162, 176, 194),
                                    fontSize: 13,
                                    letterSpacing: 1,
                                  ),
                                  border: InputBorder.none,
                                  counterText: '',
                                  isCollapsed: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget petFilterWidget() => Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                'Pet species',
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  color: const Color.fromARGB(255, 106, 122, 143),
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 40, top: 10),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  runAlignment: WrapAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  spacing: 10,
                  runSpacing: 10,
                  children: controller.species
                      .asMap()
                      .entries
                      .map((e) => speciesItemWidget(speciesModel: e.value))
                      .toList(),
                ),
              ),
            ],
          ),
        ],
      );

  Widget speciesItemWidget({required SpeciesModel speciesModel}) =>
      GetBuilder<CreatePostPageController>(
        builder: (_) => Container(
          width: 55 + speciesModel.name.length * 10,
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () {
              controller.selectedSpeciesId.value = speciesModel.id;
              controller.update();
            },
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: controller.selectedSpeciesId.value == speciesModel.id
                    ? PRIMARY_COLOR
                    : PRIMARY_COLOR.withOpacity(0.13),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: controller.selectedSpeciesId.value == speciesModel.id
                        ? PRIMARY_COLOR.withOpacity(0.7)
                        : WHITE_COLOR,
                    offset: const Offset(1, 1),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    speciesModel.imageUrl!,
                    height: 25,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    speciesModel.name,
                    style: GoogleFonts.itim(
                      color:
                          speciesModel.id == controller.selectedSpeciesId.value
                              ? WHITE_COLOR
                              : PRIMARY_COLOR.withOpacity(0.7),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget selectPetWidget() => Column(
        children: [
          Container(
            height: 1,
            margin: const EdgeInsets.only(top: 10),
            color: LIGHT_GREY_COLOR.withOpacity(0.1),
          ),
          Container(
            height: 8,
            color: const Color.fromARGB(255, 247, 248, 250),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 20),
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
                      controller.pets.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: petItemWidget(
                                petModel: controller.pets.firstWhere(
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
                        ..isShowPetFilter = !controller.isShowPetFilter
                        ..update(),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: controller.isShowPetFilter
                                  ? PRIMARY_COLOR
                                  : const Color.fromARGB(255, 156, 175, 202),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(5),
                            color: controller.isShowPetFilter
                                ? PRIMARY_COLOR
                                : WHITE_COLOR),
                        child: Center(
                          child: SvgPicture.asset(
                            ICON_PATH + FILTER_SVG,
                            height: 18,
                            color: controller.isShowPetFilter
                                ? WHITE_COLOR
                                : const Color.fromARGB(255, 102, 116, 136),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              controller.pets.isNotEmpty
                  ? petItemDropdownListWidget()
                  : const SizedBox.shrink()
            ]),
          ),
        ],
      );

  Widget petItemDropdownListWidget() {
    ScrollController scrollController = ScrollController();
    late double dropDownHeight;

    switch (controller.pets.length) {
      case 1:
        dropDownHeight = 52;
        break;
      case 2:
        dropDownHeight = 106;
        break;
      default:
        dropDownHeight = 160;
    }

    return Visibility(
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
                    children: controller.pets
                        .asMap()
                        .entries
                        .map(
                          (e) => petItemInDropdownListWidget(
                              petModel: e.value,
                              isLastIndex: e.key == controller.pets.length - 1),
                        )
                        .toList()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget petItemWidget({required PetModel petModel}) =>
      GetBuilder<CreatePostPageController>(
        builder: (_) => InkWell(
          onTap: () {
            controller.isShowPetDropdownList.value =
                !controller.isShowPetDropdownList.value;
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
              ..selectedPetId.value = petModel.id
              ..petOwnerVaccinationDescription =
                  petModel.vaccineDescription ?? ''
              ..vaccinationDescription =
                  controller.isUsePetOwnerVaccinationDescription.value
                      ? controller.petOwnerVaccinationDescription
                      : ''
              ..vaccinationDescriptionTextEditingController.text =
                  controller.vaccinationDescription,
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

  Widget transactionLocationWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: SvgPicture.asset(
                      ICON_PATH + LOCATION_SVG,
                      height: 20,
                      color: const Color.fromARGB(255, 61, 78, 100),
                    ),
                  ),
                  Text(
                    'Transaction location',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 61, 78, 100),
                      fontSize: 16,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    '*',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w800,
                      color: const Color.fromARGB(255, 241, 99, 88),
                      fontSize: 20,
                      height: 0.8,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
