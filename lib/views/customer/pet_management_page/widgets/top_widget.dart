import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/action_page_controller.dart';
import 'package:petapp_mobile/controllers/pet_management_page_controller.dart';

class PetsManagementTopWidget extends GetView<PetManagementPageController> {
  const PetsManagementTopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 25),
        child: Column(
          children: [
            topTitleWidget(),
            petStatusWidget(),
            searchWidget(),
          ],
        ),
      );

  Widget searchWidget() => Container(
        height: 35,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 162, 176, 194),
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            InkWell(
              // onTap: () => controller.searchText.trim().isNotEmpty
              //     ? controller.update()
              //     : null,
              child: SvgPicture.asset(
                ICON_PATH + SEARCH_SVG,
                height: 20,
                color: const Color.fromARGB(255, 78, 98, 124),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: TextField(
                controller: controller.textEditingController,
                onChanged: (String text) {
                  controller
                    ..searchText.value = text
                    ..update();
                },
                keyboardType: TextInputType.multiline,
                cursorColor: PRIMARY_COLOR,
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 113, 135, 168),
                  fontSize: 15,
                ),
                decoration: InputDecoration.collapsed(
                  hintText: 'Search pets by name...',
                  hintStyle: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 162, 176, 194),
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Obx(
              () => Visibility(
                visible: controller.searchText.isNotEmpty,
                child: InkWell(
                  onTap: () => controller
                    ..searchText.value = ''
                    ..textEditingController.text = ''
                    ..update(),
                  child: CircleAvatar(
                    backgroundColor: RED_COLOR.withOpacity(0.9),
                    maxRadius: 10,
                    child: SvgPicture.asset(
                      ICON_PATH + CLOSE_SVG,
                      height: 10,
                      color: WHITE_COLOR,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget topTitleWidget() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            InkWell(
              onTap: () => Get
                ..back()
                ..put(ActionPageController()).update(),
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

  Widget petStatusItemWidget({required String petStatus, int flex = 1}) =>
      Expanded(
        flex: flex,
        child: Obx(
          () => InkWell(
            onTap: () {
              switch (petStatus) {
                case 'Normal':
                  controller.petStatus = 'NORMAL';
                  break;
                case 'In a post':
                  controller.petStatus = 'IN_POST';
                  break;
                default:
                  controller.petStatus = null;
              }
              controller
                ..selectedPetStatus.value = petStatus
                ..update();
            },
            child: Column(
              children: [
                Container(
                  height: 30,
                  color: controller.selectedPetStatus.value == petStatus
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
                              controller.selectedPetStatus.value == petStatus
                                  ? PRIMARY_COLOR
                                  : Colors.transparent,
                        ),
                      ),
                      Text(
                        petStatus,
                        style: GoogleFonts.quicksand(
                          color: controller.selectedPetStatus.value == petStatus
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
                  color: controller.selectedPetStatus.value == petStatus
                      ? PRIMARY_COLOR
                      : const Color.fromARGB(255, 233, 235, 241),
                ),
              ],
            ),
          ),
        ),
      );

  Widget petStatusWidget() => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: controller.postTypeList
              .asMap()
              .entries
              .map((e) => petStatusItemWidget(petStatus: e.value))
              .toList(),
        ),
      );
}
