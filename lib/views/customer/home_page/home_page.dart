import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/rounter.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/home_page_controller.dart';
import 'package:petapp_mobile/graphql/query_mutation/post.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';
import 'package:petapp_mobile/services/post_services/post_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/customer/custom_bottom_navigation_bar/custom_bottom_navigator_bar.dart';
import 'package:petapp_mobile/views/customer/home_page/widgets/pet_services_widget.dart';
import 'package:petapp_mobile/views/customer/home_page/widgets/top_navigation_bar.dart';
import 'package:petapp_mobile/views/customer/post_detail_page/post_detail_page.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: controller.graphqlClient,
      child: Scaffold(
        backgroundColor: WHITE_COLOR,
        extendBody: true,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  //!Top navigation
                  const SizedBox(
                    height: 135,
                    child: TopNavigationBar(),
                  ),
                  //!Pet services
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pet Services',
                          style: GoogleFonts.quicksand(
                            textStyle: const TextStyle(
                              color: Color.fromARGB(185, 32, 32, 32),
                            ),
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          'View All',
                          style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                              color: PRIMARY_COLOR.withOpacity(0.8),
                            ),
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const PetServiceWidget(),
                  //!Purchase Cart
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 5,
                      bottom: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Suggestions for You',
                          style: GoogleFonts.quicksand(
                            textStyle: const TextStyle(
                              color: Color.fromARGB(185, 32, 32, 32),
                            ),
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        InkWell(
                          onTap: () => Get.toNamed(PURCHASE_POSTS_PAGE_ROUNTER),
                          child: Text(
                            'View All',
                            style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                color: PRIMARY_COLOR.withOpacity(
                                  0.8,
                                ),
                              ),
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Obx(
                  //   () => Expanded(
                  //     child: Visibility(
                  //       visible: controller.selectedServiceIndex.value == 1,
                  //       child: Query(
                  //         options: QueryOptions(
                  //           document: gql(FETCH_PURCHASE_POST_LIST),
                  //           variables: {
                  //             "_ilike": "D%",
                  //           },
                  //         ),
                  //         builder: (
                  //           QueryResult result, {
                  //           VoidCallback? refetch,
                  //           FetchMore? fetchMore,
                  //         }) {
                  //           if (result.hasException) {
                  //             return Text(result.exception.toString());
                  //           }
                  //           if (result.isLoading) {
                  //             return const Center(
                  //               child: CircularProgressIndicator(),
                  //             );
                  //           }
                  //           controller.postList =
                  //               PostService.getPostList(result.data!);
                  //           return Column(
                  //             children: const [
                  //               Expanded(child: PurchasePostsWidget()),
                  //               SizedBox(
                  //                 height: 60,
                  //               ),
                  //             ],
                  //           );
                  //         },
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: Query(
                      options: QueryOptions(
                          document: gql(FETCH_ALL_PURCHASE_POST_LIST),
                          variables: {}),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 14),
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
                  Obx(
                    () => controller.selectedServiceIndex.value == 2
                        ? Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'Veterinary',
                                  style: GoogleFonts.itim(fontSize: 35),
                                )
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  Obx(
                    () => controller.selectedServiceIndex.value == 3
                        ? Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'Grooming',
                                  style: GoogleFonts.itim(fontSize: 35),
                                )
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  Obx(
                    () => controller.selectedServiceIndex.value == 4
                        ? Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'Breeding',
                                  style: GoogleFonts.itim(fontSize: 35),
                                )
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  Obx(
                    () => controller.selectedServiceIndex.value == 5
                        ? Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'Training',
                                  style: GoogleFonts.itim(fontSize: 35),
                                )
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                ],
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: CustomBottomNavigatorBar(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget purchasePostItemWidget({required PostModel postModel}) => InkWell(
        onTap: () {
          Get.to(() => PostDetaiPage(postModel: postModel));
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
                            image: NetworkImage(postModel.petModel!.avatar),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 5.5,
                      left: 6.5,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          postModel.petModel!.breedModel.name,
                          style: GoogleFonts.satisfy(
                            color: PRIMARY_COLOR.withOpacity(0.8),
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 5,
                      left: 5,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(71, 123, 6, 212),
                          borderRadius: BorderRadius.all(
                            Radius.elliptical(15, 10),
                          ),
                        ),
                        child: Text(
                          postModel.petModel!.breedModel.name,
                          style: GoogleFonts.satisfy(
                            color: WHITE_COLOR,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    //*Time Created
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                ICON_PATH + CLOCK_SVG,
                                height: 11,
                                color: WHITE_COLOR,
                              ),
                              const SizedBox(
                                width: 3.5,
                              ),
                              Text(
                                FORMAT_DATE_TIME(
                                    dateTime: postModel.createTime!,
                                    pattern: TIME_PATTERN),
                                style: GoogleFonts.quicksand(
                                  color: WHITE_COLOR,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            FORMAT_DATE_TIME(
                                dateTime: postModel.createTime!,
                                pattern: DATE_PATTERN),
                            style: GoogleFonts.quicksand(
                              color: WHITE_COLOR,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 5, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      postModel.title!,
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
                    RichText(
                      text: TextSpan(
                        text: 'Price: ',
                        style: GoogleFonts.quicksand(
                          color: DARK_GREY_COLOR.withOpacity(0.8),
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: FORMAT_MONEY(price: postModel.price!),
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.w700,
                              color: PRIMARY_COLOR,
                              fontSize: 17,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Wrap(
                      spacing: 8,
                      children: [
                        SizedBox(
                          height: 25,
                          width: 70,
                          child: Material(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(25),
                            ),
                            color: postModel.petModel!.gender == 'MALE'
                                ? const Color.fromARGB(255, 225, 233, 248)
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
                                  color: postModel.petModel!.gender == 'MALE'
                                      ? const Color.fromARGB(255, 39, 111, 245)
                                      : const Color.fromARGB(255, 244, 55, 165),
                                  height: 12,
                                ),
                                Text(
                                  postModel.petModel!.gender,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.quicksand(
                                    fontSize: 12,
                                    color: postModel.petModel!.gender == 'MALE'
                                        ? const Color.fromARGB(
                                            255, 39, 111, 245)
                                        : const Color.fromARGB(
                                            255, 244, 55, 165),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 25,
                          width: 70,
                          decoration: BoxDecoration(
                            color: DARK_GREY_COLOR.withOpacity(0.13),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          child: Text(
                            postModel.petModel!.ageRange.toString() + ' Month',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.quicksand(
                              fontSize: 12,
                              color: DARK_GREY_COLOR.withOpacity(0.7),
                              height: 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
