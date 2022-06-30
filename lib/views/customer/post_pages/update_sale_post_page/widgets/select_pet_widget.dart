import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/update_sale_post_page_controller.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';
import 'package:petapp_mobile/services/pet_services/pet_services.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class SelectPetWidget extends GetView<UpdateSalePostPageController> {
  const SelectPetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdateSalePostPageController>(builder: (_) {
      controller.isShowLoadingPet.value = true;

      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        controller.pets = await PetService.fetchPetListToCreatePost(
            customerId: controller.accountModel.customerModel.id,
            speciesId: controller.isShowPetFilter.value
                ? controller.selectedSpeciesId
                : null,
            type: controller.postModel.type);

        controller.selectedPetId.value =
            controller.pets.isNotEmpty ? controller.pets[0].id : -1;

        controller.isShowLoadingPet.value = false;
      });
      return Obx(() => controller.isShowLoadingPet.value
          ? LOADING_WIDGET(size: 40)
          : Column(
              children: [
                Container(
                  height: 1,
                  margin: const EdgeInsets.only(top: 10),
                  color: LIGHT_GREY_COLOR.withOpacity(0.1),
                ),
                Container(
                  height: 8,
                  color: const Color.fromARGB(255, 247, 248, 250),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 20),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Select pet',
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
                            controller.pets.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: petItemWidget(
                                      petModel: controller.pets.firstWhere(
                                          (element) =>
                                              element.id ==
                                              controller.selectedPetId.value),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      'No suitable pet!',
                                      style: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.w700,
                                        color: const Color.fromARGB(
                                            255, 244, 55, 159),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ],
                    ),
                    controller.pets.isNotEmpty
                        ? petItemDropdownListWidget()
                        : const SizedBox.shrink()
                  ]),
                ),
              ],
            ));
    });
  }

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

    return Visibility(
      visible: controller.isShowPetDropdownList.value,
      child: Stack(
        children: [
          Positioned(
            right: 15,
            top: 6,
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
            margin: const EdgeInsets.only(left: 18, top: 10),
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
                              petModel: e.value,
                              isLastIndex: e.key == controller.pets.length - 1),
                        )
                        .toList()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget petItemWidget({required PetModel petModel}) =>
      GetBuilder<UpdateSalePostPageController>(
        builder: (_) => InkWell(
          onTap: () {
            controller.isShowPetDropdownList.value =
                !controller.isShowPetDropdownList.value;
          },
          child: Container(
            height: 50,
            width: 170,
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
                    petModel.avatar,
                    height: 50,
                    width: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (_, object, stackTrace) => Image.asset(
                      IMAGE_PATH + NO_IMAGE_PNG,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    petModel.name,
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

  Widget petItemInDropdownListWidget(
          {required PetModel petModel, required bool isLastIndex}) =>
      Column(
        children: [
          InkWell(
            onTap: () {
              controller.isShowPetDropdownList.value =
                  !controller.isShowPetDropdownList.value;
              controller.selectedPetId.value = petModel.id;
              controller.update();
            },
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
                            color: controller.selectedPetId.value == petModel.id
                                ? PRIMARY_COLOR
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            petModel.avatar,
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
                    child: Text(
                      petModel.name,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w500,
                        color: controller.selectedPetId.value == petModel.id
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
          !isLastIndex
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

  Widget transactionLocationWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: SvgPicture.asset(
                      ICON_PATH + LOCATION_SVG,
                      height: 20,
                      color: const Color.fromARGB(255, 61, 78, 100),
                    ),
                  ),
                  Text(
                    'Transaction location',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 61, 78, 100),
                      fontSize: 16,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    '*',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w800,
                      color: const Color.fromARGB(255, 241, 99, 88),
                      fontSize: 20,
                      height: 0.8,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Container(
        //   height: 100,
        //   alignment: Alignment.topLeft,
        //   margin: const EdgeInsets.only(top: 8),
        //   padding: const EdgeInsets.all(10),
        //   decoration: BoxDecoration(
        //     border: Border.all(
        //       color: const Color.fromARGB(255, 167, 181, 201),
        //       width: 1.2,
        //     ),
        //     borderRadius: BorderRadius.circular(5),
        //   ),
        //   child: Column(
        //     children: [
        //       Row(
        //         children: [
        //           Obx(
        //             () => Container(
        //               width: 20,
        //               height: 20,
        //               margin: const EdgeInsets.only(right: 5),
        //               child: Checkbox(
        //                 value: controller.isUseOwnerAddress.value,
        //                 onChanged: (isCheck) {
        //                   controller.isUseOwnerAddress.value = isCheck!;
        //                   if (isCheck) {
        //                     controller.transactionLocationTextEditingController
        //                         .text = ownerAddress;
        //                     controller.transactionLocation.value = ownerAddress;
        //                   }
        //                 },
        //                 activeColor: PRIMARY_COLOR,
        //               ),
        //             ),
        //           ),
        //           Text(
        //             'Use owner address',
        //             style: GoogleFonts.quicksand(
        //               fontWeight: FontWeight.w500,
        //               color: const Color.fromARGB(255, 85, 103, 128),
        //               fontSize: 13,
        //               letterSpacing: 1,
        //             ),
        //           ),
        //         ],
        //       ),
        //       Row(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Expanded(
        //             child: TextFormField(
        //               minLines: 3,
        //               maxLines: 3,
        //               maxLength: 40,
        //               controller:
        //                   controller.transactionLocationTextEditingController,
        //               onChanged: (String text) {
        //                 controller.transactionLocation.value = text;
        //               },
        //               keyboardType: TextInputType.multiline,
        //               cursorColor: PRIMARY_COLOR,
        //               style: GoogleFonts.quicksand(
        //                 fontWeight: FontWeight.w500,
        //                 color: const Color.fromARGB(255, 113, 135, 168),
        //                 fontSize: 15,
        //                 letterSpacing: 1,
        //               ),
        //               decoration: InputDecoration(
        //                 hintText: 'Type transaction location here...',
        //                 hintStyle: GoogleFonts.quicksand(
        //                   fontWeight: FontWeight.w500,
        //                   color: const Color.fromARGB(255, 162, 176, 194),
        //                   fontSize: 13,
        //                   letterSpacing: 1,
        //                 ),
        //                 border: InputBorder.none,
        //                 counterText: '',
        //                 isCollapsed: true,
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
