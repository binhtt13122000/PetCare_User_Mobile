import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 251, 255),
      body: Column(
        children: const [
          PostsManagementTopWidget(),
          Expanded(child: PostsManagementBodyWidget()),
          PostsManagementBottomWidget(),
        ],
      ),
    );
  }

  Widget ticketItemWidget({bool isLastIndex = false}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
