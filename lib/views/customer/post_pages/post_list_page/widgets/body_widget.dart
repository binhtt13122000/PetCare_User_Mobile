import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/configs/enum_config.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/post_list_page_controller.dart';
import 'package:petapp_mobile/graphql/graphql_config.dart';
import 'package:petapp_mobile/graphql/query_mutation/post.dart';
import 'package:petapp_mobile/models/post_model_hasura/post_model_hasura.dart';
import 'package:petapp_mobile/services/post_services/post_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostListBodyWidget extends GetView<PostListPageController> {
  const PostListBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      GetBuilder<PostListPageController>(builder: (_) {
        if (controller.loadingType != LoadingType.LOAD_MORE.name) {
          controller.isLoadingData.value = true;
        }
        WidgetsBinding.instance!.addPostFrameCallback((_) async {
          late QueryOptions queryOptions;
          if (controller.selectedSpeciesId.value == -1) {
            queryOptions = QueryOptions(
              document: gql(FETCH_ALL_PURCHASE_POST_LIST_WITHOUT_SPECIES),
              variables: {
                'offset': controller.offset,
                'limit': controller.limit,
                'lteDob': controller.lteDob.value,
                'gteDob': controller.gteDob.value,
                'customerId': controller.accountModel.customerModel.id,
                'ltPrice': controller.ltPrice.value,
                'gtePrice': controller.gtePrice.value,
                'gender': controller.selectedGenderList,
                'isSeed': const [true, false],
                'price': controller.orderByPrice.isNotEmpty
                    ? controller.orderByPrice.value
                    : null,
                'status': 'PUBLISHED',
                'post_type': controller.selectedPostType,
                'title': '%${controller.searchText.value}%'
              },
            );
          } else {
            if (controller
                        .selectedBreedMap[controller.selectedSpeciesId.value] !=
                    null &&
                controller.selectedBreedMap[controller.selectedSpeciesId.value]!
                    .isNotEmpty) {
              queryOptions = QueryOptions(
                document: gql(FETCH_PURCHASE_POST_LIST),
                //document: gql(FETCH_PURCHASE_POST_LIST_WITHOUT_BREED),
                variables: {
                  'offset': controller.offset,
                  'limit': controller.limit,
                  'lteDob': controller.lteDob.value,
                  'gteDob': controller.gteDob.value,
                  'customerId': controller.accountModel.customerModel.id,
                  'speciesId': controller.selectedSpeciesId.value,
                  'ltPrice': controller.ltPrice.value,
                  'gtePrice': controller.gtePrice.value,
                  'gender': controller.selectedGenderList,
                  'isSeed': const [true, false],
                  'price': controller.orderByPrice.isNotEmpty
                      ? controller.orderByPrice.value
                      : null,
                  'status': 'PUBLISHED',
                  'post_type': controller.selectedPostType,
                  'title': '%${controller.searchText.value}%',
                  'breeds': controller
                      .selectedBreedMap[controller.selectedSpeciesId.value],
                },
              );
            } else {
              queryOptions = QueryOptions(
                document: gql(FETCH_PURCHASE_POST_LIST_WITHOUT_BREED),
                variables: {
                  'offset': controller.offset,
                  'limit': controller.limit,
                  'lteDob': controller.lteDob.value,
                  'gteDob': controller.gteDob.value,
                  'customerId': controller.accountModel.customerModel.id,
                  'speciesId': controller.selectedSpeciesId.value,
                  'ltPrice': controller.ltPrice.value,
                  'gtePrice': controller.gtePrice.value,
                  'gender': controller.selectedGenderList,
                  'isSeed': const [true, false],
                  'price': controller.orderByPrice.isNotEmpty
                      ? controller.orderByPrice.value
                      : null,
                  'status': 'PUBLISHED',
                  'post_type': controller.selectedPostType,
                  'title': '%${controller.searchText.value}%'
                },
              );
            }
          }
          QueryResult queryResult = await CLIENT_TO_QUERY().query(queryOptions);

          switch (controller.loadingType) {
            case 'INIT':
              controller
                ..postHasuraList.value =
                    PostService.getPostHasuraList(queryResult.data!)
                ..offset = controller.postHasuraList.length;
              break;
            case 'REFRESH':
              controller
                ..postHasuraList.value =
                    PostService.getPostHasuraList(queryResult.data!)
                ..refreshController.refreshCompleted()
                ..offset = controller.postHasuraList.length;
              break;
            case 'LOAD_MORE':
              List<PostModelHasura> convertData =
                  PostService.getPostHasuraList(queryResult.data!);
              if (convertData.isNotEmpty) {
                controller
                  ..postHasuraList.value = [
                    ...controller.postHasuraList,
                    ...convertData
                  ]
                  ..offset = controller.postHasuraList.length;
              }
              controller.refreshController.loadComplete();
              break;
          }
          controller.isLoadingData.value = false;
        });
        return Obx(
          () => controller.isLoadingData.value
              ? Expanded(child: LOADING_WIDGET())
              : Expanded(
                  child: SmartRefresher(
                    controller: controller.refreshController,
                    enablePullUp: true,
                    onRefresh: () async {
                      controller
                        ..offset = 0
                        ..loadingType = LoadingType.REFRESH.name
                        ..update();
                    },
                    onLoading: () async {
                      controller
                        ..loadingType = LoadingType.LOAD_MORE.name
                        ..update();
                    },
                    child: bodyWidget(),
                  ),
                ),
        );
      });

  Widget bodyWidget() => controller.postHasuraList.isEmpty
      ? NO_DATA_WIDGET(content: 'Sorry, no post data found.')
      : SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Wrap(
                alignment: WrapAlignment.start,
                children: controller.postHasuraList
                    .asMap()
                    .entries
                    .map(
                      (e) => purchasePostItemHasuraWidget(postModel: e.value),
                    )
                    .toList(),
              ),
            ],
          ),
        );
  Widget purchasePostItemHasuraWidget({required PostModelHasura postModel}) =>
      InkWell(
        onTap: () {
          Get.toNamed('$POST_DETAIL_PAGE_ROUTE/${postModel.id}');
        },
        child: Container(
          margin: const EdgeInsets.all(5),
          width: 160,
          height: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 198, 206, 223),
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
                    Container(
                      height: 250,
                      alignment: Alignment.topCenter,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(7),
                        ),
                        child: Container(
                          height: 250,
                          alignment: Alignment.topCenter,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              alignment: Alignment.topCenter,
                              image: (postModel.mediaModels != null &&
                                      postModel.mediaModels!.isNotEmpty)
                                  ? NetworkImage(postModel.mediaModels![0].url)
                                  : Image.asset(IMAGE_PATH + NO_IMAGE_PNG)
                                      .image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 5),
                        child: Container(
                          color: WHITE_COLOR.withOpacity(0.3),
                          height: 10,
                          width: 160,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 3,
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
                                    postModel.petModel!.breedModel!.name,
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
                                  postModel.petModel!.breedModel!.name,
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
                                    .petModel!.breedModel!.speciesModel!.name +
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
                    //   top: 10,
                    //   right: 10,
                    //   child: Container(
                    //     height: 28,
                    //     width: 28,
                    //     decoration: BoxDecoration(
                    //       color: PRIMARY_LIGHT_COLOR.withOpacity(0.8),
                    //       borderRadius: BorderRadius.circular(5),
                    //     ),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         GRADIENT_WIDGET(
                    //           child: SvgPicture.asset(
                    //             ICON_PATH + BOOKMARK_SVG,
                    //             color: PRIMARY_COLOR,
                    //             height: 18,
                    //             width: 18,
                    //             fit: BoxFit.cover,
                    //             allowDrawingOutsideViewBox: true,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
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
                      postModel.title,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.quicksand(
                        fontSize: 13,
                        color: const Color.fromARGB(255, 72, 94, 124),
                        height: 1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 3),
                            child: CUSTOM_TEXT('[${postModel.type}]',
                                fontSize: 15,
                                color: postModel.type == 'SALE'
                                    ? BLUE_COLOR
                                    : PINK_COLOR),
                          ),
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                FORMAT_MONEY(price: postModel.transactionTotal),
                                style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.w600,
                                  color: PRIMARY_COLOR,
                                  fontSize: 20,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  // Widget purchasePostItemHasuraWidget({required PostModelHasura postModel}) =>
  //     InkWell(
  //       onTap: () {
  //         Get.toNamed('$POST_DETAIL_PAGE_ROUTE/${postModel.id}');
  //       },
  //       child: Container(
  //         margin: const EdgeInsets.all(5),
  //         width: 160,
  //         height: 250,
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(7),
  //           boxShadow: const [
  //             BoxShadow(
  //               color: Color.fromARGB(255, 198, 206, 223),
  //               blurRadius: 6,
  //             )
  //           ],
  //         ),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Expanded(
  //               child: Stack(
  //                 alignment: Alignment.center,
  //                 children: [
  //                   ClipRRect(
  //                     borderRadius: const BorderRadius.vertical(
  //                       top: Radius.circular(7),
  //                     ),
  //                     child: Container(
  //                       alignment: Alignment.topCenter,
  //                       decoration: BoxDecoration(
  //                         image: DecorationImage(
  //                           alignment: Alignment.topCenter,
  //                           image: (postModel.mediaModels != null &&
  //                                   postModel.mediaModels!.isNotEmpty)
  //                               ? NetworkImage(postModel.mediaModels![0].url)
  //                               : Image.asset(IMAGE_PATH + NO_IMAGE_PNG).image,
  //                           fit: BoxFit.cover,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   Positioned(
  //                     bottom: 0,
  //                     child: SizedBox(
  //                       width: 160,
  //                       height: 25,
  //                       child: ImageFiltered(
  //                         imageFilter:
  //                             ImageFilter.blur(sigmaX: 10, sigmaY: 0.3),
  //                         child: postModel.mediaModels != null &&
  //                                 postModel.mediaModels!.isNotEmpty
  //                             ? Image.network(
  //                                 postModel.mediaModels![0].url,
  //                                 fit: BoxFit.cover,
  //                                 alignment: Alignment.bottomLeft,
  //                                 errorBuilder: (_, object, stackTrace) =>
  //                                     Image.asset(
  //                                   IMAGE_PATH + NO_IMAGE_PNG,
  //                                   fit: BoxFit.cover,
  //                                   width: 50,
  //                                   height: 50,
  //                                 ),
  //                               )
  //                             : Image.asset(
  //                                 IMAGE_PATH + NO_IMAGE_PNG,
  //                                 fit: BoxFit.cover,
  //                                 alignment: Alignment.bottomLeft,
  //                               ),
  //                       ),
  //                     ),
  //                   ),
  //                   Positioned(
  //                     bottom: 0,
  //                     child: Container(
  //                       width: 500,
  //                       height: 25,
  //                       color: PRIMARY_COLOR.withOpacity(0.1),
  //                     ),
  //                   ),
  //                   Positioned(
  //                     bottom: 3,
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       children: [
  //                         SizedBox(
  //                           width: 110,
  //                           child: FittedBox(
  //                             fit: BoxFit.scaleDown,
  //                             child: Stack(
  //                               children: [
  //                                 Positioned(
  //                                   child: GRADIENT_WIDGET(
  //                                     gradient: const LinearGradient(colors: [
  //                                       Color.fromARGB(255, 123, 41, 255),
  //                                       Color.fromARGB(255, 1, 182, 182),
  //                                     ]),
  //                                     child: Text(
  //                                       postModel.petModel!.breedModel!.name,
  //                                       style: GoogleFonts.quicksand(
  //                                         color: DARK_GREY_COLOR,
  //                                         fontSize: 15,
  //                                         fontWeight: FontWeight.w600,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 Positioned(
  //                                   left: 1.5,
  //                                   bottom: 1.5,
  //                                   child: Text(
  //                                     postModel.petModel!.breedModel!.name,
  //                                     style: GoogleFonts.quicksand(
  //                                       color: WHITE_COLOR,
  //                                       fontSize: 15,
  //                                       fontWeight: FontWeight.w600,
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                         Text(
  //                           ' (' +
  //                               postModel
  //                                   .petModel!.breedModel!.speciesModel!.name +
  //                               ')',
  //                           style: GoogleFonts.quicksand(
  //                             color: WHITE_COLOR.withOpacity(1),
  //                             fontSize: 12,
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   Positioned(
  //                     top: 10,
  //                     right: 10,
  //                     child: Container(
  //                       height: 28,
  //                       width: 28,
  //                       decoration: BoxDecoration(
  //                         color: PRIMARY_LIGHT_COLOR.withOpacity(0.8),
  //                         borderRadius: BorderRadius.circular(5),
  //                       ),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         crossAxisAlignment: CrossAxisAlignment.center,
  //                         children: [
  //                           GRADIENT_WIDGET(
  //                             child: SvgPicture.asset(
  //                               ICON_PATH + BOOKMARK_SVG,
  //                               color: PRIMARY_COLOR,
  //                               height: 18,
  //                               width: 18,
  //                               fit: BoxFit.cover,
  //                               allowDrawingOutsideViewBox: true,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     postModel.title,
  //                     textAlign: TextAlign.left,
  //                     maxLines: 2,
  //                     overflow: TextOverflow.ellipsis,
  //                     style: GoogleFonts.quicksand(
  //                       fontSize: 13,
  //                       color: const Color.fromARGB(255, 72, 94, 124),
  //                       height: 1,
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     height: 5,
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.only(bottom: 10),
  //                     child: Row(
  //                       crossAxisAlignment: CrossAxisAlignment.center,
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.only(right: 3),
  //                           child: CUSTOM_TEXT('[${postModel.type}]',
  //                               fontSize: 15,
  //                               color: postModel.type == 'SALE'
  //                                   ? BLUE_COLOR
  //                                   : PINK_COLOR),
  //                         ),
  //                         Expanded(
  //                           child: FittedBox(
  //                             fit: BoxFit.scaleDown,
  //                             child: Text(
  //                               FORMAT_MONEY(price: postModel.transactionTotal),
  //                               style: GoogleFonts.quicksand(
  //                                 fontWeight: FontWeight.w600,
  //                                 color: PRIMARY_COLOR,
  //                                 fontSize: 20,
  //                                 letterSpacing: 0.5,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
}
