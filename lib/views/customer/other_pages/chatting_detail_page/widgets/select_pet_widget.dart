import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/other_controllers/chatting_detail_page_controller.dart';

class ChattingDetailSelectPetWidget
    extends GetView<ChattingDetailPageController> {
  const ChattingDetailSelectPetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Select a female pet for breeding',
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 78, 98, 124),
                    fontSize: 16,
                  ),
                ),
                Text(
                  '*',
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w800,
                    color: const Color.fromARGB(255, 241, 99, 88),
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            controller.pets.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: petItemWidget(),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      'No suitable pet!',
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w700,
                        color: const Color.fromARGB(255, 244, 55, 159),
                        fontSize: 16,
                      ),
                    ),
                  ),
          ],
        ),
      );

  Widget petItemWidget() => Obx(
        () => InkWell(
          onTap: () {
            controller.isShowPetDropdownList.value =
                !controller.isShowPetDropdownList.value;
          },
          child: Container(
            height: 50,
            width: 200,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(color: PRIMARY_COLOR),
                color: PRIMARY_LIGHT_COLOR.withOpacity(0.5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(9.8),
                  child: Image.network(
                    controller.pets[controller.selectedPetIndex.value].avatar,
                    height: 50,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Text(
                    controller.pets[controller.selectedPetIndex.value].name,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: PRIMARY_COLOR,
                      fontSize: 16,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  color: PRIMARY_COLOR,
                  size: 32,
                ),
              ],
            ),
          ),
        ),
      );
}
