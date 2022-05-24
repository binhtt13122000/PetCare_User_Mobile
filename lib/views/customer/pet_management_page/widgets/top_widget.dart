import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_management_page_controller.dart';

class PetsManagementTopWidget extends GetView<PetManagementPageController> {
  const PetsManagementTopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 25),
        child: Column(
          children: [
            topTitleWidget(),
            postTypeWidget(),
            searchWidget(),
          ],
        ),
      );

  Widget searchWidget() => Container(
        height: 35,
        margin: const EdgeInsets.only(top: 20),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                cursorColor: PRIMARY_COLOR,
                maxLength: 50,
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 138, 154, 175),
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  counterText: '',
                  prefixIcon: Align(
                    heightFactor: 1,
                    widthFactor: 1,
                    child: SvgPicture.asset(
                      ICON_PATH + SEARCH_SVG,
                      height: 20,
                      color: const Color.fromARGB(255, 78, 98, 124),
                    ),
                  ),
                  suffixIcon: Align(
                    heightFactor: 1,
                    widthFactor: 1,
                    child: Text(
                      '12/20',
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 78, 98, 124),
                        fontSize: 13,
                      ),
                    ),
                  ),
                  border: const OutlineInputBorder(),
                  hintText: 'Search pets by breed...',
                  hintStyle: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 125, 141, 161),
                    fontSize: 13,
                  ),
                ),
                onChanged: (String? value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 12,
              ),
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: 35,
                  width: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 192, 195, 207),
                    ),
                    borderRadius: BorderRadius.circular(3),
                    color: const Color.fromARGB(255, 243, 243, 243),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Text(
                      //   '',
                      //   style: GoogleFonts.quicksand(
                      //     color: const Color.fromARGB(255, 64, 69, 87),
                      //     fontSize: 13,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                      SvgPicture.asset(
                        ICON_PATH + FILTER_SVG,
                        height: 16,
                        color: const Color.fromARGB(255, 64, 69, 87),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  //  Widget searchWidget() => Align(
  //   alignment: Alignment.bottomCenter,
  //   child: Container(
  //     padding: const EdgeInsets.only(bottom: 15),
  //     width: 300,
  //     height: 50,
  //     child: Material(
  //       elevation: 5,
  //       shadowColor: PRIMARY_COLOR,
  //       borderRadius: const BorderRadius.all(
  //         Radius.circular(25),
  //       ),
  //       child: TextField(
  //         onChanged: (value) {
  //           //searchItem = value;
  //         },
  //         decoration: InputDecoration(
  //           isCollapsed: true,
  //           prefixIcon: IconButton(
  //             icon: const Icon(
  //               Icons.search,
  //               size: 20,
  //             ),
  //             onPressed: () {
  //               //onTapSearch(searchItem: searchItem);
  //             },
  //             color: PRIMARY_COLOR,
  //           ),
  //           hintText: 'Search a post by title...',
  //           hintStyle: GoogleFonts.itim(
  //             textStyle: const TextStyle(color: LIGHT_GREY_COLOR),
  //             fontWeight: FontWeight.w400,
  //             fontSize: 15,
  //             fontStyle: FontStyle.italic,
  //           ),
  //           fillColor: Colors.white,
  //           filled: true,
  //           contentPadding:
  //               const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
  //           enabledBorder: const OutlineInputBorder(
  //             borderRadius: BorderRadius.all(
  //               Radius.circular(25),
  //             ),
  //             borderSide: BorderSide(color: WHITE_COLOR),
  //           ),
  //         ),
  //       ),
  //     ),
  //   ),
  // );

  Widget topTitleWidget() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            InkWell(
              onTap: () => Get.back(),
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: WHITE_COLOR,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: DARK_GREY_COLOR.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Color.fromARGB(255, 61, 78, 100),
                  size: 18,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 35),
                child: Text(
                  'Pets Management',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                    color: const Color.fromARGB(255, 62, 68, 87),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget postTypeItemWidget({required String postType, int flex = 1}) =>
      Expanded(
        flex: flex,
        child: Obx(
          () => InkWell(
            onTap: () {
              controller.selectedTicketType.value == postType
                  ? null
                  : controller.selectedTicketType.value = postType;
            },
            child: Column(
              children: [
                Container(
                  height: 30,
                  color: controller.selectedTicketType.value == postType
                      ? PRIMARY_LIGHT_COLOR.withOpacity(0.3)
                      : Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          maxRadius: 3,
                          backgroundColor:
                              controller.selectedTicketType.value == postType
                                  ? PRIMARY_COLOR
                                  : Colors.transparent,
                        ),
                      ),
                      Text(
                        postType,
                        style: GoogleFonts.quicksand(
                          color: controller.selectedTicketType.value == postType
                              ? PRIMARY_COLOR
                              : const Color.fromARGB(255, 116, 122, 143),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 3,
                  color: controller.selectedTicketType.value == postType
                      ? PRIMARY_COLOR
                      : const Color.fromARGB(255, 233, 235, 241),
                ),
              ],
            ),
          ),
        ),
      );

  Widget postTypeWidget() => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: controller.postTypeList
              .asMap()
              .entries
              .map((e) => postTypeItemWidget(postType: e.value))
              .toList(),
        ),
      );
}
