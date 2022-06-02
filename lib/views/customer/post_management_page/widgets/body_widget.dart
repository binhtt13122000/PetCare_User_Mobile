import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/post_management_page_controller.dart';
import 'package:petapp_mobile/graphql/graphql_config.dart';
import 'package:petapp_mobile/graphql/query_mutation/post.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';
import 'package:petapp_mobile/services/post_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';

class PostsManagementBodyWidget extends GetView<PostManagementPageController> {
  const PostsManagementBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        postTableHeaderWidget(),
        Container(
          height: 1.5,
          margin:
              const EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 10),
          color: const Color.fromARGB(255, 217, 222, 241),
        ),
        Expanded(
          child: GetBuilder<PostManagementPageController>(
            builder: (_) {
              controller.isLoadingPostList.value = true;
              WidgetsBinding.instance!.addPostFrameCallback((_) async {
                  controller.postList = await PostService.fetchAllPurchasePostListByCustomerId(
                    customerId: controller.accountModel.customerModel.id,
                    limit: 10,
                    page: 1,
                  );
                  controller.isLoadingPostList.value = false;
              });
              return Obx(
                () => controller.isLoadingPostList.value
                    ? Container(
                        color: const Color.fromARGB(106, 198, 188, 201),
                        alignment: Alignment.center,
                        child: const SpinKitSpinningLines(
                          color: PRIMARY_COLOR,
                          size: 150,
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                        children: controller.postList
                            .asMap()
                            .entries
                            .map((e) => e.key.isEven
                                ? postCardWidget(postModel: e.value)
                                : postCardDarkThemeWidget(postModel: e.value))
                            .toList(),
                      )),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget postTableHeaderWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SizedBox(
                width: 50,
                child: Text(
                  'Image',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                      fontSize: 12,
                      color: const Color.fromARGB(255, 83, 89, 110),
                      height: 2,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => controller.setHeaderFilter('Title'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                        'Post title',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.quicksand(
                          fontSize: 12,
                          color: const Color.fromARGB(255, 83, 89, 110),
                          height: 2,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    Obx(
                      () => SvgPicture.asset(
                        controller.postManagementTableHeaders['Title'] == 2
                            ? ICON_PATH + TOPWARD_ARROW_SVG
                            : ICON_PATH + DOWNWARD_ARROW_SVG,
                        color:
                            controller.postManagementTableHeaders['Title'] == 0
                                ? const Color.fromARGB(255, 116, 125, 158)
                                : const Color.fromARGB(255, 244, 55, 165),
                        height: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => controller.setHeaderFilter('Status'),
              child: Container(
                width: 70,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 3),
                      child: Text(
                        'Status',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.quicksand(
                            fontSize: 12,
                            color: const Color.fromARGB(255, 83, 89, 110),
                            height: 2,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Obx(
                      () => SvgPicture.asset(
                        controller.postManagementTableHeaders['Title'] == 2
                            ? ICON_PATH + TOPWARD_ARROW_SVG
                            : ICON_PATH + DOWNWARD_ARROW_SVG,
                        color:
                            controller.postManagementTableHeaders['Title'] == 0
                                ? const Color.fromARGB(255, 116, 125, 158)
                                : const Color.fromARGB(255, 244, 55, 165),
                        height: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => controller.setHeaderFilter('Create time'),
              child: SizedBox(
                width: 85,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 3),
                      child: Text(
                        'Created',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.quicksand(
                          fontSize: 12,
                          color: const Color.fromARGB(255, 83, 89, 110),
                          height: 2,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    Obx(
                      () => SvgPicture.asset(
                        controller.postManagementTableHeaders['Create time'] ==
                                2
                            ? ICON_PATH + TOPWARD_ARROW_SVG
                            : ICON_PATH + DOWNWARD_ARROW_SVG,
                        color: controller.postManagementTableHeaders[
                                    'Create time'] ==
                                0
                            ? const Color.fromARGB(255, 116, 125, 158)
                            : const Color.fromARGB(255, 244, 55, 165),
                        height: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget postCardWidget({required PostModel postModel}) => InkWell(
        onTap: () =>
            Get.toNamed('$SALE_POST_DETAIL_PAGE_ROUTE/${postModel.id}'),
        child: Container(
          height: 70,
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: const BoxDecoration(),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: Image.network(
                    postModel.mediaModels![0].url,
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        postModel.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                          color: const Color.fromARGB(255, 64, 69, 87),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '[${postModel.type}]',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                          color: postModel.type == 'SALE'
                              ? BLUE_COLOR
                              : PINK_COLOR,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 70,
                alignment: Alignment.center,
                child: Text(
                  postModel.status,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                    color: () {
                      switch (postModel.status) {
                        case 'REQUESTED':
                          return const Color.fromARGB(255, 248, 204, 60);
                        case 'PUBLISHED':
                          return const Color.fromARGB(255, 68, 204, 214);
                        default:
                          return const Color.fromARGB(255, 68, 204, 214);
                      }
                    }.call(),
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(
                width: 85,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      FORMAT_DATE_TIME(
                          dateTime: postModel.createTime,
                          pattern: DATE_PATTERN),
                      style: GoogleFonts.quicksand(
                        color: const Color.fromARGB(255, 64, 69, 87),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      FORMAT_DATE_TIME(
                          dateTime: postModel.createTime,
                          pattern: TIME_PATTERN),
                      style: GoogleFonts.quicksand(
                        color: const Color.fromARGB(255, 64, 69, 87),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget postCardDarkThemeWidget({required PostModel postModel}) => Column(
        children: [
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(vertical: 3),
            color: const Color.fromARGB(255, 240, 243, 255),
          ),
          InkWell(
            onTap: () =>
                Get.toNamed('$SALE_POST_DETAIL_PAGE_ROUTE/${postModel.id}'),
            child: Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 241, 243, 250),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: Image.network(
                        postModel.mediaModels![0].url,
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              postModel.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.quicksand(
                                color: const Color.fromARGB(255, 64, 69, 87),
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '[${postModel.type}]',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.quicksand(
                                color: postModel.type == 'SALE'
                                    ? BLUE_COLOR
                                    : PINK_COLOR,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )),
                  ),
                  Container(
                    width: 70,
                    alignment: Alignment.center,
                    child: Text(
                      postModel.status,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(
                        color: () {
                          switch (postModel.status) {
                            case 'REQUESTED':
                              return const Color.fromARGB(255, 248, 204, 60);
                            case 'PUBLISHED':
                              return const Color.fromARGB(255, 68, 204, 214);
                            default:
                              return const Color.fromARGB(255, 68, 204, 214);
                          }
                        }.call(),
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 85,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          FORMAT_DATE_TIME(
                              dateTime: postModel.createTime,
                              pattern: DATE_PATTERN),
                          style: GoogleFonts.quicksand(
                            color: const Color.fromARGB(255, 64, 69, 87),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          FORMAT_DATE_TIME(
                              dateTime: postModel.createTime,
                              pattern: TIME_PATTERN),
                          style: GoogleFonts.quicksand(
                            color: const Color.fromARGB(255, 64, 69, 87),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(vertical: 3),
            color: const Color.fromARGB(255, 240, 243, 255),
          ),
        ],
      );
}
