import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/rounter.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/add_pet_page_controller.dart';
import 'package:petapp_mobile/graphql/query_mutation/breed.dart';
import 'package:petapp_mobile/graphql/query_mutation/species.dart';
import 'package:petapp_mobile/models/breed_model/breed_model.dart';
import 'package:petapp_mobile/models/species_model/species_model.dart';
import 'package:petapp_mobile/services/breed_servies.dart';
import 'package:petapp_mobile/services/species_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:petapp_mobile/services/pet_services.dart';
//import 'package:tflite/tflite.dart';

class AddPetPage extends GetView<AddPetPageController> {
  const AddPetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //loadModel();

    return GraphQLProvider(
      client: controller.graphqlClient,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  topWidget(),
                  //*Title
                  Center(
                    child: Text(
                      'Add New Pet',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.itim(
                        fontSize: 40,
                        color: PRIMARY_COLOR,
                        height: 2,
                      ),
                    ),
                  ),
                  //*Information
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          nameTextFieldWidget(),
                          descriptionTextFieldWidget(),
                          //*Species
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(
                              left: 40,
                              top: 20,
                              bottom: 5,
                            ),
                            child: Text(
                              'Species',
                              style: GoogleFonts.itim(
                                  fontSize: 22,
                                  color: DARK_GREY_COLOR.withAlpha(200)),
                            ),
                          ),
                          listSpeciesItemWidget(),
                          //*Breeds
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(
                              left: 40,
                              top: 20,
                              bottom: 5,
                            ),
                            child: Text(
                              'Breeds',
                              style: GoogleFonts.itim(
                                  fontSize: 22,
                                  color: DARK_GREY_COLOR.withAlpha(200)),
                            ),
                          ),
                          listBreedItemWidget(),
                          const SizedBox(
                            height: 20,
                          ),
                          //*Avatar
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(
                              left: 40,
                            ),
                            child: Text(
                              'Avatar',
                              style: GoogleFonts.itim(
                                  fontSize: 22,
                                  color: DARK_GREY_COLOR.withAlpha(200)),
                            ),
                          ),
                          avatarWidget(),
                          GetBuilder<AddPetPageController>(
                            builder: (_) => controller.tmp == null
                                ? const Text('Hello')
                                : Text(controller.tmp![0]['label']
                                    .toString()
                                    .replaceAll(RegExp(r'[0-9]'), '')),
                          ),
                          Row(
                            children: [
                              //*Gender
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(
                                      left: 40,
                                      bottom: 10,
                                      top: 10,
                                    ),
                                    child: Text(
                                      'Gender',
                                      style: GoogleFonts.itim(
                                          fontSize: 22,
                                          color:
                                              DARK_GREY_COLOR.withAlpha(200)),
                                    ),
                                  ),
                                  genderWidget(),
                                ],
                              ),
                              //*Fertility
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                      bottom: 10,
                                      top: 10,
                                    ),
                                    child: Text(
                                      'Fertility',
                                      style: GoogleFonts.itim(
                                          fontSize: 22,
                                          color:
                                              DARK_GREY_COLOR.withAlpha(200)),
                                    ),
                                  ),
                                  fertilityWidget(),
                                ],
                              ),
                            ],
                          ),
                          //*Blood group
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(
                              left: 40,
                              bottom: 10,
                              top: 20,
                            ),
                            child: Text(
                              'Blood group',
                              style: GoogleFonts.itim(
                                  fontSize: 22,
                                  color: DARK_GREY_COLOR.withAlpha(200)),
                            ),
                          ),
                          listBloodGroup(),
                          //*Age range
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 180,
                                  child: Text(
                                    'Date of birth',
                                    style: GoogleFonts.quicksand(
                                      fontSize: 15,
                                      color: DARK_GREY_COLOR.withAlpha(170),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Text(
                                    'Age range',
                                    style: GoogleFonts.quicksand(
                                      fontSize: 15,
                                      color: DARK_GREY_COLOR.withAlpha(170),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                            ),
                            child: Row(
                              children: [
                                dateOfBirthTextFieldWidget(),
                                const SizedBox(
                                  width: 20,
                                ),
                                ageRangeTextFieldWidget(),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //*Add pet button
                  addPetButtonWidget()
                ],
              ),
              Obx(
                () => Visibility(
                  visible: controller.isDisplayCalender.value,
                  child: calendarWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget topWidget() => Container(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
          bottom: 10,
        ),
        decoration: BoxDecoration(
          color: WHITE_COLOR,
          boxShadow: [
            BoxShadow(
              color: DARK_GREY_COLOR.withOpacity(0.35),
              offset: const Offset(1, 1),
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //!back button
            InkWell(
              onTap: () => Get.back(),
              child: Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: PRIMARY_LIGHT_COLOR,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  ICON_PATH + BACK_SVG,
                  color: PRIMARY_COLOR,
                  height: 15,
                ),
              ),
            ),
            //!app logo
            Row(
              children: [
                SvgPicture.asset(
                  ICON_PATH + PET_LOGO_SVG,
                  color: PRIMARY_COLOR,
                  height: 29,
                ),
                const SizedBox(
                  width: 2,
                ),
                Text(
                  'iU Petshop',
                  style: GoogleFonts.satisfy(
                    textStyle: const TextStyle(color: PRIMARY_COLOR),
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                    height: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget imageItemWidget({required File avatar}) => Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(7),
            ),
            child: Image.file(
              avatar,
              width: 250,
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

  Widget breedItemWidget({required BreedModel breedModel}) => Obx(
        () => InkWell(
          onTap: () {
            controller.selectedBreedMap[controller.selectedSpeciesId.value]!
                        .value ==
                    breedModel.id
                ? controller
                        .selectedBreedMap[controller.selectedSpeciesId.value]!
                        .value =
                    controller
                        .selectedBreedMap[controller.selectedSpeciesId.value]!
                        .value
                : controller
                    .selectedBreedMap[controller.selectedSpeciesId.value]!
                    .value = breedModel.id;
          },
          child: Container(
            height: 30,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: controller
                          .selectedBreedMap[controller.selectedSpeciesId.value]!
                          .value ==
                      breedModel.id
                  ? PRIMARY_COLOR
                  : WHITE_COLOR,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: controller
                              .selectedBreedMap[
                                  controller.selectedSpeciesId.value]!
                              .value ==
                          breedModel.id
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
                color: controller
                            .selectedBreedMap[
                                controller.selectedSpeciesId.value]!
                            .value ==
                        breedModel.id
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

  Widget bloodGroupItemWidget({required String dogBloodGroup}) => Obx(
        () => InkWell(
          onTap: () {
            controller.selectedDogBloodGroup.value == dogBloodGroup
                ? controller.selectedDogBloodGroup.value =
                    controller.selectedDogBloodGroup.value
                : controller.selectedDogBloodGroup.value = dogBloodGroup;
          },
          child: Container(
            height: 30,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: controller.selectedDogBloodGroup.value == dogBloodGroup
                  ? PRIMARY_COLOR
                  : WHITE_COLOR,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: controller.selectedDogBloodGroup.value == dogBloodGroup
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
              dogBloodGroup,
              style: GoogleFonts.itim(
                color: controller.selectedDogBloodGroup.value == dogBloodGroup
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

  Widget specieItemWidget({required SpeciesModel speciesModel}) => Obx(
        () => Container(
          width: 55 + speciesModel.name.length * 10,
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () => controller.selectedSpeciesId.value == speciesModel.id
                ? null
                : controller.selectedSpeciesId.value = speciesModel.id,
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: speciesModel.id == controller.selectedSpeciesId.value
                    ? PRIMARY_COLOR
                    : PRIMARY_COLOR.withOpacity(0.13),
                borderRadius: BorderRadius.circular(15),
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
                  )
                ],
              ),
            ),
          ),
        ),
      );

  Widget nameTextFieldWidget() => Obx(
        () => Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: TextFormField(
            cursorColor: PRIMARY_COLOR,
            initialValue: controller.petName.value,
            maxLength: 40,
            decoration:
                controller.petName.value.isEmpty && !controller.isFirstInputName
                    ? const InputDecoration(
                        labelText: 'Name*',
                        errorText: 'The field name is required',
                        suffixIcon: Icon(
                          Icons.error,
                          color: Color.fromARGB(255, 241, 99, 88),
                          size: 20,
                        ),
                      )
                    : const InputDecoration(
                        labelText: 'Name*',
                      ),
            onChanged: (String? value) {
              controller.petName.value = value!;
              controller.isFirstInputName = false;
            },
          ),
        ),
      );

  Widget descriptionTextFieldWidget() => Obx(
        () => Container(
          height: 110,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: TextFormField(
            cursorColor: PRIMARY_COLOR,
            initialValue: controller.description.value,
            maxLength: 200,
            maxLines: 2,
            minLines: 2,
            decoration: controller.description.value.isEmpty &&
                    !controller.isFirstInputDescription
                ? const InputDecoration(
                    labelText: 'Description',
                    errorText: 'The field description is required',
                    suffixIcon: Icon(
                      Icons.error,
                      color: Color.fromARGB(255, 241, 99, 88),
                      size: 20,
                    ),
                  )
                : const InputDecoration(
                    labelText: 'Description*',
                  ),
            onChanged: (String? value) {
              controller.description.value = value!;
              controller.isFirstInputDescription = false;
            },
          ),
        ),
      );

  Widget listSpeciesItemWidget() => Query(
        options: QueryOptions(document: gql(FETCH_ALL_SPECIES), variables: {}),
        builder: (
          QueryResult result, {
          VoidCallback? refetch,
          FetchMore? fetchMore,
        }) {
          if (result.hasException) {
            return Text(result.exception.toString());
          } else if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (result.data != null) {
            controller.species = SpeciesService.getSpeciesList(result.data!);
          }
          return Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
            ),
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
        },
      );

  Widget listBreedItemWidget() => Obx(
        () => Query(
          options: QueryOptions(
              document: gql(FETCH_BREED_BY_SPECIES_ID),
              variables: {
                "species_id": controller.selectedSpeciesId.value,
              }),
          builder: (
            QueryResult result, {
            VoidCallback? refetch,
            FetchMore? fetchMore,
          }) {
            if (result.hasException) {
              return Text(result.exception.toString());
            } else if (result.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (result.data != null) {
              controller.breedsMap[controller.selectedSpeciesId.value] =
                  BreedService.getBreedList(result.data!).obs;

              if (controller
                      .selectedBreedMap[controller.selectedSpeciesId.value] ==
                  null) {
                controller
                        .selectedBreedMap[controller.selectedSpeciesId.value] =
                    (-1).obs;
              }
            }

            return Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Wrap(
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                crossAxisAlignment: WrapCrossAlignment.start,
                runAlignment: WrapAlignment.start,
                verticalDirection: VerticalDirection.down,
                spacing: 10,
                runSpacing: 10,
                children: controller
                    .breedsMap[controller.selectedSpeciesId.value]!
                    .asMap()
                    .entries
                    .map((e) => breedItemWidget(breedModel: e.value))
                    .toList(),
              ),
            );
          },
        ),
      );

  Widget avatarWidget() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Obx(
              () => controller.avatarUrl.value.isNotEmpty
                  ? imageItemWidget(avatar: controller.avatar!)
                  : Container(
                      height: 180,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'No image is selected',
                            style: GoogleFonts.itim(
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              color: Colors.black38,
                            ),
                          ),
                          SvgPicture.asset(
                            ICON_PATH + NO_IMAGE_SVG,
                            color: Colors.black38,
                            height: 30,
                          ),
                        ],
                      ),
                    ),
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 10,
                right: 40,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      controller.pickImageFromGallery();
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
                    onTap: () => controller.pickImageFromCamera(),
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

  Widget genderWidget() => Padding(
        padding: const EdgeInsets.only(
          left: 40,
        ),
        child: Obx(
          () => InkWell(
            onTap: () => controller.selectedGender.value == 'MALE'
                ? controller.selectedGender.value = 'FEMALE'
                : controller.selectedGender.value = 'MALE',
            child: Row(
              children: [
                Container(
                  height: 30,
                  width: 70,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: controller.selectedGender.value == 'MALE'
                        ? const Color.fromARGB(255, 99, 194, 238)
                        : DARK_GREY_COLOR.withOpacity(0.1),
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(15),
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
                        style: GoogleFonts.itim(
                          color: controller.selectedGender.value == 'MALE'
                              ? WHITE_COLOR
                              : DARK_GREY_COLOR.withOpacity(0.3),
                          fontSize: 15,
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
                  width: 70,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: controller.selectedGender.value == 'FEMALE'
                        ? const Color.fromARGB(255, 240, 128, 171)
                        : DARK_GREY_COLOR.withOpacity(0.1),
                    borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(15)),
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
                        style: GoogleFonts.itim(
                          color: controller.selectedGender.value == 'FEMALE'
                              ? WHITE_COLOR
                              : DARK_GREY_COLOR.withOpacity(0.3),
                          fontSize: 15,
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

  Widget fertilityWidget() => Padding(
        padding: const EdgeInsets.only(
          left: 20,
        ),
        child: Obx(
          () => InkWell(
            onTap: () => controller.selectedFertility.value == 'Yes'
                ? controller.selectedFertility.value = 'No'
                : controller.selectedFertility.value = 'Yes',
            child: Row(
              children: [
                Container(
                  height: 30,
                  width: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: controller.selectedFertility.value == 'Yes'
                        ? PRIMARY_COLOR
                        : DARK_GREY_COLOR.withOpacity(0.1),
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(15),
                    ),
                    border: Border.all(
                      color: controller.selectedFertility.value == 'Yes'
                          ? PRIMARY_COLOR
                          : DARK_GREY_COLOR.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'Yes',
                    style: GoogleFonts.itim(
                      color: controller.selectedFertility.value == 'Yes'
                          ? WHITE_COLOR
                          : DARK_GREY_COLOR.withOpacity(0.3),
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  width: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: controller.selectedFertility.value == 'No'
                        ? PRIMARY_COLOR
                        : DARK_GREY_COLOR.withOpacity(0.1),
                    borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(15)),
                    border: Border.all(
                      color: controller.selectedFertility.value == 'No'
                          ? PRIMARY_COLOR
                          : DARK_GREY_COLOR.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'No',
                    style: GoogleFonts.itim(
                      color: controller.selectedFertility.value == 'No'
                          ? WHITE_COLOR
                          : DARK_GREY_COLOR.withOpacity(0.3),
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget listBloodGroup() => Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
        ),
        child: Wrap(
          alignment: WrapAlignment.start,
          direction: Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.start,
          runAlignment: WrapAlignment.start,
          verticalDirection: VerticalDirection.down,
          spacing: 10,
          runSpacing: 10,
          children: controller.dogBloodGroup
              .asMap()
              .entries
              .map((e) => bloodGroupItemWidget(dogBloodGroup: e.value))
              .toList(),
        ),
      );

  Widget dateOfBirthTextFieldWidget() => SizedBox(
        width: 180,
        height: 45,
        child: TextFormField(
          initialValue: controller.dOBText.value,
          onChanged: (value) {
            try {
              controller.dOB = DateFormat(DATE_PATTERN_2).parse(value);
              controller.ageRange = controller.ageRange =
                  (DateTime.now().difference(controller.dOB!).inDays ~/ 30)
                      .toString();
            } on FormatException catch (_) {
              controller.ageRange = '';
            } finally {
              controller.dOBText.value = value;
            }
          },
          decoration: InputDecoration(
            labelText: 'dd/MM/yyyy',
            //errorText: 'Error message',
            border: const OutlineInputBorder(),
            suffixIcon: InkWell(
              onTap: () => controller.isDisplayCalender.value = true,
              child: const Icon(
                Icons.calendar_month_rounded,
                color: PRIMARY_COLOR,
              ),
            ),
          ),
        ),
      );

  Widget ageRangeTextFieldWidget() => Expanded(
        child: SizedBox(
          height: 45,
          child: GetBuilder<AddPetPageController>(
            init: AddPetPageController(),
            builder: (controller) => TextFormField(
              initialValue: controller.ageRange,
              onChanged: (value) {
                if (int.tryParse(value) != null) {
                  controller.dOB = DateTime.now().add(
                    Duration(
                      days: -int.parse(value) * 30,
                    ),
                  );
                  controller.dOBText.value = FORMAT_DATE_TIME(
                    dateTime: controller.dOB!,
                    pattern: DATE_PATTERN_2,
                  );
                }
                controller.ageRange = value;
              },
              decoration: const InputDecoration(
                labelText: 'month',
                //errorText: 'Error message',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      );

  Widget addPetButtonWidget() => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 10,
        ),
        child: MaterialButton(
          color: PRIMARY_COLOR,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Add Pet to Pet Management',
                style: GoogleFonts.quicksand(
                  color: WHITE_COLOR,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              SvgPicture.asset(
                ICON_PATH + ADD_SVG,
                color: WHITE_COLOR,
                height: 19,
              ),
            ],
          ),
          onPressed: () {
            PetService.INSERT_PET(
              accountId: 1,
              filePath: controller.avatarUrl.value,
              ageRange: int.parse(controller.ageRange),
              description: controller.description.value,
              dob: controller.dOB!,
              gender: controller.selectedGender.value,
              isSeed: controller.selectedFertility.value == 'Yes',
              name: controller.petName.value,
              categoryId: controller
                  .selectedBreedMap[controller.selectedSpeciesId.value]!.value,
            );
            Get.offAllNamed(PET_MANAGEMENT_PAGE_ROUNTER);
          },
        ),
      );

  Widget calendarWidget() => InkWell(
        onTap: () {
          controller.isDisplayCalender.value = false;
          controller.tmpDOB = controller.dOB;
        },
        child: Container(
          color: DARK_GREY_COLOR.withOpacity(0.15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 250,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: SfDateRangePicker(
                  onSelectionChanged: (DateRangePickerSelectionChangedArgs
                      dateRangePickerSelectionChangedArgs) {
                    controller.tmpDOB = DateTime.parse(
                        dateRangePickerSelectionChangedArgs.value.toString());
                  },
                  selectionMode: DateRangePickerSelectionMode.single,
                  backgroundColor: WHITE_COLOR,
                  initialSelectedDate: controller.dOB,
                  initialDisplayDate: controller.dOB,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  color: WHITE_COLOR,
                  margin: const EdgeInsets.only(
                    left: 40,
                    right: 40,
                  ),
                  padding: const EdgeInsets.only(
                    bottom: 10,
                    right: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          controller.isDisplayCalender.value = false;
                          controller.tmpDOB = controller.dOB;
                        },
                        color: PRIMARY_LIGHT_COLOR,
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.itim(
                            color: PRIMARY_COLOR,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      MaterialButton(
                        onPressed: () {
                          controller.dOB = controller.tmpDOB;
                          controller.dOBText.value = FORMAT_DATE_TIME(
                            dateTime: controller.dOB!,
                            pattern: DATE_PATTERN_2,
                          );
                          controller.ageRange = controller.ageRange =
                              (DateTime.now()
                                          .difference(controller.dOB!)
                                          .inDays ~/
                                      30)
                                  .toString();
                          controller.isDisplayCalender.value = false;
                          controller.update();
                        },
                        color: PRIMARY_COLOR,
                        child: Text(
                          'OK',
                          style: GoogleFonts.itim(
                            color: WHITE_COLOR,
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );

  // loadModel() async {
  //   await Tflite.loadModel(
  //     model: 'assets/model_unquant.tflite',
  //     labels: 'assets/labels.txt',
  //   );
  // }
}
