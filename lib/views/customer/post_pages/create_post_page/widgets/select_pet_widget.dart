import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/create_post_page_controller.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';
import 'package:petapp_mobile/models/species_model/species_model.dart';
import 'package:petapp_mobile/services/pet_services/pet_services.dart';
import 'package:petapp_mobile/services/pet_services/species_services.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class SelectPetWidget extends GetView<CreatePostPageController> {
  const SelectPetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreatePostPageController>(builder: (_) {
      controller.isShowLoadingPet.value = true;

      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        if (controller.isShowPetFilter) {
          controller.species = await SpeciesService.fetchSpeciesList(
            jwt: controller.accountModel.jwtToken,
          );
          controller.selectedSpeciesId.value == -1
              ? controller.selectedSpeciesId.value = controller.species[0].id
              : null;
          controller
            ..pets = await PetService.fetchPetListToCreatePost(
              jwt: controller.accountModel.jwtToken,
              customerId: controller.accountModel.customerModel.id,
              speciesId: controller.selectedSpeciesId.value,
              type: controller.selectedPostType.value,
              gender:
                  controller.selectedPostType.value == 'BREED' ? 'MALE' : null,
            )
            ..isShowPetDropdownList.value = true;
        } else {
          controller
            ..pets = await PetService.fetchPetListToCreatePost(
              jwt: controller.accountModel.jwtToken,
              customerId: controller.accountModel.customerModel.id,
              type: controller.selectedPostType.value,
              gender:
                  controller.selectedPostType.value == 'BREED' ? 'MALE' : null,
            )
            ..isShowPetDropdownList.value = true;
        }

        controller
          ..selectedPetIndex.value = controller.pets.isNotEmpty ? 0 : -1
          ..isShowLoadingPet.value = false;
      });
      return Obx(() => controller.isShowLoadingPet.value
          ? LOADING_WIDGET(size: 40)
          : Column(
              children: [
                selectPetWidget(),
                !controller.isShowPetFilter
                    ? const SizedBox.shrink()
                    : petFilterWidget(),
              ],
            ));
    });
  }

  Widget petFilterWidget() => Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                'Pet species',
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  color: const Color.fromARGB(255, 106, 122, 143),
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 40, top: 10),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  runAlignment: WrapAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  spacing: 10,
                  runSpacing: 10,
                  children: controller.species
                      .asMap()
                      .entries
                      .map((e) => speciesItemWidget(speciesModel: e.value))
                      .toList(),
                ),
              ),
            ],
          ),
        ],
      );

  Widget speciesItemWidget({required SpeciesModel speciesModel}) =>
      GetBuilder<CreatePostPageController>(
        builder: (_) => Container(
          width: 55 + speciesModel.name.length * 10,
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () {
              controller.selectedSpeciesId.value = speciesModel.id;
              controller.update();
            },
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: controller.selectedSpeciesId.value == speciesModel.id
                    ? PRIMARY_COLOR
                    : PRIMARY_COLOR.withOpacity(0.13),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: controller.selectedSpeciesId.value == speciesModel.id
                        ? PRIMARY_COLOR.withOpacity(0.7)
                        : WHITE_COLOR,
                    offset: const Offset(1, 1),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    speciesModel.imageUrl!,
                    height: 25,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    speciesModel.name,
                    style: GoogleFonts.itim(
                      color:
                          speciesModel.id == controller.selectedSpeciesId.value
                              ? WHITE_COLOR
                              : PRIMARY_COLOR.withOpacity(0.7),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget selectPetWidget() => Column(
        children: [
          Container(
            height: 1,
            margin: const EdgeInsets.only(top: 10),
            color: LIGHT_GREY_COLOR.withAlpha(30),
          ),
          Container(
            height: 10,
            color: SUPPER_LIGHT_BLUE,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 20),
            child: Row(
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
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 15),
            alignment: Alignment.center,
            child: Row(
              children: [
                Expanded(
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            controller.pets.isNotEmpty
                                ? petItemWidget(
                                    petModel: controller.pets[
                                        controller.selectedPetIndex.value],
                                  )
                                : Text(
                                    'No suitable pet!',
                                    style: GoogleFonts.quicksand(
                                      fontWeight: FontWeight.w700,
                                      color: const Color.fromARGB(
                                          255, 244, 55, 159),
                                      fontSize: 16,
                                    ),
                                  ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: InkWell(
                            onTap: () => controller
                              ..isShowPetFilter = !controller.isShowPetFilter
                              ..update(),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: controller.isShowPetFilter
                                        ? PRIMARY_COLOR
                                        : const Color.fromARGB(
                                            255, 156, 175, 202),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                  color: controller.isShowPetFilter
                                      ? PRIMARY_COLOR
                                      : WHITE_COLOR),
                              child: Center(
                                child: SvgPicture.asset(
                                  ICON_PATH + FILTER_SVG,
                                  height: 18,
                                  color: controller.isShowPetFilter
                                      ? WHITE_COLOR
                                      : const Color.fromARGB(
                                          255, 102, 116, 136),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    controller.pets.isNotEmpty
                        ? petItemDropdownListWidget()
                        : const SizedBox.shrink()
                  ]),
                ),
              ],
            ),
          ),
        ],
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

    return Visibility(
      visible: controller.isShowPetDropdownList.value,
      child: Stack(
        children: [
          Positioned(
            right: 65,
            top: 16,
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
            margin: const EdgeInsets.only(top: 20),
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
    );
  }

  Widget petItemWidget({required PetModel petModel}) =>
      GetBuilder<CreatePostPageController>(
        builder: (_) => InkWell(
          onTap: () {
            controller.isShowPetDropdownList.value =
                !controller.isShowPetDropdownList.value;
          },
          child: Container(
            height: 50,
            width: 220,
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
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
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

  Widget petItemInDropdownListWidget({required int index}) => Column(
        children: [
          InkWell(
            onTap: () => controller
              ..isShowPetDropdownList.value = false
              ..selectedPetIndex.value = index,
            child: Container(
              height: 50,
              width: 280,
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
                            color: controller.selectBranchIndex.value == index
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
                          controller.pets[index].name,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.w500,
                            color: controller.selectBranchIndex.value == index
                                ? PRIMARY_COLOR
                                : const Color.fromARGB(255, 121, 128, 141),
                            fontSize: 16,
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
      ],
    );
  }
}
