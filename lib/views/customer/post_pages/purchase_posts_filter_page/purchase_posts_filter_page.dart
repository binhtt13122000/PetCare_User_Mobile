import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/purchase_posts_page_controller.dart';
import 'package:petapp_mobile/graphql/graphql_config.dart';
import 'package:petapp_mobile/models/breed_model/breed_model.dart';
import 'package:petapp_mobile/services/pet_services/breed_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PurchasePostsFilterPage extends GetView<PurchasePostsPageController> {
  const PurchasePostsFilterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GRAPHQL_CLIENT,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
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
                    //!title
                    Text(
                      'Purchase posts filter',
                      style: GoogleFonts.satisfy(
                        textStyle: const TextStyle(color: PRIMARY_COLOR),
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //!Species
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(
                          left: 10,
                          top: 20,
                          bottom: 5,
                        ),
                        child: Text(
                          'Species',
                          style: GoogleFonts.itim(fontSize: 25),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        child: Obx(
                          () => Wrap(
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
                                .map(
                                  (e) => Container(
                                    width: 55 + e.value.name.length * 10,
                                    alignment: Alignment.centerLeft,
                                    child: InkWell(
                                      onTap: () {
                                        if (controller
                                                .selectedSpeciesId.value !=
                                            e.value.id) {
                                          controller.isShowLoadingBreeds.value =
                                              true;
                                          controller.selectedSpeciesId.value =
                                              e.value.id;
                                          controller.postHasuraList.clear();
                                          controller.refreshController
                                              .requestRefresh();
                                          controller.refreshController
                                              .resetNoData();
                                          controller.isRefresh.value = true;
                                          controller.offset.value = 0;
                                          controller.update();
                                        }
                                      },
                                      child: Container(
                                        height: 40,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: controller.selectedSpeciesId
                                                      .value ==
                                                  e.value.id
                                              ? PRIMARY_COLOR
                                              : PRIMARY_COLOR.withOpacity(0.13),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                              color: controller
                                                          .selectedSpeciesId
                                                          .value ==
                                                      e.value.id
                                                  ? PRIMARY_COLOR
                                                      .withOpacity(0.7)
                                                  : WHITE_COLOR,
                                              offset: const Offset(1, 1),
                                              blurRadius: 8,
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              e.value.imageUrl!,
                                              height: 25,
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              e.value.name,
                                              style: GoogleFonts.itim(
                                                color: e.value.id ==
                                                        controller
                                                            .selectedSpeciesId
                                                            .value
                                                    ? WHITE_COLOR
                                                    : PRIMARY_COLOR
                                                        .withOpacity(0.7),
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
                                )
                                .toList(),
                          ),
                        ),
                      ),
                      //!Breeds
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(
                          left: 10,
                          top: 20,
                          bottom: 5,
                        ),
                        child: Text(
                          'Breeds',
                          style: GoogleFonts.itim(fontSize: 25),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 20,
                        ),
                        child: GetBuilder<PurchasePostsPageController>(
                          builder: (_) {
                            controller.isShowLoadingBreeds.value = true;
                            WidgetsBinding.instance!
                                .addPostFrameCallback((_) async {
                              controller.breedsMap[
                                      controller.selectedSpeciesId.value] =
                                  await BreedService.fetchBreedListBySpeciesId(
                                      speciesId:
                                          controller.selectedSpeciesId.value);
                              controller.isShowLoadingBreeds.value = false;
                            });
                            return Obx(
                              () => controller.isShowLoadingBreeds.value
                                  ? const Center(
                                      child: SpinKitSpinningLines(
                                        color: PRIMARY_COLOR,
                                        size: 150,
                                      ),
                                    )
                                  : Container(
                                      alignment: Alignment.topLeft,
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                      ),
                                      child: Wrap(
                                        alignment: WrapAlignment.start,
                                        direction: Axis.horizontal,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        runAlignment: WrapAlignment.start,
                                        verticalDirection:
                                            VerticalDirection.down,
                                        spacing: 10,
                                        runSpacing: 10,
                                        children: controller
                                                .breedsMap.isNotEmpty
                                            ? controller.breedsMap[controller
                                                        .selectedSpeciesId
                                                        .value] ==
                                                    null
                                                ? <Widget>[Container()]
                                                : controller.breedsMap[
                                                        controller
                                                            .selectedSpeciesId
                                                            .value]!
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
                      //!Gender
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(
                          left: 10,
                          top: 20,
                          bottom: 5,
                        ),
                        child: Text(
                          'Gender',
                          style: GoogleFonts.itim(fontSize: 25),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Row(
                          children: [
                            GetBuilder<PurchasePostsPageController>(
                              builder: (controller) => InkWell(
                                onTap: () {
                                  if (controller.selectedGenderList
                                          .contains('MALE') &&
                                      controller.selectedGenderList
                                          .contains('FEMALE')) {
                                    controller.selectedGenderList = ['MALE'];
                                  } else if (controller.selectedGenderList
                                      .contains('MALE')) {
                                    controller.selectedGenderList = ['FEMALE'];
                                  } else {
                                    controller.selectedGenderList = [
                                      'MALE',
                                      'FEMALE'
                                    ];
                                  }
                                  controller.refreshController.requestRefresh();
                                  controller.refreshController.resetNoData();
                                  controller.isRefresh.value = true;
                                  controller.offset.value = 0;
                                  controller.update();
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 45,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: controller.selectedGenderList
                                                .contains('MALE')
                                            ? const Color.fromARGB(
                                                255, 99, 194, 238)
                                            : DARK_GREY_COLOR.withOpacity(0.1),
                                        borderRadius:
                                            const BorderRadius.horizontal(
                                          left: Radius.circular(15),
                                        ),
                                        border: Border.all(
                                          color: controller.selectedGenderList
                                                  .contains('MALE')
                                              ? const Color.fromARGB(
                                                  255, 99, 194, 238)
                                              : DARK_GREY_COLOR
                                                  .withOpacity(0.2),
                                          width: 1,
                                        ),
                                      ),
                                      child: SvgPicture.asset(
                                        ICON_PATH + MALE_SVG,
                                        height: 17,
                                        color: controller.selectedGenderList
                                                .contains('MALE')
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
                                            ? const Color.fromARGB(
                                                255, 240, 128, 171)
                                            : DARK_GREY_COLOR.withOpacity(0.1),
                                        borderRadius:
                                            const BorderRadius.horizontal(
                                                right: Radius.circular(15)),
                                        border: Border.all(
                                          color: controller.selectedGenderList
                                                  .contains('FEMALE')
                                              ? const Color.fromARGB(
                                                  255, 240, 128, 171)
                                              : DARK_GREY_COLOR
                                                  .withOpacity(0.2),
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
                      //!Price
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(
                          left: 10,
                          top: 20,
                          bottom: 5,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Price',
                              style: GoogleFonts.itim(fontSize: 25),
                            ),
                            Text(
                              '(vn₫)',
                              style: GoogleFonts.itim(
                                fontSize: 20,
                                color: DARK_GREY_COLOR.withOpacity(
                                  0.7,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
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
                          children: controller.prices
                              .asMap()
                              .entries
                              .map(
                                (e) => Obx(
                                  () => InkWell(
                                    onTap: () {
                                      if (controller.selectedPrices.value ==
                                          e.value) {
                                        controller.selectedPrices.value = '';
                                        controller.ltPrice.value = 999999999;
                                        controller.gtePrice.value = 0;
                                      } else {
                                        controller.selectedPrices.value =
                                            e.value;
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
                                            controller.gtePrice.value =
                                                13000000;
                                            break;
                                          case '> 20 million':
                                            controller.ltPrice.value =
                                                999999999;
                                            controller.gtePrice.value =
                                                20000000;
                                            break;
                                          default:
                                        }
                                      }
                                      controller.refreshController
                                          .requestRefresh();
                                      controller.refreshController
                                          .resetNoData();
                                      controller.isRefresh.value = true;
                                      controller.offset.value = 0;
                                      controller.update();
                                    },
                                    child: Container(
                                      height: 30,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: e.value ==
                                                controller.selectedPrices.value
                                            ? PRIMARY_COLOR
                                            : WHITE_COLOR,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            color: e.value ==
                                                    controller
                                                        .selectedPrices.value
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
                                          color: e.value ==
                                                  controller
                                                      .selectedPrices.value
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
                      //!Age
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(
                          left: 10,
                          top: 20,
                          bottom: 5,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Age',
                              style: GoogleFonts.itim(fontSize: 25),
                            ),
                            Text(
                              '(month)',
                              style: GoogleFonts.itim(
                                fontSize: 20,
                                color: DARK_GREY_COLOR.withOpacity(
                                  0.7,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
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
                          children: controller.ages
                              .asMap()
                              .entries
                              .map(
                                (e) => Obx(
                                  () => InkWell(
                                    onTap: () {
                                      if (controller.selectedAge.value ==
                                          e.value) {
                                        controller.selectedAge.value = '';
                                        controller.lteDob.value = 'now()';
                                        controller.gteDob.value = '1700-01-01';
                                      } else {
                                        controller.selectedAge.value = e.value;
                                        switch (e.value) {
                                          case '< 6 month':
                                            var dateBeforeSixMonth =
                                                CALCULATE_DATE_BEFORE_DATE_NOW(
                                                    days: 0,
                                                    months: 6,
                                                    years: 0);

                                            controller.lteDob.value = 'now()';
                                            controller.gteDob.value =
                                                dateBeforeSixMonth
                                                    .toIso8601String();
                                            break;
                                          case '6 month → 12 month':
                                            var dateBeforeSixMonth =
                                                CALCULATE_DATE_BEFORE_DATE_NOW(
                                                    days: 0,
                                                    months: 6,
                                                    years: 0);
                                            var dateBeforeTwelfthMonth =
                                                CALCULATE_DATE_BEFORE_DATE_NOW(
                                                    days: 0,
                                                    months: 12,
                                                    years: 0);
                                            controller.lteDob.value =
                                                dateBeforeSixMonth
                                                    .toIso8601String();
                                            controller.gteDob.value =
                                                dateBeforeTwelfthMonth
                                                    .toIso8601String();
                                            break;
                                          case '1 year → 2 year':
                                            var dateBeforeOneYear =
                                                CALCULATE_DATE_BEFORE_DATE_NOW(
                                                    days: 0,
                                                    months: 0,
                                                    years: 1);
                                            var dateBeforeTwoYears =
                                                CALCULATE_DATE_BEFORE_DATE_NOW(
                                                    days: 0,
                                                    months: 0,
                                                    years: 2);
                                            controller.lteDob.value =
                                                dateBeforeOneYear
                                                    .toIso8601String();
                                            controller.gteDob.value =
                                                dateBeforeTwoYears
                                                    .toIso8601String();
                                            break;
                                          case '2 year → 4 year':
                                            var dateBeforeTwoYears =
                                                CALCULATE_DATE_BEFORE_DATE_NOW(
                                                    days: 0,
                                                    months: 0,
                                                    years: 2);
                                            var dateBeforeFourYears =
                                                CALCULATE_DATE_BEFORE_DATE_NOW(
                                                    days: 0,
                                                    months: 0,
                                                    years: 4);
                                            controller.lteDob.value =
                                                dateBeforeTwoYears
                                                    .toIso8601String();
                                            controller.gteDob.value =
                                                dateBeforeFourYears
                                                    .toIso8601String();
                                            break;
                                          case '> 4 year':
                                            var dateBeforeFourYears =
                                                CALCULATE_DATE_BEFORE_DATE_NOW(
                                                    days: 0,
                                                    months: 0,
                                                    years: 4);
                                            controller.lteDob.value =
                                                dateBeforeFourYears
                                                    .toIso8601String();
                                            controller.gteDob.value =
                                                '1700-01-01';
                                            break;
                                          default:
                                        }
                                      }
                                      controller.refreshController
                                          .requestRefresh();
                                      controller.refreshController
                                          .resetNoData();
                                      controller.isRefresh.value = true;
                                      controller.offset.value = 0;
                                      controller.update();
                                    },
                                    child: Container(
                                      height: 30,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: e.value ==
                                                controller.selectedAge.value
                                            ? PRIMARY_COLOR
                                            : WHITE_COLOR,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            color: e.value ==
                                                    controller.selectedAge.value
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
                                          color: e.value ==
                                                  controller.selectedAge.value
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
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget breedItemWidget({required BreedModel breedModel}) =>
      GetBuilder<PurchasePostsPageController>(
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
            controller.refreshController.requestRefresh();
            controller.refreshController.resetNoData();
            controller.isRefresh.value = true;
            controller.offset.value = 0;
            controller.update();
            controller.selectedBreedMap.refresh();
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
}
