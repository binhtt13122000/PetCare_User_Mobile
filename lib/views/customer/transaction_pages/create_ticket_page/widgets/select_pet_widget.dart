import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/create_ticket_page_controller.dart';

class CreateTicketSelectPetWidget extends GetView<CreateTicketPageController> {
  const CreateTicketSelectPetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => petItemDropdownListWidget();

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
      case 3:
        dropDownHeight = 160;
        break;
      case 4:
        dropDownHeight = 206;
        break;
      case 5:
        dropDownHeight = 260;
        break;
      default:
        dropDownHeight = 260;
    }

    return InkWell(
      onTap: () => controller.isShowPetList.value = false,
      child: Container(
        color: DARK_GREY_TRANSPARENT,
        alignment: Alignment.center,
        child: Stack(
          children: [
            Positioned(
              // right: 65,
              // top: 16,
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(45 / 360),
                child: Container(
                  height: 10,
                  width: 10,
                  color: const Color.fromARGB(255, 179, 187, 202),
                ),
              ),
            ),
            Container(
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
                            (e) => petItemInDropdownListWidget(
                              index: e.key,
                            ),
                          )
                          .toList()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget petItemInDropdownListWidget({required int index}) => Column(
        children: [
          InkWell(
            onTap: () {
              if (!controller.selectPetIndexList.contains(index)) {
                controller
                  ..selectPetIndexList.add(index)
                  ..selectServicesMap.addAll({
                    index: <int>[].obs,
                  })
                  ..selectShowMorePetList.add(index)
                  ..isShowPetList.value = false;
              }
            },
            child: Container(
              height: 50,
              width: 300,
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
                            color: controller.selectPetIndexList.contains(index)
                                ? PRIMARY_COLOR
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            controller.pets[index].avatar,
                            height: 45,
                            width: 77.5,
                            fit: BoxFit.cover,
                            errorBuilder: (_, object, stackTrace) =>
                                Image.asset(
                              IMAGE_PATH + NO_IMAGE_PNG,
                              fit: BoxFit.cover,
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          controller.pets[index].name +
                              ' (' +
                              controller.pets[index].breedModel!.name +
                              ' - ' +
                              controller
                                  .pets[index].breedModel!.speciesModel!.name +
                              ')',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.w500,
                            color: controller.selectPetIndexList.contains(index)
                                ? PRIMARY_COLOR
                                : const Color.fromARGB(255, 121, 128, 141),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          index != controller.pets.length
              ? Container(
                  height: 4,
                  width: 300,
                  color: const Color.fromARGB(255, 247, 248, 250),
                  alignment: Alignment.center,
                  child: Container(
                    height: 1,
                    width: 280,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 179, 187, 202),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      );
}
