import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/enum_config.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/post_list_page_controller.dart';
import 'package:petapp_mobile/models/breed_model/breed_model.dart';
import 'package:petapp_mobile/models/species_model/species_model.dart';
import 'package:petapp_mobile/services/pet_services/breed_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PostFilterBodyWidget extends GetView<PostListPageController> {
  const PostFilterBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                genderWidget(),
                postTypeWidget(),
              ],
            ),
            speciesWidget(),
            breedWidget(),
            Container(
              height: 1,
              margin: const EdgeInsets.only(top: 10),
              color: LIGHT_GREY_COLOR.withAlpha(30),
            ),
            Container(
              height: 16,
              color: SUPPER_LIGHT_BLUE,
            ),
            priceWidget(),
            ageWidget(),
          ],
        ),
      ),
    );
  }

  Widget postTypeWidget() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CUSTOM_TEXT('Type', padding: const EdgeInsets.only(right: 5)),
          selectPostTypeWidget(),
        ],
      );

  Widget selectPostTypeWidget() => Obx(() {
        return InkWell(
          onTap: () {
            if (controller.selectedPostType.contains('SALE') &&
                controller.selectedPostType.contains('BREED')) {
              controller.selectedPostType.remove('BREED');
            } else if (controller.selectedPostType.contains('SALE')) {
              controller.selectedPostType
                ..remove('SALE')
                ..add('BREED');
            } else {
              controller.selectedPostType.add('SALE');
            }
            controller
              ..loadingType = LoadingType.INIT.name
              ..offset = 0
              ..update();
          },
          child: Row(
            children: [
              Container(
                height: 30,
                width: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: controller.selectedPostType.contains('SALE')
                      ? const Color.fromARGB(255, 99, 194, 238)
                      : const Color.fromARGB(255, 237, 240, 243),
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(7),
                  ),
                  border: Border.all(
                    color: controller.selectedPostType.contains('SALE')
                        ? const Color.fromARGB(255, 99, 194, 238)
                        : DARK_GREY_COLOR.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'SALE',
                      style: GoogleFonts.quicksand(
                        color: controller.selectedPostType.contains('SALE')
                            ? WHITE_COLOR
                            : DARK_GREY_COLOR.withOpacity(0.3),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 30,
                width: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: controller.selectedPostType.contains('BREED')
                      ? const Color.fromARGB(255, 240, 128, 171)
                      : const Color.fromARGB(255, 237, 240, 243),
                  borderRadius:
                      const BorderRadius.horizontal(right: Radius.circular(7)),
                  border: Border.all(
                    color: controller.selectedPostType.contains('BREED')
                        ? const Color.fromARGB(255, 240, 128, 171)
                        : DARK_GREY_COLOR.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'BREED',
                      style: GoogleFonts.quicksand(
                        color: controller.selectedPostType.contains('BREED')
                            ? WHITE_COLOR
                            : DARK_GREY_COLOR.withOpacity(0.3),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      });

  Widget breedWidget() {
    return Obx(
      () => Visibility(
        visible: controller.selectedSpeciesId.value != -1,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CUSTOM_TEXT(
                'Breeds',
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 12,
                  top: 10,
                ),
                child: GetBuilder<PostListPageController>(
                  builder: (_) {
                    if (controller.isRefreshBreed) {
                      controller.isShowLoadingBreeds.value = true;
                      WidgetsBinding.instance!.addPostFrameCallback((_) async {
                        controller
                          ..breedsMap[controller.selectedSpeciesId.value] =
                              await BreedService.fetchBreedListBySpeciesId(
                                  jwt: controller.accountModel.jwtToken,
                                  speciesId: controller.selectedSpeciesId.value)
                          ..isShowLoadingBreeds.value = false
                          ..isRefreshBreed = false;
                      });
                    }

                    return Obx(
                      () => controller.isShowLoadingBreeds.value
                          ? LOADING_WIDGET(size: 60)
                          : Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.only(
                                left: 20,
                              ),
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                direction: Axis.horizontal,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                runAlignment: WrapAlignment.start,
                                verticalDirection: VerticalDirection.down,
                                spacing: 10,
                                runSpacing: 10,
                                children: controller.breedsMap.isNotEmpty
                                    ? controller.breedsMap[controller
                                                .selectedSpeciesId.value] ==
                                            null
                                        ? <Widget>[Container()]
                                        : controller.breedsMap[controller
                                                .selectedSpeciesId.value]!
                                            .asMap()
                                            .entries
                                            .map((e) => breedItemWidget(
                                                breedModel: e.value))
                                            .toList()
                                    : <Widget>[Container()],
                              ),
                            ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ageWidget() => Padding(
        padding: const EdgeInsets.only(left: 12, top: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CUSTOM_TEXT(
            'Age range',
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(
              left: 12,
              top: 10,
            ),
            child: Wrap(
              alignment: WrapAlignment.start,
              direction: Axis.horizontal,
              crossAxisAlignment: WrapCrossAlignment.start,
              runAlignment: WrapAlignment.start,
              verticalDirection: VerticalDirection.down,
              spacing: 10,
              runSpacing: 10,
              children: controller.ages
                  .asMap()
                  .entries
                  .map(
                    (e) => Obx(
                      () => InkWell(
                        onTap: () {
                          if (controller.selectedAge.value == e.value) {
                            controller.selectedAge.value = '';
                            controller.lteDob.value = 'now()';
                            controller.gteDob.value = '1700-01-01';
                          } else {
                            controller.selectedAge.value = e.value;
                            switch (e.value) {
                              case '< 6 month':
                                var dateBeforeSixMonth =
                                    CALCULATE_DATE_BEFORE_DATE_NOW(
                                        days: 0, months: 6, years: 0);

                                controller.lteDob.value = 'now()';
                                controller.gteDob.value =
                                    dateBeforeSixMonth.toIso8601String();
                                break;
                              case '6 month → 12 month':
                                var dateBeforeSixMonth =
                                    CALCULATE_DATE_BEFORE_DATE_NOW(
                                        days: 0, months: 6, years: 0);
                                var dateBeforeTwelfthMonth =
                                    CALCULATE_DATE_BEFORE_DATE_NOW(
                                        days: 0, months: 12, years: 0);
                                controller.lteDob.value =
                                    dateBeforeSixMonth.toIso8601String();
                                controller.gteDob.value =
                                    dateBeforeTwelfthMonth.toIso8601String();
                                break;
                              case '1 year → 2 year':
                                var dateBeforeOneYear =
                                    CALCULATE_DATE_BEFORE_DATE_NOW(
                                        days: 0, months: 0, years: 1);
                                var dateBeforeTwoYears =
                                    CALCULATE_DATE_BEFORE_DATE_NOW(
                                        days: 0, months: 0, years: 2);
                                controller.lteDob.value =
                                    dateBeforeOneYear.toIso8601String();
                                controller.gteDob.value =
                                    dateBeforeTwoYears.toIso8601String();
                                break;
                              case '2 year → 4 year':
                                var dateBeforeTwoYears =
                                    CALCULATE_DATE_BEFORE_DATE_NOW(
                                        days: 0, months: 0, years: 2);
                                var dateBeforeFourYears =
                                    CALCULATE_DATE_BEFORE_DATE_NOW(
                                        days: 0, months: 0, years: 4);
                                controller.lteDob.value =
                                    dateBeforeTwoYears.toIso8601String();
                                controller.gteDob.value =
                                    dateBeforeFourYears.toIso8601String();
                                break;
                              case '> 4 year':
                                var dateBeforeFourYears =
                                    CALCULATE_DATE_BEFORE_DATE_NOW(
                                        days: 0, months: 0, years: 4);
                                controller.lteDob.value =
                                    dateBeforeFourYears.toIso8601String();
                                controller.gteDob.value = '1700-01-01';
                                break;
                              default:
                            }
                          }

                          controller
                            ..loadingType = LoadingType.INIT.name
                            ..offset = 0
                            ..update();
                        },
                        child: Container(
                          height: 30,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: e.value == controller.selectedAge.value
                                ? PRIMARY_COLOR
                                : WHITE_COLOR,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: e.value == controller.selectedAge.value
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
                            e.value,
                            style: GoogleFonts.itim(
                              color: e.value == controller.selectedAge.value
                                  ? WHITE_COLOR
                                  : PRIMARY_COLOR.withOpacity(0.7),
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ]),
      );
  Widget breedItemWidget({required BreedModel breedModel}) =>
      GetBuilder<PostListPageController>(
        builder: (controller) => InkWell(
          onTap: () {
            if (controller
                    .selectedBreedMap[controller.selectedSpeciesId.value] !=
                null) {
              controller.selectedBreedMap[controller.selectedSpeciesId.value]!
                      .contains(breedModel.id)
                  ? controller
                      .selectedBreedMap[controller.selectedSpeciesId.value]!
                      .remove(breedModel.id)
                  : controller
                      .selectedBreedMap[controller.selectedSpeciesId.value]!
                      .add(breedModel.id);
            } else {
              controller.selectedBreedMap[controller.selectedSpeciesId.value] =
                  [breedModel.id].obs;
            }

            controller
              ..loadingType = LoadingType.INIT.name
              ..offset = 0
              ..update();
          },
          child: Container(
            height: 30,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: controller.selectedBreedMap[
                              controller.selectedSpeciesId.value] !=
                          null &&
                      controller
                          .selectedBreedMap[controller.selectedSpeciesId.value]!
                          .contains(breedModel.id)
                  ? PRIMARY_COLOR
                  : WHITE_COLOR,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: controller.selectedBreedMap[
                                  controller.selectedSpeciesId.value] !=
                              null &&
                          controller.selectedBreedMap[
                                  controller.selectedSpeciesId.value]!
                              .contains(breedModel.id)
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
                color: controller.selectedBreedMap[
                                controller.selectedSpeciesId.value] !=
                            null &&
                        controller.selectedBreedMap[
                                controller.selectedSpeciesId.value]!
                            .contains(breedModel.id)
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
  Widget priceWidget() => Padding(
        padding: const EdgeInsets.only(left: 12, top: 20),
        child: Column(
          children: [
            Row(
              children: [
                CUSTOM_TEXT(
                  'Price',
                ),
                CUSTOM_TEXT(
                  '(vn₫)',
                  fontSize: 14,
                  color: DARK_GREY_TEXT_COLOR.withOpacity(0.7),
                ),
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(
                left: 12,
                top: 10,
              ),
              child: Wrap(
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                crossAxisAlignment: WrapCrossAlignment.start,
                runAlignment: WrapAlignment.start,
                verticalDirection: VerticalDirection.down,
                spacing: 10,
                runSpacing: 10,
                children: controller.prices
                    .asMap()
                    .entries
                    .map(
                      (e) => Obx(
                        () => InkWell(
                          onTap: () {
                            if (controller.selectedPrices.value == e.value) {
                              controller.selectedPrices.value = '';
                              controller.ltPrice.value = 999999999;
                              controller.gtePrice.value = 0;
                            } else {
                              controller.selectedPrices.value = e.value;
                              switch (e.value) {
                                case '< 1 million':
                                  controller.ltPrice.value = 1000000;
                                  controller.gtePrice.value = 0;
                                  break;
                                case '1 million → 4 million':
                                  controller.ltPrice.value = 4000000;
                                  controller.gtePrice.value = 1000000;
                                  break;
                                case '4 million → 7 million':
                                  controller.ltPrice.value = 7000000;
                                  controller.gtePrice.value = 4000000;
                                  break;
                                case '7 million → 13 million':
                                  controller.ltPrice.value = 13000000;
                                  controller.gtePrice.value = 7000000;
                                  break;
                                case '13 million → 20 million':
                                  controller.ltPrice.value = 20000000;
                                  controller.gtePrice.value = 13000000;
                                  break;
                                case '> 20 million':
                                  controller.ltPrice.value = 999999999;
                                  controller.gtePrice.value = 20000000;
                                  break;
                                default:
                              }
                            }

                            controller
                              ..loadingType = LoadingType.INIT.name
                              ..offset = 0
                              ..update();
                          },
                          child: Container(
                            height: 30,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              color: e.value == controller.selectedPrices.value
                                  ? PRIMARY_COLOR
                                  : WHITE_COLOR,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      e.value == controller.selectedPrices.value
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
                              e.value,
                              style: GoogleFonts.itim(
                                color:
                                    e.value == controller.selectedPrices.value
                                        ? WHITE_COLOR
                                        : PRIMARY_COLOR.withOpacity(0.7),
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      );

  Widget genderWidget() => Padding(
        padding: const EdgeInsets.only(
          left: 12,
          top: 20,
        ),
        child: Row(
          children: [
            CUSTOM_TEXT(
              'Gender',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Row(
                children: [
                  GetBuilder<PostListPageController>(
                    builder: (controller) => InkWell(
                      onTap: () {
                        if (controller.selectedGenderList.contains('MALE') &&
                            controller.selectedGenderList.contains('FEMALE')) {
                          controller.selectedGenderList = ['MALE'];
                        } else if (controller.selectedGenderList
                            .contains('MALE')) {
                          controller.selectedGenderList = ['FEMALE'];
                        } else {
                          controller.selectedGenderList = ['MALE', 'FEMALE'];
                        }
                        controller
                          ..loadingType = LoadingType.INIT.name
                          ..offset = 0
                          ..update();
                      },
                      child: Row(
                        children: [
                          Container(
                            height: 30,
                            width: 45,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color:
                                  controller.selectedGenderList.contains('MALE')
                                      ? const Color.fromARGB(255, 99, 194, 238)
                                      : DARK_GREY_COLOR.withOpacity(0.1),
                              borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(15),
                              ),
                              border: Border.all(
                                color: controller.selectedGenderList
                                        .contains('MALE')
                                    ? const Color.fromARGB(255, 99, 194, 238)
                                    : DARK_GREY_COLOR.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: SvgPicture.asset(
                              ICON_PATH + MALE_SVG,
                              height: 17,
                              color:
                                  controller.selectedGenderList.contains('MALE')
                                      ? WHITE_COLOR
                                      : DARK_GREY_COLOR.withOpacity(0.3),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 45,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: controller.selectedGenderList
                                      .contains('FEMALE')
                                  ? const Color.fromARGB(255, 240, 128, 171)
                                  : DARK_GREY_COLOR.withOpacity(0.1),
                              borderRadius: const BorderRadius.horizontal(
                                  right: Radius.circular(15)),
                              border: Border.all(
                                color: controller.selectedGenderList
                                        .contains('FEMALE')
                                    ? const Color.fromARGB(255, 240, 128, 171)
                                    : DARK_GREY_COLOR.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: SvgPicture.asset(
                              ICON_PATH + FEMALE_SVG,
                              height: 17,
                              color: controller.selectedGenderList
                                      .contains('FEMALE')
                                  ? WHITE_COLOR
                                  : DARK_GREY_COLOR.withOpacity(0.3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
            onTap: () {
              controller
                ..selectedSpeciesId.value =
                    controller.selectedSpeciesId.value == speciesModel.id
                        ? -1
                        : speciesModel.id
                ..isRefreshBreed = true
                ..loadingType = LoadingType.INIT.name
                ..offset = 0
                ..update();
            },
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

  Widget speciesWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: CUSTOM_TEXT(
                'Pet species',
              ),
            ),
            listSpeciesItemWidget(),
          ],
        ),
      );
}
