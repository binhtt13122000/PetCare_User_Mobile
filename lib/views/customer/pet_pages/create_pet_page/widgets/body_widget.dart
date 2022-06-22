import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/add_pet_page_controller.dart';
import 'package:petapp_mobile/models/breed_model/breed_model.dart';
import 'package:petapp_mobile/models/species_model/species_model.dart';
import 'package:petapp_mobile/services/pet_services/breed_services.dart';
import 'package:petapp_mobile/services/pet_services/species_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class CreatePetBodyWidget extends GetView<CreatePetPageController> {
  const CreatePetBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.isLoadingData.value = true;
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      controller.species = await SpeciesService.fetchSpeciesList();
      controller.selectedSpeciesId.value = controller.species[0].id;
      controller.isLoadingData.value = false;
    });
    return Expanded(
      child: Obx(
        () => controller.isLoadingData.value
            ? const Center(
                child: SpinKitSpinningLines(
                  color: PRIMARY_COLOR,
                  size: 150,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    petNameWidget(),
                    petSpicesWidget(),
                    petBreedWidget(),
                    petAvatarWidget(),
                    genderAndFertilityWidget(),
                    const SizedBox(
                      height: 25,
                    ),
                    dateOfBirthWidget(),
                    const SizedBox(
                      height: 20,
                    ),
                    colorWidget(),
                    vaccinationInformationWidget(),
                    descriptionWidget(),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget fertilityWidget() => Padding(
        padding: const EdgeInsets.only(
          top: 5,
        ),
        child: Obx(
          () => InkWell(
            onTap: () => controller.selectedFertility.value == 'YES'
                ? controller.selectedFertility.value = 'NO'
                : controller.selectedFertility.value = 'YES',
            child: Row(
              children: [
                Container(
                  height: 30,
                  width: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: controller.selectedFertility.value == 'YES'
                        ? PRIMARY_COLOR
                        : const Color.fromARGB(255, 237, 240, 243),
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(7),
                    ),
                    border: Border.all(
                      color: controller.selectedFertility.value == 'YES'
                          ? PRIMARY_COLOR
                          : DARK_GREY_COLOR.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'YES',
                    style: GoogleFonts.quicksand(
                      color: controller.selectedFertility.value == 'YES'
                          ? WHITE_COLOR
                          : DARK_GREY_COLOR.withOpacity(0.3),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  width: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: controller.selectedFertility.value == 'NO'
                        ? PRIMARY_COLOR
                        : const Color.fromARGB(255, 237, 240, 243),
                    borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(7)),
                    border: Border.all(
                      color: controller.selectedFertility.value == 'NO'
                          ? PRIMARY_COLOR
                          : DARK_GREY_COLOR.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'NO',
                    style: GoogleFonts.quicksand(
                      color: controller.selectedFertility.value == 'NO'
                          ? WHITE_COLOR
                          : DARK_GREY_COLOR.withOpacity(0.3),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget dateOfBirthWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 5),
                    //   child: SvgPicture.asset(
                    //     ICON_PATH + CLOCK_SVG,
                    //     height: 17,
                    //     color: const Color.fromARGB(255, 61, 78, 100),
                    //   ),
                    // ),
                    Text(
                      'Date of birth',
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
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: InkWell(
                onTap: () => controller.isDisplayCalender.value = true,
                child: Container(
                  height: 45,
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 167, 181, 201),
                      width: 1.2,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Obx(
                          () => controller.dayOfBirthText.value.isEmpty
                              ? Text(
                                  'dd/MM/yyyy',
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.w500,
                                    color: const Color.fromARGB(
                                        255, 162, 176, 194),
                                    fontSize: 13,
                                    letterSpacing: 2,
                                  ),
                                )
                              : Text(
                                  controller.dayOfBirthText.value,
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.w500,
                                    color: const Color.fromARGB(
                                        255, 113, 135, 168),
                                    fontSize: 15,
                                    letterSpacing: 2,
                                  ),
                                ),
                        ),
                      ),
                      const Icon(
                        Icons.calendar_month_rounded,
                        color: PRIMARY_COLOR,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget genderWidget() => Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Obx(
          () => InkWell(
            onTap: () => controller.selectedGender.value == 'MALE'
                ? controller.selectedGender.value = 'FEMALE'
                : controller.selectedGender.value = 'MALE',
            child: Row(
              children: [
                Container(
                  height: 30,
                  width: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: controller.selectedGender.value == 'MALE'
                        ? const Color.fromARGB(255, 99, 194, 238)
                        : const Color.fromARGB(255, 237, 240, 243),
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(7),
                    ),
                    border: Border.all(
                      color: controller.selectedGender.value == 'MALE'
                          ? const Color.fromARGB(255, 99, 194, 238)
                          : DARK_GREY_COLOR.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'MALE',
                        style: GoogleFonts.quicksand(
                          color: controller.selectedGender.value == 'MALE'
                              ? WHITE_COLOR
                              : DARK_GREY_COLOR.withOpacity(0.3),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SvgPicture.asset(
                        ICON_PATH + MALE_SVG,
                        height: 14,
                        color: controller.selectedGender.value == 'MALE'
                            ? WHITE_COLOR
                            : DARK_GREY_COLOR.withOpacity(0.3),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 30,
                  width: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: controller.selectedGender.value == 'FEMALE'
                        ? const Color.fromARGB(255, 240, 128, 171)
                        : const Color.fromARGB(255, 237, 240, 243),
                    borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(7)),
                    border: Border.all(
                      color: controller.selectedGender.value == 'FEMALE'
                          ? const Color.fromARGB(255, 240, 128, 171)
                          : DARK_GREY_COLOR.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'FEMALE',
                        style: GoogleFonts.quicksand(
                          color: controller.selectedGender.value == 'FEMALE'
                              ? WHITE_COLOR
                              : DARK_GREY_COLOR.withOpacity(0.3),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SvgPicture.asset(
                        ICON_PATH + FEMALE_SVG,
                        height: 14,
                        color: controller.selectedGender.value == 'FEMALE'
                            ? WHITE_COLOR
                            : DARK_GREY_COLOR.withOpacity(0.3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget genderAndFertilityWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            //*Gender
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Gender',
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
                      ),
                    ),
                  ],
                ),
                genderWidget(),
              ],
            ),
            const SizedBox(width: 20),
            //*Fertility
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Fertility',
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
                      ),
                    ),
                  ],
                ),
                fertilityWidget(),
              ],
            ),
          ],
        ),
      );

  Widget petSpicesWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Row(
              children: [
                Text(
                  'Pet species',
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
                  ),
                ),
              ],
            ),
          ),
          listSpeciesItemWidget(),
        ],
      ),
    );
  }

  Widget petAvatarWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Text(
                  'Pet avatar',
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
                  ),
                ),
              ],
            ),
          ),
          avatarWidget(),
        ],
      ),
    );
  }

  Widget imageItemWidget({required File avatar}) => Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(7),
            ),
            child: Image.file(
              avatar,
              width: 280,
              height: 180,
              fit: BoxFit.cover,
            ),
          ),
          const Positioned(
            child: Icon(
              Icons.zoom_out_map,
              size: 30,
              color: PRIMARY_COLOR,
            ),
            bottom: 10,
            right: 10,
          ),
        ],
      );

  Widget avatarWidget() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Obx(
              () => controller.avatarUrl.value.isNotEmpty
                  ? imageItemWidget(avatar: controller.avatar!)
                  : DottedBorder(
                      color: LIGHT_GREY_COLOR.withOpacity(0.2),
                      strokeWidth: 1,
                      radius: const Radius.circular(30),
                      borderType: BorderType.RRect,
                      dashPattern: const [5, 5],
                      child: Container(
                        height: 140,
                        width: 240,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: LIGHT_GREY_COLOR.withOpacity(0.03),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No medias have \nbeen selected yet!',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.itim(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                color: DARK_GREY_TEXT_COLOR.withOpacity(0.4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 20,
                right: 50,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () async {
                      controller.avatar =
                          await PICK_IMAGE(isPickFromGalley: true);
                      controller.avatarUrl.value = controller.avatar!.path;
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: PRIMARY_COLOR.withOpacity(0.6),
                      child: SvgPicture.asset(
                        ICON_PATH + ADD_IMAGE_SVG,
                        color: WHITE_COLOR,
                        height: 21,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      controller.avatar =
                          await PICK_IMAGE(isPickFromGalley: false);
                      controller.avatarUrl.value = controller.avatar!.path;
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: PRIMARY_COLOR.withOpacity(0.6),
                      child: SvgPicture.asset(
                        ICON_PATH + CAMERA_SVG,
                        color: WHITE_COLOR,
                        height: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget petBreedWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Text(
                  'Pet breed',
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
                  ),
                ),
              ],
            ),
          ),
          listBreedItemWidget(),
        ],
      ),
    );
  }

  Widget listBreedItemWidget() =>
      GetBuilder<CreatePetPageController>(builder: (_) {
        controller.isLoadingBreedData.value = true;
        WidgetsBinding.instance!.addPostFrameCallback((_) async {
          controller.breeds = await BreedService.fetchBreedListBySpeciesId(
              speciesId: controller.selectedSpeciesId.value);
          controller.selectedBreedsId.value = controller.breeds[0].id;
          controller.isLoadingBreedData.value = false;
        });
        return Obx(
          () => controller.isLoadingBreedData.value
              ? const SpinKitSpinningLines(
                  color: PRIMARY_COLOR,
                  size: 80,
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    runAlignment: WrapAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    spacing: 10,
                    runSpacing: 10,
                    children: controller.breeds
                        .asMap()
                        .entries
                        .map((e) => breedItemWidget(breedModel: e.value))
                        .toList(),
                  ),
                ),
        );
      });

  Widget breedItemWidget({required BreedModel breedModel}) => Obx(
        () => InkWell(
          onTap: () {
            controller.selectedBreedsId.value = breedModel.id;
          },
          child: Container(
            height: 30,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: controller.selectedBreedsId.value == breedModel.id
                  ? PRIMARY_COLOR
                  : WHITE_COLOR,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: controller.selectedBreedsId.value == breedModel.id
                      ? PRIMARY_COLOR.withOpacity(0.7)
                      : WHITE_COLOR,
                  offset: const Offset(1, 1),
                  blurRadius: 8,
                ),
              ],
              border: Border.all(
                color: PRIMARY_COLOR.withOpacity(0.7),
                width: 1.5,
              ),
            ),
            child: Text(
              breedModel.name,
              style: GoogleFonts.itim(
                color: controller.selectedBreedsId.value == breedModel.id
                    ? WHITE_COLOR
                    : PRIMARY_COLOR.withOpacity(0.7),
                fontSize: 17,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          ),
        ),
      );

  Widget listSpeciesItemWidget() => Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.only(top: 5),
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
              .map((e) => specieItemWidget(speciesModel: e.value))
              .toList(),
        ),
      );

  Widget specieItemWidget({required SpeciesModel speciesModel}) => Obx(
        () => Container(
          width: 60 + speciesModel.name.length * 10,
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () => controller
              ..selectedSpeciesId.value = speciesModel.id
              ..update(),
            child: Container(
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: speciesModel.id == controller.selectedSpeciesId.value
                    ? PRIMARY_COLOR
                    : PRIMARY_COLOR.withOpacity(0.13),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: speciesModel.id == controller.selectedSpeciesId.value
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
                  speciesModel.imageUrl != null
                      ? Image.asset(
                          speciesModel.imageUrl!,
                          height: 25,
                        )
                      : const SizedBox.shrink(),
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
                  )
                ],
              ),
            ),
          ),
        ),
      );

  Widget petNameWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 45,
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                Text(
                  'Pet name',
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
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: CUSTOM_REQUIRED_TEXT_FIELD(
              hintText: 'Type your pet name here...',
              maxLength: 20,
              onChange: (String? text) {
                controller
                  ..petName.value = text ?? ''
                  ..isFirstInputPetName.value = false;
              },
              checkEmptyString: <bool>() {
                return controller.petName.value.isEmpty;
              },
              checkErrorText: <bool>() {
                return controller.petName.value.isEmpty &&
                    !controller.isFirstInputPetName.value;
              },
              onDelete: () {
                controller.petName.value = '';
              },
              errorText: 'Field pet name is required!',
              countText: <String>() {
                return controller.petName.value.length.toString() + '/20';
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget colorWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 45,
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                Text(
                  'Pet color',
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 61, 78, 100),
                    fontSize: 16,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: CUSTOM_REQUIRED_TEXT_FIELD(
              hintText: 'Type your pet color here...',
              maxLength: 20,
              onChange: (String? text) {
                controller.color.value = text ?? '';
              },
              checkEmptyString: <bool>() {
                return controller.color.value.isEmpty;
              },
              checkErrorText: <bool>() {
                return false;
              },
              onDelete: () {
                controller.color.value = '';
              },
              errorText: '',
              countText: <String>() {
                return controller.color.value.length.toString() + '/20';
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget vaccinationInformationWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Row(
              children: [
                Text(
                  'Vaccination information',
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
          ),
          CUSTOM_REQUIRED_TEXT_FIELD(
              hintText: 'Type your pet vaccination information here...',
              maxLength: 200,
              height: 80,
              maxLines: 3,
              onChange: (String? text) {
                controller.vaccineDescription.value = text ?? '';
              },
              checkEmptyString: <bool>() {
                return controller.vaccineDescription.value.isEmpty;
              },
              checkErrorText: <bool>() {
                return false;
              },
              onDelete: () {
                controller.vaccineDescription.value = '';
              },
              errorText: '',
              countText: <String>() {
                return controller.vaccineDescription.value.length.toString() +
                    '/200';
              },
              padding: const EdgeInsets.only(top: 5)),
        ],
      ),
    );
  }

  Widget descriptionWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Text(
              'Description',
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(255, 61, 78, 100),
                fontSize: 16,
                letterSpacing: 0.5,
              ),
            ),
          ),
          CUSTOM_REQUIRED_TEXT_FIELD(
              hintText: 'More information about your pet...',
              maxLength: 200,
              height: 80,
              maxLines: 3,
              onChange: (String? text) {
                controller.description.value = text ?? '';
              },
              checkEmptyString: <bool>() {
                return controller.description.value.isEmpty;
              },
              checkErrorText: <bool>() {
                return false;
              },
              onDelete: () {
                controller.description.value = '';
              },
              errorText: '',
              countText: <String>() {
                return controller.description.value.length.toString() + '/200';
              },
              padding: const EdgeInsets.only(top: 5)),
        ],
      ),
    );
  }
}
