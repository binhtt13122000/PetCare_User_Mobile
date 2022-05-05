import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/controllers/post_management_page_controller.dart';

class PostsManagementBottomWidget
    extends GetView<PostManagementPageController> {
  const PostsManagementBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          createPostButtonWidget(),
          managementHistoryButtonWidget(),
        ],
      );

  Widget createPostButtonWidget() => Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 192, 195, 207),
            ),
            borderRadius: BorderRadius.circular(3),
            color: const Color.fromARGB(255, 243, 243, 243),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Create New Post',
                style: GoogleFonts.quicksand(
                  color: const Color.fromARGB(255, 64, 69, 87),
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SvgPicture.asset(
                ICON_PATH + ADD_SVG,
                color: const Color.fromARGB(255, 64, 69, 87),
                height: 18,
              ),
            ],
          ),
        ),
      );

  Widget managementHistoryButtonWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 192, 195, 207),
            ),
            borderRadius: BorderRadius.circular(3),
            color: const Color.fromARGB(255, 243, 243, 243),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Management History',
                style: GoogleFonts.quicksand(
                  color: const Color.fromARGB(255, 64, 69, 87),
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.1,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SvgPicture.asset(
                ICON_PATH + HISTORY_SVG,
                color: const Color.fromARGB(255, 64, 69, 87),
                height: 18,
              ),
            ],
          ),
        ),
      );
}
