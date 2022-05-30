import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/home_page_controller.dart';
import 'package:petapp_mobile/controllers/sale_post_detail_page_controller.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/customer/home_page/widgets/purchase_posts_gird_widget.dart';

class ServicesBodyWidget extends GetView<HomePageController> {
  const ServicesBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
            color: DARK_GREY_COLOR.withOpacity(0.2),
            height: 1,
            margin: const EdgeInsets.only(
              right: 20,
              left: 20,
              bottom: 10,
            ),
          ),
          const SalePostGirdsWidget(),
          Obx(
            () => controller.selectedServiceIndex.value == 2
                ? veterinaryServicesWidget()
                : const SizedBox.shrink(),
          ),
          Obx(
            () => controller.selectedServiceIndex.value == 3
                ? groomingServicesWidget()
                : const SizedBox.shrink(),
          ),
          Obx(
            () => controller.selectedServiceIndex.value == 4
                ? breedServicesWidget()
                : const SizedBox.shrink(),
          ),
          Obx(
            () => controller.selectedServiceIndex.value == 5
                ? trainingServicesWidget()
                : const SizedBox.shrink(),
          ),
          const SizedBox(
            height: 60,
          ),
        ],
      );

  Widget purchasePostItemWidget({required PostModel postModel}) => InkWell(
        onTap: () {
          Get.delete<SalePostDetailPageController>();
          Get.toNamed(PURCHASE_POSTS_PAGE_ROUTE);
        },
        child: Container(
          padding: const EdgeInsets.only(bottom: 10),
          margin: const EdgeInsets.all(15),
          width: 320,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 222, 228, 238),
                blurRadius: 8,
                offset: Offset(5, 5),
              )
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 18,
                      backgroundColor: PRIMARY_COLOR,
                      backgroundImage: NetworkImage(
                          'https://lh3.googleusercontent.com/a-/AOh14Giq7w5GSupG5JXnHM2i-4yAYESAoR3VpEdVFQ1Bkg=s288-p-rw-no'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Lập đẹp trai',
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.quicksand(
                              fontSize: 15,
                              color: const Color.fromARGB(211, 32, 32, 32),
                              height: 1,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                ICON_PATH + CLOCK_SVG,
                                height: 11,
                                width: 11,
                                color: DARK_GREY_COLOR.withAlpha(170),
                                allowDrawingOutsideViewBox: true,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 3.5,
                              ),
                              Text(
                                FORMAT_DATE_TIME(
                                    dateTime: DateTime.now(),
                                    pattern: DATE_TIME_PATTERN),
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.quicksand(
                                  fontSize: 13,
                                  color: DARK_GREY_COLOR.withAlpha(170),
                                  height: 1,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: SvgPicture.asset(
                          ICON_PATH + ELLIPSIS_SVG,
                          height: 18,
                          width: 18,
                          fit: BoxFit.cover,
                          color: const Color.fromARGB(255, 180, 204, 226),
                          allowDrawingOutsideViewBox: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        postModel.description!,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.quicksand(
                          fontSize: 13,
                          color: DARK_GREY_COLOR.withAlpha(170),
                          height: 1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      'Detail',
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.quicksand(
                        fontSize: 13,
                        color: PRIMARY_COLOR.withAlpha(120),
                        height: 1,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        //fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaY: 8, sigmaX: 8),
                      child: Container(
                        height: 270,
                        width: 300,
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                            image: NetworkImage(postModel.mediaModels![0].url),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 220,
                    width: 300,
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                          image: NetworkImage(postModel.mediaModels![0].url)),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: 50,
                      width: 300,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(20),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromARGB(20, 250, 2, 118),
                            Color.fromARGB(20, 171, 2, 250),
                            Color.fromARGB(20, 98, 0, 255),
                            Color.fromARGB(80, 32, 125, 248),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  postModel.petModel!.breedModel!.name,
                                  textAlign: TextAlign.left,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.quicksand(
                                    fontSize: 15,
                                    color: WHITE_COLOR,
                                    height: 1.2,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  ' (' +
                                      postModel.petModel!.breedModel!
                                          .speciesModel!.name +
                                      ')',
                                  textAlign: TextAlign.left,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.quicksand(
                                    fontSize: 13,
                                    color: WHITE_COLOR,
                                    height: 1,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              FORMAT_MONEY(price: postModel.provisionalTotal),
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w600,
                                color: WHITE_COLOR,
                                fontSize: 18,
                              ),
                            ),
                            // Row(
                            //   children: [
                            //     Text(
                            //       '15',
                            //       textAlign: TextAlign.left,
                            //       maxLines: 2,
                            //       overflow: TextOverflow.ellipsis,
                            //       style: GoogleFonts.quicksand(
                            //         fontSize: 17,
                            //         color: WHITE_COLOR,
                            //         height: 1,
                            //         fontWeight: FontWeight.w600,
                            //       ),
                            //     ),
                            //     const SizedBox(
                            //       width: 5,
                            //     ),
                            //     SvgPicture.asset(
                            //       ICON_PATH + BOOKMARK_SVG,
                            //       height: 20,
                            //       color: WHITE_COLOR,
                            //     ),
                            //   ],
                            // )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 65,
                    child: SizedBox(
                      width: 300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 5,
                            backgroundColor: WHITE_COLOR,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: WHITE_COLOR.withOpacity(0.7),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: WHITE_COLOR.withOpacity(0.7),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    right: 15,
                    child: SvgPicture.asset(
                      ICON_PATH + BOOKMARK_SVG,
                      height: 22,
                      width: 22,
                      fit: BoxFit.cover,
                      color: WHITE_COLOR,
                      allowDrawingOutsideViewBox: true,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );

  // Widget purchasePostListWidget() =>
  //     GetBuilder<HomePageController>(builder: (_) {
  //       controller.isLoading.value = true;
  //       WidgetsBinding.instance!.addPersistentFrameCallback((_) async {
  //         QueryResult result = await CLIENT_TO_QUERY().query(
  //           QueryOptions(
  //               document: gql(FETCH_ALL_PURCHASE_POST_LIST),
  //               variables: {
  //                 '_customerId': controller.accountModel.customerModel.id
  //               }),
  //         );
  //         controller.postList = PostService.getPostList(result.data!);
  //         controller.isLoading.value = false;
  //       });

  //       return Obx(
  //         () => controller.isLoading.value
  //             ? const Expanded(
  //                 child: Center(
  //                   child: SpinKitSpinningLines(
  //                     color: PRIMARY_COLOR,
  //                     size: 150,
  //                   ),
  //                 ),
  //               )
  //             : Expanded(
  //                 child: Column(
  //                   children: [
  //                     Expanded(
  //                       child: Container(
  //                         padding: const EdgeInsets.symmetric(horizontal: 14),
  //                         child: CustomScrollView(
  //                           slivers: [
  //                             SliverGrid.count(
  //                               crossAxisCount: 2,
  //                               childAspectRatio: 15,
  //                               mainAxisSpacing: 5,
  //                               crossAxisSpacing: 4,
  //                               children: const [SizedBox.shrink()],
  //                             ),
  //                             SliverGrid.count(
  //                               crossAxisCount: 2,
  //                               childAspectRatio: 0.63,
  //                               mainAxisSpacing: 5,
  //                               crossAxisSpacing: 4,
  //                               children: controller.postList
  //                                   .asMap()
  //                                   .entries
  //                                   .map(
  //                                     (e) => purchasePostItemWidget(
  //                                         postModel: e.value),
  //                                   )
  //                                   .toList(),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //       );
  //     });

  Widget veterinaryServicesWidget() => Expanded(
        child: Column(
          children: [
            Text(
              'Veterinary',
              style: GoogleFonts.itim(fontSize: 35),
            )
          ],
        ),
      );

  Widget groomingServicesWidget() => Expanded(
        child: Column(
          children: [
            Text(
              'Grooming',
              style: GoogleFonts.itim(fontSize: 35),
            )
          ],
        ),
      );

  Widget breedServicesWidget() => Expanded(
        child: Column(
          children: [
            Text(
              'Breeding',
              style: GoogleFonts.itim(fontSize: 35),
            )
          ],
        ),
      );

  Widget trainingServicesWidget() => Expanded(
        child: Column(
          children: [
            Text(
              'Training',
              style: GoogleFonts.itim(fontSize: 35),
            )
          ],
        ),
      );
}
