import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/rounter.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/purchase_post_detail_page_controller.dart';
import 'package:petapp_mobile/controllers/purchase_posts_page_controller.dart';
import 'package:petapp_mobile/graphql/graphql_config.dart';
import 'package:petapp_mobile/graphql/query_mutation/post.dart';
import 'package:petapp_mobile/graphql/query_mutation/species.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';
import 'package:petapp_mobile/models/species_model/species_model.dart';
import 'package:petapp_mobile/services/post_services.dart';
import 'package:petapp_mobile/services/species_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/customer/post_detail_page/post_detail_page.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PurchasePostsPage extends GetView<PurchasePostsPageController> {
  const PurchasePostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: WHITE_COLOR,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return GraphQLProvider(
      client: GRAPHQL_CLIENT,
      child: Scaffold(
        backgroundColor: WHITE_COLOR,
        extendBody: true,
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 33),
                  margin: const EdgeInsets.only(
                    bottom: 20,
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
                  child: Column(
                    children: [
                      topWidget(),
                      speciesWidget(),
                      const SizedBox(
                        height: 5,
                      ),
                      filterWidget(),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                controller.selectedSpeciesId.value == -1
                    ? Expanded(
                        child: Query(
                          options: QueryOptions(
                            document: gql(FETCH_ALL_PURCHASE_POST_LIST),
                          ),
                          builder: (
                            QueryResult result, {
                            VoidCallback? refetch,
                            FetchMore? fetchMore,
                          }) {
                            if (result.hasException) {
                              return Text(result.exception.toString());
                            }
                            if (result.isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            controller.postList =
                                PostService.getPostList(result.data!).obs;
                            return Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14),
                                    child: CustomScrollView(
                                      slivers: [
                                        SliverGrid.count(
                                          crossAxisCount: 2,
                                          childAspectRatio: 0.63,
                                          mainAxisSpacing: 5,
                                          crossAxisSpacing: 4,
                                          children: controller.postList
                                              .asMap()
                                              .entries
                                              .map(
                                                (e) => purchasePostItemWidget(
                                                    postModel: e.value),
                                              )
                                              .toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    : Expanded(
                        child: MixinBuilder<PurchasePostsPageController>(
                          builder: (controller) => Query(
                            options: controller.selectedBreedMap[controller
                                            .selectedSpeciesId.value] !=
                                        null &&
                                    controller
                                        .selectedBreedMap[
                                            controller.selectedSpeciesId.value]!
                                        .isNotEmpty
                                ? QueryOptions(
                                    document: gql(FETCH_PURCHASE_POST_LIST),
                                    variables: {
                                        'speciesId':
                                            controller.selectedSpeciesId.value,
                                        'ltPrice': controller.ltPrice.value,
                                        'gtePrice': controller.gtePrice.value,
                                        'gender': controller.selectedGenderList,
                                        'isSeed': [true, false],
                                        'ltAgeRange': controller.ltAge.value,
                                        'gteAgeRange': controller.gteAge.value,
                                        'breedName':
                                            controller.orderByBreed.isNotEmpty
                                                ? controller.orderByBreed.value
                                                : null,
                                        'price':
                                            controller.orderByPrice.isNotEmpty
                                                ? controller.orderByPrice.value
                                                : null,
                                        'status': 'PUBLISHED',
                                        'breeds': controller.selectedBreedMap[
                                            controller.selectedSpeciesId.value]
                                      })
                                : QueryOptions(
                                    document: gql(
                                        FETCH_PURCHASE_POST_LIST_WITHOUT_BREED),
                                    variables: {
                                        'speciesId':
                                            controller.selectedSpeciesId.value,
                                        'ltPrice': controller.ltPrice.value,
                                        'gtePrice': controller.gtePrice.value,
                                        'gender': controller.selectedGenderList,
                                        'isSeed': [true, false],
                                        'ltAgeRange': controller.ltAge.value,
                                        'gteAgeRange': controller.gteAge.value,
                                        'breedName':
                                            controller.orderByBreed.isNotEmpty
                                                ? controller.orderByBreed.value
                                                : null,
                                        'price':
                                            controller.orderByPrice.isNotEmpty
                                                ? controller.orderByPrice.value
                                                : null,
                                        'status': 'PUBLISHED'
                                      }),
                            builder: (
                              QueryResult result, {
                              VoidCallback? refetch,
                              FetchMore? fetchMore,
                            }) {
                              if (result.hasException) {
                                return Text(result.exception.toString());
                              }
                              if (result.isLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              controller.postList =
                                  PostService.getPostList(result.data!).obs;
                              return Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14),
                                      child: CustomScrollView(
                                        slivers: [
                                          SliverGrid.count(
                                            crossAxisCount: 2,
                                            childAspectRatio: 0.63,
                                            mainAxisSpacing: 5,
                                            crossAxisSpacing: 4,
                                            children: controller.postList
                                                .asMap()
                                                .entries
                                                .map(
                                                  (e) => purchasePostItemWidget(
                                                      postModel: e.value),
                                                )
                                                .toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget topWidget() => Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 5,
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
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Query(
            options:
                QueryOptions(document: gql(FETCH_ALL_SPECIES), variables: {}),
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
          padding: const EdgeInsets.only(
            right: 15,
            top: 5,
            bottom: 5,
          ),
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
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //!Filter
            InkWell(
              onTap: () => Get.toNamed(
                PURCHASE_POSTS_FILTER_PAGE_ROUNTER,
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
            //!Gender
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
                PURCHASE_POSTS_FILTER_PAGE_ROUNTER,
              ),
              child: Container(
                height: 30,
                padding: const EdgeInsets.only(
                  left: 13,
                  right: 3,
                ),
                decoration: BoxDecoration(
                  color: DARK_GREY_COLOR.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: DARK_GREY_COLOR.withOpacity(0.4),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      'Price: low → high',
                      style: GoogleFonts.itim(
                        color: DARK_GREY_COLOR.withOpacity(0.65),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    ),

                    // SvgPicture.asset(
                    //   ICON_PATH + SORT_SVG,
                    //   height: 12,
                    //   color: DARK_GREY_COLOR.withOpacity(0.65),
                    // ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 25,
                      color: DARK_GREY_COLOR.withOpacity(0.65),
                    )
                  ],
                ),
              ),
            ),

            //!Sort
            // Obx(
            //   () => Padding(
            //     padding: const EdgeInsets.only(
            //       bottom: 4,
            //     ),
            //     child: DropdownButton<String>(
            //       value: controller.selectedSort.value,
            //       style: GoogleFonts.itim(
            //         color: PRIMARY_COLOR,
            //         fontSize: 15,
            //       ),
            //       underline: Container(
            //         height: 2,
            //         color: PRIMARY_COLOR,
            //       ),
            //       onChanged: (String? value) {
            //         controller.selectedSort.value = value!;
            //         switch (value) {
            //           case 'Price: Low to High':
            //             controller.orderByPrice.value = 'asc';
            //             controller.orderByBreed.value = '';
            //             break;
            //           case 'Price: High to Low':
            //             controller.orderByPrice.value = 'desc';
            //             controller.orderByBreed.value = '';
            //             break;
            //           case 'Breed: A to Z':
            //             controller.orderByPrice.value = '';
            //             controller.orderByBreed.value = 'asc';
            //             break;
            //           case 'Breed: Z to A':
            //             controller.orderByPrice.value = '';
            //             controller.orderByBreed.value = 'desc';

            //             break;
            //           default:
            //             controller.orderByPrice.value = 'asc';
            //             controller.orderByBreed.value = '';
            //         }
            //       },
            //       items: controller.sorts
            //           .asMap()
            //           .entries
            //           .map(
            //             (e) => DropdownMenuItem(
            //               child: Row(
            //                 children: [
            //                   SvgPicture.asset(
            //                     ICON_PATH + SORT_SVG,
            //                     width: 13,
            //                     color: PRIMARY_COLOR,
            //                   ),
            //                   const SizedBox(
            //                     width: 2,
            //                   ),
            //                   Text(e.value),
            //                 ],
            //               ),
            //               value: e.value,
            //             ),
            //           )
            //           .toList(),
            //     ),
            //   ),
            // ),
          ],
        ),
      );

  Widget purchasePostItemWidget({required PostModel postModel}) => InkWell(
        onTap: () {
          Get.delete<PurchasePostDetailPageController>();
          Get.put(PurchasePostDetailPageController(postModel: postModel));
          Get.to(() => const PurchasePostDetaiPage());
        },
        child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                color: DARK_GREY_COLOR.withOpacity(0.3),
                blurRadius: 6,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(7),
                      ),
                      child: Container(
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            alignment: Alignment.topCenter,
                            image: NetworkImage(postModel.mediaModels![0].url),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 0,
                      child: SizedBox(
                        width: 160,
                        height: 25,
                        child: ImageFiltered(
                          imageFilter:
                              ImageFilter.blur(sigmaX: 10, sigmaY: 0.3),
                          child: Image.network(
                            postModel.mediaModels![0].url,
                            fit: BoxFit.cover,
                            alignment: Alignment.bottomLeft,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: 500,
                        height: 25,
                        color: PRIMARY_COLOR.withOpacity(0.1),
                      ),
                    ),
                    Positioned(
                      bottom: 3,
                      left: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Positioned(
                                child: GRADIENT_WIDGET(
                                  gradient: const LinearGradient(colors: [
                                    Color.fromARGB(255, 123, 41, 255),
                                    Color.fromARGB(255, 1, 182, 182),
                                  ]),
                                  child: Text(
                                    postModel.petModel!.breedModel.name,
                                    style: GoogleFonts.quicksand(
                                      color: DARK_GREY_COLOR,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 1.5,
                                bottom: 1.5,
                                child: Text(
                                  postModel.petModel!.breedModel.name,
                                  style: GoogleFonts.quicksand(
                                    color: WHITE_COLOR,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            ' (' +
                                postModel
                                    .petModel!.breedModel.speciesModel!.name +
                                ')',
                            style: GoogleFonts.quicksand(
                              color: WHITE_COLOR.withOpacity(1),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Positioned(
                    //   bottom: 40,
                    //   child: SizedBox(
                    //     width: 300,
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         const CircleAvatar(
                    //           radius: 4,
                    //           backgroundColor: WHITE_COLOR,
                    //         ),
                    //         const SizedBox(
                    //           width: 4,
                    //         ),
                    //         CircleAvatar(
                    //           radius: 4,
                    //           backgroundColor: WHITE_COLOR.withOpacity(0.7),
                    //         ),
                    //         const SizedBox(
                    //           width: 4,
                    //         ),
                    //         CircleAvatar(
                    //           radius: 4,
                    //           backgroundColor: WHITE_COLOR.withOpacity(0.7),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                          color: PRIMARY_LIGHT_COLOR.withOpacity(0.65),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GRADIENT_WIDGET(
                              child: SvgPicture.asset(
                                ICON_PATH + BOOKMARK_SVG,
                                color: PRIMARY_COLOR,
                                height: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // //*Time Created
                    // Positioned(
                    //   bottom: 5,
                    //   right: 5,
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Row(
                    //         children: [
                    //           SvgPicture.asset(
                    //             ICON_PATH + CLOCK_SVG,
                    //             height: 11,
                    //             color: WHITE_COLOR,
                    //           ),
                    //           const SizedBox(
                    //             width: 3.5,
                    //           ),
                    //           Text(
                    //             FORMAT_DATE_TIME(
                    //                 dateTime: postModel.createTime!,
                    //                 pattern: TIME_PATTERN),
                    //             style: GoogleFonts.quicksand(
                    //               color: WHITE_COLOR,
                    //               fontSize: 12,
                    //               fontWeight: FontWeight.w600,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       Text(
                    //         FORMAT_DATE_TIME(
                    //             dateTime: postModel.createTime!,
                    //             pattern: DATE_PATTERN),
                    //         style: GoogleFonts.quicksand(
                    //           color: WHITE_COLOR,
                    //           fontSize: 12,
                    //           fontWeight: FontWeight.w600,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      postModel.description!,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.quicksand(
                        fontSize: 13,
                        color: const Color.fromARGB(211, 32, 32, 32),
                        height: 1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // RichText(
                    //   text: TextSpan(
                    //     text: 'Price: ',
                    //     style: GoogleFonts.quicksand(
                    //       color: DARK_GREY_COLOR.withOpacity(0.8),
                    //       fontSize: 12,
                    //       fontStyle: FontStyle.italic,
                    //     ),
                    //     children: <TextSpan>[
                    //       TextSpan(
                    //         text:
                    //             FORMAT_MONEY(price: postModel.provisionalTotal),
                    //         style: GoogleFonts.quicksand(
                    //           fontWeight: FontWeight.w700,
                    //           color: PRIMARY_COLOR,
                    //           fontSize: 17,
                    //           height: 1.4,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 2,
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Wrap(
                    //   spacing: 8,
                    //   children: [

                    //     Container(
                    //       alignment: Alignment.center,
                    //       height: 25,
                    //       width: 70,
                    //       decoration: BoxDecoration(
                    //         color: DARK_GREY_COLOR.withOpacity(0.13),
                    //         borderRadius: const BorderRadius.all(
                    //           Radius.circular(25),
                    //         ),
                    //       ),
                    //       child: Text(
                    //         postModel.petModel!.ageRange.toString() + ' Month',
                    //         textAlign: TextAlign.center,
                    //         style: GoogleFonts.quicksand(
                    //           fontSize: 12,
                    //           color: DARK_GREY_COLOR.withOpacity(0.7),
                    //           height: 1.5,
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 90,
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text(
                              FORMAT_MONEY(price: postModel.provisionalTotal),
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w500,
                                color: PRIMARY_COLOR,
                                fontSize: 18,
                                height: 1,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 18,
                              width: 25,
                              child: Material(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(25),
                                ),
                                color: const Color.fromARGB(255, 223, 250, 246),
                                child: Wrap(
                                  spacing: 4,
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  runAlignment: WrapAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      ICON_PATH + INJECTION_SVG,
                                      color: const Color.fromARGB(
                                          255, 15, 219, 192),
                                      height: 16,
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              height: 18,
                              width: 25,
                              child: Material(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(25),
                                ),
                                color: postModel.petModel!.gender == 'MALE'
                                    ? const Color.fromARGB(255, 215, 243, 252)
                                    : const Color.fromARGB(255, 253, 228, 242),
                                child: Wrap(
                                  spacing: 4,
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  runAlignment: WrapAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      postModel.petModel!.gender == 'MALE'
                                          ? ICON_PATH + MALE_SVG
                                          : ICON_PATH + FEMALE_SVG,
                                      color:
                                          postModel.petModel!.gender == 'MALE'
                                              ? const Color.fromARGB(
                                                  255, 39, 111, 245)
                                              : const Color.fromARGB(
                                                  255, 244, 55, 165),
                                      height: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
