import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/add_pet_page_controller.dart';
import 'package:petapp_mobile/graphql/query_mutation/breed.dart';
import 'package:petapp_mobile/graphql/query_mutation/species.dart';
import 'package:petapp_mobile/models/breed_model/breed_model.dart';
import 'package:petapp_mobile/models/species_model/species_model.dart';
import 'package:petapp_mobile/services/breed_servies.dart';
import 'package:petapp_mobile/services/species_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';

class CreatePetBodyWidget extends GetView<CreatePetPageController> {
  const CreatePetBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            petNameWidget(),
            petSpicesWidget(),
            petBreedWidget(),
            petAvatarWidget(),
            genderAndFertilityWidget(),
            dateOfBirthWidget(),
            descriptionWidget(),
          ],
        ),
      ),
    );
  }

  Widget dateOfBirthWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: SvgPicture.asset(
                          ICON_PATH + CLOCK_SVG,
                          height: 17,
                          color: const Color.fromARGB(255, 61, 78, 100),
                        ),
                      ),
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
            ),
            InkWell(
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
                                  color:
                                      const Color.fromARGB(255, 162, 176, 194),
                                  fontSize: 13,
                                  letterSpacing: 2,
                                ),
                              )
                            : Text(
                                controller.dayOfBirthText.value,
                                style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      const Color.fromARGB(255, 113, 135, 168),
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
  Widget petSpicesWidget() {
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
          SizedBox(
            height: 180,
            width: 250,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(7),
              ),
              child: Image.file(
                avatar,
                width: 250,
                fit: BoxFit.cover,
              ),
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
                  : Container(
                      height: 180,
                      width: 250,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 237, 240, 243),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
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
                              color: const Color.fromARGB(255, 127, 136, 148),
                            ),
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

            return Padding(
              padding: const EdgeInsets.only(top: 5),
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

  Widget listSpeciesItemWidget() => Query(
        options:
            QueryOptions(document: gql(FETCH_ALL_SPECIES), variables: const {}),
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
        },
      );

  Widget specieItemWidget({required SpeciesModel speciesModel}) => Obx(
        () => Container(
          width: 60 + speciesModel.name.length * 10,
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () => controller.selectedSpeciesId.value == speciesModel.id
                ? null
                : controller.selectedSpeciesId.value = speciesModel.id,
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

  Widget petNameWidget() {
    TextEditingController _textEditingController = TextEditingController();
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
          Container(
            height: 45,
            alignment: Alignment.center,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    minLines: 1,
                    maxLines: 1,
                    controller: _textEditingController,
                    onChanged: (String text) {
                      controller.petName.value = text;
                    },
                    keyboardType: TextInputType.multiline,
                    cursorColor: PRIMARY_COLOR,
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 113, 135, 168),
                      fontSize: 15,
                      letterSpacing: 1,
                    ),
                    decoration: InputDecoration.collapsed(
                      hintText: 'Type your pet name here...',
                      hintStyle: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 162, 176, 194),
                        fontSize: 13,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget descriptionWidget() {
    TextEditingController _textEditingController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
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
          Container(
            height: 80,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 8, bottom: 30),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 167, 181, 201),
                width: 1.2,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    minLines: 3,
                    maxLines: 3,
                    controller: _textEditingController,
                    onChanged: (String text) {
                      controller.description.value = text;
                    },
                    keyboardType: TextInputType.multiline,
                    cursorColor: PRIMARY_COLOR,
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 113, 135, 168),
                      fontSize: 15,
                      letterSpacing: 1,
                    ),
                    decoration: InputDecoration.collapsed(
                      hintText: 'More information about your pet...',
                      hintStyle: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 162, 176, 194),
                        fontSize: 13,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
