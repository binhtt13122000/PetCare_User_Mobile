import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/enum_config.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/main_page_controllers/home_page_controller.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/post_list_page_controller.dart';
import 'package:petapp_mobile/models/species_model/species_model.dart';
import 'package:petapp_mobile/services/pet_services/species_services.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PostListTopWidget extends GetView<PostListPageController> {
  const PostListTopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.only(top: 30),
        decoration: const BoxDecoration(
          color: WHITE_COLOR,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 198, 206, 223),
              offset: Offset(1, 1),
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            topTitleWidget(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Expanded(
                    child: searchWidget(),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  filterWidget(),
                ],
              ),
            ),
            speciesWidget(),
          ],
        ),
      );

  Widget filterWidget() => InkWell(
        onTap: () => Get.toNamed(POSTS_FILTER_PAGE_ROUTE),
        child: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 156, 175, 202),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
              color: WHITE_COLOR),
          child: Center(
            child: SvgPicture.asset(
              ICON_PATH + FILTER_SVG,
              height: 18,
              color: const Color.fromARGB(255, 102, 116, 136),
            ),
          ),
        ),
      );

  Widget searchWidget() {
    TextEditingController textEditingController = TextEditingController();
    return Container(
      height: 35,
      width: 200,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 162, 176, 194),
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          InkWell(
            // onTap: () => controller.searchText.trim().isNotEmpty
            //     ? controller.update()
            //     : null,
            child: SvgPicture.asset(
              ICON_PATH + SEARCH_SVG,
              height: 20,
              color: const Color.fromARGB(255, 78, 98, 124),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: TextField(
              controller: textEditingController,
              onChanged: (String text) {
                controller
                  ..searchText.value = text
                  ..offset = 0
                  ..loadingType = LoadingType.INIT.name
                  ..update();
              },
              keyboardType: TextInputType.text,
              maxLines: 1,
              maxLength: 20,
              cursorColor: PRIMARY_COLOR,
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(255, 113, 135, 168),
                fontSize: 15,
              ),
              decoration: InputDecoration(
                hintText: 'Search posts by title...',
                hintStyle: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 162, 176, 194),
                  fontSize: 15,
                ),
                counterText: '',
                isCollapsed: true,
                border: InputBorder.none,
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: controller.searchText.isNotEmpty,
              child: InkWell(
                onTap: () {
                  textEditingController.text = '';
                  controller
                    ..searchText.value = ''
                    ..offset = 0
                    ..loadingType = LoadingType.INIT.name
                    ..update();
                },
                child: CircleAvatar(
                  backgroundColor: RED_COLOR.withOpacity(0.7),
                  maxRadius: 10,
                  child: SvgPicture.asset(
                    ICON_PATH + CLOSE_SVG,
                    height: 10,
                    color: WHITE_COLOR,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget topTitleWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            InkWell(
              onTap: () => Get
                ..back()
                ..put(HomePageController()).update(),
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: WHITE_COLOR,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: DARK_GREY_COLOR.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Color.fromARGB(255, 61, 78, 100),
                  size: 18,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 35),
                child: Text(
                  'Post List Page',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                    color: const Color.fromARGB(255, 62, 68, 87),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
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

  Widget speciesWidget() {
    controller.isShowLoadingPetSpecies.value = true;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      controller.species = await SpeciesService.fetchSpeciesList(
        isActive: true,
        jwt: controller.accountModel.jwtToken,
      );
      controller.isShowLoadingPetSpecies.value = false;
    });
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: Obx(
        () => controller.isShowLoadingPetSpecies.value
            ? LOADING_WIDGET(size: 40)
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: controller.species
                      .asMap()
                      .entries
                      .map(
                        (e) => speciesItemWidget(speciesModel: e.value),
                      )
                      .toList(),
                ),
              ),
      ),
    );
  }

  Widget speciesItemWidget({required SpeciesModel speciesModel}) =>
      GetBuilder<PostListPageController>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.only(right: 15, top: 5, bottom: 5),
          child: InkWell(
            onTap: () {
              // controller.refreshController.requestRefresh();
              // controller.refreshController.resetNoData();
              //controller.isRefresh.value = true;
              // controller.offset.value = 0;
              controller
                ..selectedSpeciesId.value =
                    controller.selectedSpeciesId.value == speciesModel.id
                        ? -1
                        : speciesModel.id
                ..loadingType = LoadingType.INIT.name
                ..offset = 0
                ..isRefreshBreed = true
                ..update();
            },
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
                    : PRIMARY_COLOR.withOpacity(0.07),
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

  // Widget filterWidget() => Padding(
  //       padding: const EdgeInsets.symmetric(
  //         horizontal: 5,
  //         vertical: 5,
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: [
  //           //*Filter
  //           InkWell(
  //             onTap: () => Get.toNamed(
  //               PURCHASE_POSTS_FILTER_PAGE_ROUTE,
  //             ),
  //             child: Container(
  //               height: 30,
  //               padding: const EdgeInsets.symmetric(
  //                 horizontal: 18,
  //               ),
  //               decoration: BoxDecoration(
  //                 color: PRIMARY_LIGHT_COLOR,
  //                 borderRadius: BorderRadius.circular(15),
  //                 border: Border.all(color: PRIMARY_COLOR, width: 1.5),
  //               ),
  //               child: Row(
  //                 children: [
  //                   SvgPicture.asset(
  //                     ICON_PATH + FILTER_SVG,
  //                     height: 17,
  //                     color: PRIMARY_COLOR,
  //                   ),
  //                   const SizedBox(
  //                     width: 3,
  //                   ),
  //                   Text(
  //                     'Filter',
  //                     style: GoogleFonts.itim(
  //                       color: PRIMARY_COLOR,
  //                       fontSize: 15,
  //                       fontWeight: FontWeight.w500,
  //                       height: 1.5,
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  // //*Gender
  // Row(
  //   children: [
  //     GetBuilder<PostListPageController>(
  //       builder: (controller) => InkWell(
  //         onTap: () {
  //           if (controller.selectedGenderList.contains('MALE') &&
  //               controller.selectedGenderList.contains('FEMALE')) {
  //             controller.selectedGenderList = ['MALE'];
  //           } else if (controller.selectedGenderList
  //               .contains('MALE')) {
  //             controller.selectedGenderList = ['FEMALE'];
  //           } else {
  //             controller.selectedGenderList = ['MALE', 'FEMALE'];
  //           }
  //           controller.refreshController.requestRefresh();
  //           controller.refreshController.resetNoData();
  //           controller.isRefresh.value = true;
  //           controller.offset.value = 0;
  //           controller.update();
  //         },
  //         child: Row(
  //           children: [
  //             Container(
  //               height: 30,
  //               width: 45,
  //               alignment: Alignment.center,
  //               decoration: BoxDecoration(
  //                 color:
  //                     controller.selectedGenderList.contains('MALE')
  //                         ? const Color.fromARGB(255, 99, 194, 238)
  //                         : DARK_GREY_COLOR.withOpacity(0.1),
  //                 borderRadius: const BorderRadius.horizontal(
  //                   left: Radius.circular(15),
  //                 ),
  //                 border: Border.all(
  //                   color:
  //                       controller.selectedGenderList.contains('MALE')
  //                           ? const Color.fromARGB(255, 99, 194, 238)
  //                           : DARK_GREY_COLOR.withOpacity(0.2),
  //                   width: 1,
  //                 ),
  //               ),
  //               child: SvgPicture.asset(
  //                 ICON_PATH + MALE_SVG,
  //                 height: 17,
  //                 color:
  //                     controller.selectedGenderList.contains('MALE')
  //                         ? WHITE_COLOR
  //                         : DARK_GREY_COLOR.withOpacity(0.3),
  //               ),
  //             ),
  //             Container(
  //               height: 30,
  //               width: 45,
  //               alignment: Alignment.center,
  //               decoration: BoxDecoration(
  //                 color:
  //                     controller.selectedGenderList.contains('FEMALE')
  //                         ? const Color.fromARGB(255, 240, 128, 171)
  //                         : DARK_GREY_COLOR.withOpacity(0.1),
  //                 borderRadius: const BorderRadius.horizontal(
  //                     right: Radius.circular(15)),
  //                 border: Border.all(
  //                   color: controller.selectedGenderList
  //                           .contains('FEMALE')
  //                       ? const Color.fromARGB(255, 240, 128, 171)
  //                       : DARK_GREY_COLOR.withOpacity(0.2),
  //                   width: 1,
  //                 ),
  //               ),
  //               child: SvgPicture.asset(
  //                 ICON_PATH + FEMALE_SVG,
  //                 height: 17,
  //                 color:
  //                     controller.selectedGenderList.contains('FEMALE')
  //                         ? WHITE_COLOR
  //                         : DARK_GREY_COLOR.withOpacity(0.3),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   ],
  // ),
  // InkWell(
  //   onTap: () => Get.toNamed(
  //     PURCHASE_POSTS_FILTER_PAGE_ROUTE,
  //   ),
  //   child: Container(
  //     height: 30,
  //     padding: const EdgeInsets.only(left: 13, right: 3),
  //     decoration: BoxDecoration(
  //       color: const Color.fromARGB(255, 227, 233, 241),
  //       borderRadius: BorderRadius.circular(15),
  //       border: Border.all(
  //         color: const Color.fromARGB(255, 171, 175, 187),
  //         width: 1.5,
  //       ),
  //     ),
  //     child: Row(
  //       children: [
  //         Text(
  //           'Price: low → high',
  //           style: GoogleFonts.itim(
  //             color: const Color.fromARGB(255, 95, 105, 131),
  //             fontSize: 15,
  //             fontWeight: FontWeight.w500,
  //             height: 1.5,
  //           ),
  //         ),
  //         const Icon(
  //           Icons.arrow_drop_down,
  //           size: 25,
  //           color: Color.fromARGB(255, 95, 105, 131),
  //         )
  //       ],
  //     ),
  //   ),
  // ),
  //     ],
  //   ),
  // );
}
