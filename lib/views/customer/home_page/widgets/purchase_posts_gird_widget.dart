import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/home_page_controller.dart';
import 'package:petapp_mobile/controllers/purchase_post_detail_page_controller.dart';
import 'package:petapp_mobile/graphql/query_mutation/post.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';
import 'package:petapp_mobile/services/post_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/customer/post_detail_page/post_detail_page.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PurchasePostGirdsWidget extends GetView<HomePageController> {
  const PurchasePostGirdsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Query(
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
            return const Expanded(
              child: Center(
                child: SpinKitSpinningLines(
                  color: PRIMARY_COLOR,
                  size: 150,
                ),
              ),
            );
          }
          controller.postList = PostService.getPostList(result.data!).obs;
          return Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: CustomScrollView(
                      slivers: [
                        SliverGrid.count(
                          crossAxisCount: 2,
                          childAspectRatio: 15,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 4,
                          children: const [SizedBox.shrink()],
                        ),
                        SliverGrid.count(
                          crossAxisCount: 2,
                          childAspectRatio: 0.63,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 4,
                          children: controller.postList
                              .asMap()
                              .entries
                              .map(
                                (e) =>
                                    purchasePostItemWidget(postModel: e.value),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
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
                          Container(
                            height: 18,
                            width: 25,
                            margin: const EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: postModel.petModel!.gender == 'MALE'
                                    ? const Color.fromARGB(255, 152, 188, 255)
                                    : const Color.fromARGB(255, 255, 146, 210),
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(25),
                              ),
                              color: postModel.petModel!.gender == 'MALE'
                                  ? const Color.fromARGB(255, 215, 243, 252)
                                  : const Color.fromARGB(255, 253, 228, 242),
                            ),
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
                                  color: postModel.petModel!.gender == 'MALE'
                                      ? const Color.fromARGB(255, 39, 111, 245)
                                      : const Color.fromARGB(255, 244, 55, 165),
                                  height: 12,
                                  width: 12,
                                  fit: BoxFit.cover,
                                  allowDrawingOutsideViewBox: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                          color: PRIMARY_LIGHT_COLOR.withOpacity(0.8),
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
                                width: 18,
                                fit: BoxFit.cover,
                                allowDrawingOutsideViewBox: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
                        color: const Color.fromARGB(255, 72, 94, 124),
                        height: 1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    FittedBox(
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.scaleDown,
                      child: Text(
                        FORMAT_MONEY(price: postModel.provisionalTotal),
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w600,
                          color: PRIMARY_COLOR,
                          fontSize: 20,
                          height: 1,
                          letterSpacing: 0.5,
                        ),
                      ),
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
