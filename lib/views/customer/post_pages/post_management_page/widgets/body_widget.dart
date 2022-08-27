import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/post_management_page_controller.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';
import 'package:petapp_mobile/services/post_services/post_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
                controller
                  ..postList = await PostService.fetchPostListByCustomerId(
                      customerId: controller.accountModel.customerModel.id,
                      jwt: controller.accountModel.jwtToken,
                      limit: 99,
                      page: 1,
                      title: controller.searchText.value,
                      type: controller.selectPostType.value == 'All type'
                          ? null
                          : controller.selectPostType.value.toUpperCase())
                  ..isLoadingPostList.value = false;
              });
              return Obx(
                () => controller.isLoadingPostList.value
                    ? LOADING_WIDGET()
                    : SmartRefresher(
                        controller: RefreshController(),
                        onRefresh: () => controller.update(),
                        child: controller.postList.isEmpty
                            ? NO_DATA_WIDGET(
                                content: 'Sorry, no post data found.')
                            : SingleChildScrollView(
                                child: Column(
                                  children: controller.postList
                                      .asMap()
                                      .entries
                                      .map((e) => e.key.isEven
                                          ? postCardWidget(postModel: e.value)
                                          : postCardDarkThemeWidget(
                                              postModel: e.value))
                                      .toList(),
                                ),
                              ),
                      ),
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
                      fontSize: 13,
                      color: const Color.fromARGB(255, 83, 89, 110),
                      height: 2,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Expanded(
              child: Text(
                'Post title',
                textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(
                  fontSize: 13,
                  color: const Color.fromARGB(255, 83, 89, 110),
                  height: 2,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ),
            Container(
              width: 70,
              alignment: Alignment.center,
              child: Text(
                'Status',
                textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(
                    fontSize: 13,
                    color: const Color.fromARGB(255, 83, 89, 110),
                    height: 2,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              width: 85,
              child: Text(
                'Created',
                textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(
                  fontSize: 13,
                  color: const Color.fromARGB(255, 83, 89, 110),
                  height: 2,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      );

  Widget postCardWidget({required PostModel postModel}) => InkWell(
        onTap: () => Get.toNamed('$POST_DETAIL_PAGE_ROUTE/${postModel.id}'),
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
                    errorBuilder: (_, object, stackTrace) => Image.asset(
                      IMAGE_PATH + NO_IMAGE_PNG,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
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
              statusWidget(status: postModel.status),
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

  Widget statusWidget({required String status}) {
    late Color color;
    late String statusText;

    switch (status) {
      case 'REQUESTED':
        color = YELLOW_COLOR.withOpacity(0.8);
        statusText = 'Waiting for approved';
        break;
      case 'REJECTED':
        color = RED_COLOR;
        statusText = 'Rejected';
        break;
      case 'PUBLISHED':
        color = GREEN_COLOR;
        statusText = 'Published for anyone';
        break;
      case 'CLOSED':
        color = DARK_GREY_TEXT_COLOR.withOpacity(0.7);
        statusText = 'Closed';
        break;
      case 'WAITING_FOR_PAYMENT':
        color = YELLOW_COLOR;
        statusText = 'Waiting for buyer payment';
        break;
      case 'CANCELED':
        color = RED_COLOR;
        statusText = 'Canceled';
        break;
      default:
        color = YELLOW_COLOR;
        statusText = status;
    }
    return Container(
      width: 70,
      alignment: Alignment.center,
      child: Text(
        statusText,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: GoogleFonts.quicksand(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget postCardDarkThemeWidget({required PostModel postModel}) => Column(
        children: [
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(vertical: 3),
            color: const Color.fromARGB(255, 240, 243, 255),
          ),
          InkWell(
            onTap: () => Get.toNamed('$POST_DETAIL_PAGE_ROUTE/${postModel.id}'),
            child: Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 244, 246, 253),
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
                        errorBuilder: (_, object, stackTrace) => Image.asset(
                          IMAGE_PATH + NO_IMAGE_PNG,
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        ),
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
                  statusWidget(status: postModel.status),
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
