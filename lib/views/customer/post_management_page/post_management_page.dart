import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/rounter.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/post_management_page_controller.dart';

class PostManagementPage extends GetView<PostManagementPageController> {
  const PostManagementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: controller.graphqlClient,
      child: Scaffold(
        backgroundColor: WHITE_COLOR,
        body: SafeArea(
          child: Column(
            children: [
              topWidget(),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 0,
                ),
                child: Text(
                  'Post Management',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.itim(
                    fontSize: 34,
                    color: PRIMARY_COLOR,
                    height: 2,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              searchWidget(),
              const SizedBox(
                height: 20,
              ),
              postTypeWidget(),
              postTableHeaderWidget(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Divider(
                  color: PRIMARY_COLOR,
                ),
              ),
              //Obx(
              // () =>
              // Expanded(
              //   child: Query(
              //     options: QueryOptions(
              //         document: gql(FETCH_TICKET_LIST_BY_PHONE_NUMBER),
              //         variables: {
              //           'phoneNumber': '+84901605667',
              //         }),
              //     builder: (
              //       QueryResult result, {
              //       VoidCallback? refetch,
              //       FetchMore? fetchMore,
              //     }) {
              //       if (result.hasException) {
              //         return Text(result.exception.toString());
              //       }
              //       if (result.isLoading) {
              //         return const Center(
              //           child: CircularProgressIndicator(),
              //         );
              //       }
              //       controller.postList =
              //           TicketServices.getTicketList(result.data!).obs;
              //       return SizedBox(
              //         height: 300,
              //         child: SingleChildScrollView(
              //           child: Column(
              //             children: controller.postList
              //                 .asMap()
              //                 .entries
              //                 .map(
              //                   (e) => ticketItemWidget(
              //                       ticketModel: e.value,
              //                       isLastIndex: e.key !=
              //                           controller.postList.length - 1),
              //                 )
              //                 .toList(),
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
              //),
              const SizedBox(
                height: 20,
              ),
              createPostButtonWidget(),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: MaterialButton(
                  height: 45,
                  color: PRIMARY_LIGHT_COLOR,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Management history',
                        style: GoogleFonts.quicksand(
                          color: PRIMARY_COLOR,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset(
                        ICON_PATH + HISTORY_SVG,
                        color: PRIMARY_COLOR,
                        height: 23,
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
              const SizedBox(
                height: 35,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ticketItemWidget({bool isLastIndex = false}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // InkWell(
          //   onTap: () => Get.to(() => TicketDetail(
          //         ticketModel: ticketModel,
          //       )),
          //   child: Row(
          //     children: [
          //       const SizedBox(
          //         width: 30,
          //       ),
          //       Expanded(
          //         flex: 3,
          //         child: Text(
          //           ticketModel.title,
          //           textAlign: TextAlign.start,
          //           maxLines: 1,
          //           overflow: TextOverflow.ellipsis,
          //           style: GoogleFonts.quicksand(
          //             fontSize: 16,
          //             color: LIGHT_GREY_COLOR,
          //             height: 1.2,
          //             fontWeight: FontWeight.w500,
          //           ),
          //         ),
          //       ),
          //       const SizedBox(
          //         width: 10,
          //       ),
          //       Expanded(
          //         flex: 3,
          //         child: Text(
          //           ticketModel.status,
          //           textAlign: TextAlign.start,
          //           style: GoogleFonts.quicksand(
          //             fontSize: 16,
          //             color: LIGHT_GREY_COLOR,
          //             height: 1.2,
          //             fontWeight: FontWeight.w500,
          //           ),
          //         ),
          //       ),
          //       Expanded(
          //         flex: 3,
          //         child: Text(
          //           FORMAT_DATE_TIME(
          //               dateTime: ticketModel.date, pattern: DATE_PATTERN),
          //           textAlign: TextAlign.start,
          //           style: GoogleFonts.quicksand(
          //             fontSize: 16,
          //             color: LIGHT_GREY_COLOR,
          //             height: 1.2,
          //             fontWeight: FontWeight.w500,
          //           ),
          //         ),
          //       ),
          //       const SizedBox(
          //         width: 30,
          //       ),
          //     ],
          //   ),
          // ),
          Visibility(
            visible: isLastIndex,
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 10,
              ),
              color: DARK_GREY_COLOR.withAlpha(50),
              height: 1,
            ),
          ),
        ],
      );

  Widget postTypeItemWidget({required String postType}) => Obx(
        () => InkWell(
          onTap: () {
            controller.selectedTicketType.value == postType
                ? null
                : controller.selectedTicketType.value = postType;
          },
          child: Container(
            height: 30,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: controller.selectedTicketType.value == postType
                  ? PRIMARY_COLOR
                  : WHITE_COLOR,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: controller.selectedTicketType.value == postType
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
              postType,
              style: GoogleFonts.itim(
                color: controller.selectedTicketType.value == postType
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

  Widget topWidget() => Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
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
            //!app logo
            Row(
              children: [
                SvgPicture.asset(
                  ICON_PATH + PET_LOGO_SVG,
                  color: PRIMARY_COLOR,
                  height: 29,
                ),
                const SizedBox(
                  width: 2,
                ),
                Text(
                  'iU Petshop',
                  style: GoogleFonts.satisfy(
                    textStyle: const TextStyle(color: PRIMARY_COLOR),
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                    height: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget searchWidget() => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: const EdgeInsets.only(bottom: 15),
          width: 300,
          height: 50,
          child: Material(
            elevation: 5,
            shadowColor: PRIMARY_COLOR,
            borderRadius: const BorderRadius.all(
              Radius.circular(25),
            ),
            child: TextField(
              onChanged: (value) {
                //searchItem = value;
              },
              decoration: InputDecoration(
                isCollapsed: true,
                prefixIcon: IconButton(
                  icon: const Icon(
                    Icons.search,
                    size: 20,
                  ),
                  onPressed: () {
                    //onTapSearch(searchItem: searchItem);
                  },
                  color: PRIMARY_COLOR,
                ),
                hintText: 'Search a post by title...',
                hintStyle: GoogleFonts.itim(
                  textStyle: const TextStyle(color: LIGHT_GREY_COLOR),
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                  borderSide: BorderSide(color: WHITE_COLOR),
                ),
              ),
            ),
          ),
        ),
      );

  Widget postTypeWidget() => SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: controller.postTypeList
              .asMap()
              .entries
              .map((e) => postTypeItemWidget(postType: e.value))
              .toList(),
        ),
      );

  Widget postTableHeaderWidget() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 30,
          ),
          Expanded(
            child: InkWell(
              onTap: () => controller.setHeaderFilter('Title'),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Title',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.itim(
                      fontSize: 18,
                      color: PRIMARY_COLOR,
                      height: 2,
                    ),
                  ),
                  Obx(
                    () => SvgPicture.asset(
                      controller.postManagementTableHeaders['Title'] == 2
                          ? ICON_PATH + TOPWARD_ARROW_SVG
                          : ICON_PATH + DOWNWARD_ARROW_SVG,
                      color: controller.postManagementTableHeaders['Title'] == 0
                          ? LIGHT_GREY_COLOR
                          : const Color.fromARGB(255, 244, 55, 165),
                      height: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: InkWell(
              onTap: () => controller.setHeaderFilter('Status'),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Status',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.itim(
                      fontSize: 18,
                      color: PRIMARY_COLOR,
                      height: 2,
                    ),
                  ),
                  Obx(
                    () => SvgPicture.asset(
                      controller.postManagementTableHeaders['Status'] == 2
                          ? ICON_PATH + TOPWARD_ARROW_SVG
                          : ICON_PATH + DOWNWARD_ARROW_SVG,
                      color:
                          controller.postManagementTableHeaders['Status'] == 0
                              ? LIGHT_GREY_COLOR
                              : const Color.fromARGB(255, 244, 55, 165),
                      height: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => controller.setHeaderFilter('Create time'),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Create time',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.itim(
                      fontSize: 18,
                      color: PRIMARY_COLOR,
                      height: 2,
                    ),
                  ),
                  Obx(
                    () => SvgPicture.asset(
                      controller.postManagementTableHeaders['Create time'] == 2
                          ? ICON_PATH + TOPWARD_ARROW_SVG
                          : ICON_PATH + DOWNWARD_ARROW_SVG,
                      color: controller
                                  .postManagementTableHeaders['Create time'] ==
                              0
                          ? LIGHT_GREY_COLOR
                          : const Color.fromARGB(255, 244, 55, 165),
                      height: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
        ],
      );

  Widget createPostButtonWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: MaterialButton(
          height: 45,
          color: PRIMARY_LIGHT_COLOR,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Create new post',
                style: GoogleFonts.quicksand(
                  color: PRIMARY_COLOR,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SvgPicture.asset(
                ICON_PATH + ADD_SVG,
                color: PRIMARY_COLOR,
                height: 23,
              ),
            ],
          ),
          onPressed: () => Get.toNamed(CREATE_POST_PAGE_ROUNTER),
        ),
      );

  Widget managementHistory() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: MaterialButton(
          height: 45,
          color: PRIMARY_LIGHT_COLOR,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Management history',
                style: GoogleFonts.quicksand(
                  color: PRIMARY_COLOR,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SvgPicture.asset(
                ICON_PATH + HISTORY_SVG,
                color: PRIMARY_COLOR,
                height: 23,
              ),
            ],
          ),
          onPressed: () {},
        ),
      );
}
