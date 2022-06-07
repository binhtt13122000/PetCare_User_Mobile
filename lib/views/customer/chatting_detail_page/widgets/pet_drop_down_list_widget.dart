import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/chatting_detail_page_controller.dart';

class ChattingDetailPetDropdownListWidget
    extends GetView<ChattingDetailPageController> {
  const ChattingDetailPetDropdownListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Obx(
        () => controller.isShowPetDropdownList.value
            ? petItemDropdownListWidget()
            : const SizedBox.shrink(),
      );

  Widget petItemDropdownListWidget() {
    ScrollController scrollController = ScrollController();
    late double dropDownHeight;

    switch (controller.pets.length) {
      case 1:
        dropDownHeight = 52;
        break;
      case 2:
        dropDownHeight = 106;
        break;
      default:
        dropDownHeight = 160;
    }

    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 60),
        height: dropDownHeight,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 179, 187, 202),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: RawScrollbar(
          controller: scrollController,
          isAlwaysShown: true,
          thumbColor: PRIMARY_COLOR.withOpacity(0.7),
          thickness: 2.5,
          radius: const Radius.circular(5),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
                children: controller.pets
                    .asMap()
                    .entries
                    .map(
                      (e) => petItemInDropdownListWidget(petIndex: e.key),
                    )
                    .toList()),
          ),
        ),
      ),
    );
  }

  Widget petItemInDropdownListWidget({required int petIndex}) => Column(
        children: [
          InkWell(
            onTap: () => controller
              ..isShowPetDropdownList.value = false
              ..selectedPetIndex.value = petIndex,
            child: Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 247, 248, 250),
                borderRadius: BorderRadius.circular(9.8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 20,
                        height: 45,
                        decoration: BoxDecoration(
                            color: controller.selectedPetIndex.value == petIndex
                                ? PRIMARY_COLOR
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            controller.pets[petIndex].avatar,
                            height: 45,
                            width: 77.5,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Text(
                      controller.pets[petIndex].name,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w500,
                        color: controller.selectedPetIndex.value == petIndex
                            ? PRIMARY_COLOR
                            : const Color.fromARGB(255, 121, 128, 141),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          !(petIndex != controller.pets.length - 1)
              ? Container(
                  height: 4,
                  width: 200,
                  color: const Color.fromARGB(255, 247, 248, 250),
                  alignment: Alignment.center,
                  child: Container(
                    height: 1,
                    width: 190,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 179, 187, 202),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      );
}
