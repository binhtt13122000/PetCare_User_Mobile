import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/post_management_page_controller.dart';
import 'package:petapp_mobile/views/customer/post_management_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/post_management_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/post_management_page/widgets/top_widget.dart';

class PostManagementPage extends GetView<PostManagementPageController> {
  const PostManagementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: controller.graphqlClient,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 250, 251, 255),
        body: Column(
          children: const [
            PostsManagementTopWidget(),
            Expanded(child: PostsManagementBodyWidget()),
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

            PostsManagementBottomWidget(),
          ],
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
