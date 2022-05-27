import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/purchase_posts_page_controller.dart';
import 'package:petapp_mobile/graphql/query_mutation/species.dart';
import 'package:petapp_mobile/models/species_model/species_model.dart';
import 'package:petapp_mobile/services/species_services.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class TopWidget extends GetView<PurchasePostsPageController> {
  const TopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          titleWidget(),
          speciesWidget(),
          filterWidget(),
        ],
      );

  Widget titleWidget() => Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
            GRADIENT_WIDGET(
              child: Text(
                'Purchase posts',
                style: GoogleFonts.satisfy(
                  textStyle: const TextStyle(color: PRIMARY_COLOR),
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                  height: 1.2,
                ),
              ),
            ),
          ],
        ),
      );

  Widget speciesWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Query(
            options: QueryOptions(
                document: gql(FETCH_ALL_SPECIES), variables: const {}),
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
                controller.species =
                    SpeciesService.getSpeciesList(result.data!);
              }

              return Row(
                children: controller.species
                    .asMap()
                    .entries
                    .map(
                      (e) => speciesItemWidget(speciesModel: e.value),
                    )
                    .toList(),
              );
            },
          ),
        ),
      );

  Widget speciesItemWidget({required SpeciesModel speciesModel}) => Obx(
        () => Padding(
          padding: const EdgeInsets.only(right: 15, top: 5, bottom: 5),
          child: InkWell(
            onTap: () => controller.selectedSpeciesId.value == speciesModel.id
                ? controller.selectedSpeciesId.value = -1
                : controller.selectedSpeciesId.value = speciesModel.id,
            child: Container(
              height: 37,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              margin: EdgeInsets.only(
                right: controller.selectedSpeciesId.value == speciesModel.id
                    ? 3
                    : 0,
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
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                children: [
                  speciesModel.imageUrl != null
                      ? Image.asset(
                          speciesModel.imageUrl!,
                          height: 25,
                        )
                      : const SizedBox(),
                  SizedBox(
                    width: speciesModel.imageUrl != null ? 3 : 0,
                  ),
                  Text(
                    speciesModel.name,
                    style: GoogleFonts.itim(
                      color:
                          controller.selectedSpeciesId.value == speciesModel.id
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

  Widget filterWidget() => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //*Filter
            InkWell(
              onTap: () => Get.toNamed(
                PURCHASE_POSTS_FILTER_PAGE_ROUTE,
              ),
              child: Container(
                height: 30,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                ),
                decoration: BoxDecoration(
                  color: PRIMARY_LIGHT_COLOR,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: PRIMARY_COLOR, width: 1.5),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      ICON_PATH + FILTER_SVG,
                      height: 17,
                      color: PRIMARY_COLOR,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      'Filter',
                      style: GoogleFonts.itim(
                        color: PRIMARY_COLOR,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    )
                  ],
                ),
              ),
            ),
            //*Gender
            Row(
              children: [
                GetBuilder<PurchasePostsPageController>(
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
                      controller.update();
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
                              color:
                                  controller.selectedGenderList.contains('MALE')
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
                            color:
                                controller.selectedGenderList.contains('FEMALE')
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
                            color:
                                controller.selectedGenderList.contains('FEMALE')
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
            InkWell(
              onTap: () => Get.toNamed(
                PURCHASE_POSTS_FILTER_PAGE_ROUTE,
              ),
              child: Container(
                height: 30,
                padding: const EdgeInsets.only(left: 13, right: 3),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 227, 233, 241),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: const Color.fromARGB(255, 171, 175, 187),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      'Price: low → high',
                      style: GoogleFonts.itim(
                        color: const Color.fromARGB(255, 95, 105, 131),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      size: 25,
                      color: Color.fromARGB(255, 95, 105, 131),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
