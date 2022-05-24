import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/create_post_page_controller.dart';
import 'package:petapp_mobile/controllers/sign_in_page_controller.dart';
import 'package:petapp_mobile/graphql/query_mutation/pet.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';
import 'package:petapp_mobile/services/pet_services.dart';

class SelectPetWidget extends GetView<CreatePostPageController> {
  const SelectPetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SignInPageController());
    return Column(
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
          child: MixinBuilder<CreatePostPageController>(builder: (_) {
            String query;
            Map<String, dynamic> variables;
            if (controller.isShowPetFilter.value &&
                controller.selectedPetId != -1) {
              if (controller.selectedBreedMap[controller.selectedSpeciesId] ==
                      null ||
                  controller.selectedBreedMap[controller.selectedSpeciesId]! ==
                      -1) {
                query = FETCH_PET_LIST_WITHOUT_BREED_TO_CREATE_POST;
                variables = {
                  'customerId': controller.accountModel.customerModel.id,
                  'speciesId': controller.selectedSpeciesId,
                };
              } else {
                query = FETCH_PET_LIST_WITH_BREED_TO_CREATE_POST;
                variables = {
                  'customerId': controller.accountModel.customerModel.id,
                  'speciesId': controller.selectedSpeciesId,
                  'breedId':
                      controller.selectedBreedMap[controller.selectedSpeciesId],
                };
              }
            } else {
              query = FETCH_PET_LIST_TO_CREATE_POST;
              variables = {
                'customerId': controller.accountModel.customerModel.id,
              };
            }

            return Query(
                options:
                    QueryOptions(document: gql(query), variables: variables),
                builder: (
                  QueryResult result, {
                  VoidCallback? refetch,
                  FetchMore? fetchMore,
                }) {
                  if (result.hasException) {
                    return Text(result.exception.toString());
                  } else if (result.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (result.data != null) {
                    controller.pets = PetService.getPetList(result.data!).obs;
                    if (controller.pets.isNotEmpty) {
                      if (controller.selectedPetId == -1) {
                        controller.selectedPetId = controller.pets[0].id;
                      } else {
                        bool isExits = false;
                        for (var element in controller.pets) {
                          if (element.id == controller.selectedPetId) {
                            isExits = true;
                            break;
                          }
                        }
                        if (!isExits) {
                          controller.selectedPetId = controller.pets[0].id;
                        }
                      }
                    }
                  }
                  return Column(children: [
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
                                              controller.selectedPetId),
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
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Obx(
                            () => InkWell(
                              onTap: () {
                                if (controller.isShowPetFilter.value) {
                                  controller.isShowPetFilter.value = false;
                                  controller.isShowPetDropdownList.value =
                                      false;
                                } else {
                                  controller.isShowPetFilter.value = true;
                                  controller.isShowPetDropdownList.value = true;
                                  controller.mainScrollController.animateTo(
                                    247,
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    curve: Curves.ease,
                                  );
                                }
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: controller.isShowPetFilter.value
                                          ? PRIMARY_COLOR
                                          : const Color.fromARGB(
                                              255, 156, 175, 202),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    color: controller.isShowPetFilter.value
                                        ? PRIMARY_COLOR
                                        : WHITE_COLOR),
                                child: Center(
                                  child: SvgPicture.asset(
                                    ICON_PATH + FILTER_SVG,
                                    height: 18,
                                    color: controller.isShowPetFilter.value
                                        ? WHITE_COLOR
                                        : const Color.fromARGB(
                                            255, 102, 116, 136),
                                  ),
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
                  ]);
                });
          }),
        ),
      ],
    );
  }

  Widget petItemDropdownListWidget() {
    ScrollController scrollController = ScrollController();

    return Obx(() {
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
                                isLastIndex:
                                    e.key == controller.pets.length - 1),
                          )
                          .toList()),
                ),
              ),
            ),
          ],
        ),
      );
    });
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
              controller.selectedPetId = petModel.id;
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
                            color: controller.selectedPetId == petModel.id
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
                        color: controller.selectedPetId == petModel.id
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
}
