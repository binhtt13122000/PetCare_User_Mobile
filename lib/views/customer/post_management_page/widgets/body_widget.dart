import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/controllers/post_management_page_controller.dart';
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                postCardWidget(),
                postCardDarkThemeWidget(),
                postCardWidget(),
                postCardDarkThemeWidget(),
                postCardWidget(),
                postCardDarkThemeWidget(),
                postCardWidget(),
                postCardDarkThemeWidget(),
              ],
            ),
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
                width: 60,
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
                    const Icon(
                      Icons.info_outline_rounded,
                      size: 13,
                      color: Color.fromARGB(255, 102, 119, 141),
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

  Widget postCardWidget() => Container(
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
                  'https://firebasestorage.googleapis.com/v0/b/petapp-851bc.appspot.com/o/ef132efc-94d5-4bf2-ab83-e958cb9337ac-75cc47690215d4a2bd8b5c9c58f89244.jpg?alt=media&token=ef132efc-94d5-4bf2-ab83-e958cb9337ac',
                  fit: BoxFit.cover,
                  width: 50,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 0),
                child: Text(
                  'The British Shorthair is the pedigreed version of the traditional British domestic cat, with a distinctively stocky body, dense coat, and broad face.',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.quicksand(
                    color: const Color.fromARGB(255, 64, 69, 87),
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            Container(
              width: 60,
              alignment: Alignment.center,
              child: SvgPicture.asset(
                ICON_PATH + PLANET_EARTH_SVG,
                height: 23,
                color: const Color.fromARGB(255, 79, 112, 128),
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
                        dateTime: DateTime.now(), pattern: DATE_PATTERN),
                    style: GoogleFonts.quicksand(
                      color: const Color.fromARGB(255, 64, 69, 87),
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    FORMAT_DATE_TIME(
                        dateTime: DateTime.now(), pattern: TIME_PATTERN),
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
      );

  Widget postCardDarkThemeWidget() => Column(
        children: [
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(vertical: 3),
            color: const Color.fromARGB(255, 240, 243, 255),
          ),
          Container(
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
                      'https://firebasestorage.googleapis.com/v0/b/petapp-851bc.appspot.com/o/ef132efc-94d5-4bf2-ab83-e958cb9337ac-75cc47690215d4a2bd8b5c9c58f89244.jpg?alt=media&token=ef132efc-94d5-4bf2-ab83-e958cb9337ac',
                      fit: BoxFit.cover,
                      width: 50,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: Text(
                      'The British Shorthair is the pedigreed version of the traditional British domestic cat, with a distinctively stocky body, dense coat, and broad face.',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.quicksand(
                        color: const Color.fromARGB(255, 64, 69, 87),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 60,
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    ICON_PATH + PLANET_EARTH_SVG,
                    height: 23,
                    color: const Color.fromARGB(255, 79, 112, 128),
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
                            dateTime: DateTime.now(), pattern: DATE_PATTERN),
                        style: GoogleFonts.quicksand(
                          color: const Color.fromARGB(255, 64, 69, 87),
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        FORMAT_DATE_TIME(
                            dateTime: DateTime.now(), pattern: TIME_PATTERN),
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
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(vertical: 3),
            color: const Color.fromARGB(255, 240, 243, 255),
          ),
        ],
      );
}
