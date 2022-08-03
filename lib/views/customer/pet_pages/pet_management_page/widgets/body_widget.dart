import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_management_page_controller.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';
import 'package:petapp_mobile/services/pet_services/pet_services.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PetsManagementBodyWidget extends GetView<PetManagementPageController> {
  const PetsManagementBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Expanded(
      child: Column(
        children: [
          postTableHeaderWidget(),
          Container(
            height: 1.5,
            margin:
                const EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 10),
            color: const Color.fromARGB(255, 217, 222, 241),
          ),
          Expanded(
            child: GetBuilder<PetManagementPageController>(builder: (_) {
              controller.isLoadingPetList.value = true;
              WidgetsBinding.instance!.addPostFrameCallback((_) async {
                controller.petList = await PetService.fetchPetListByCustomerId(
                  controller.accountModel.customerModel.id,
                  jwt: controller.accountModel.jwtToken,
                  type: controller.petStatus,
                  name: controller.searchText.value,
                );
                controller.isLoadingPetList.value = false;
              });
              return Obx(
                () => controller.isLoadingPetList.value
                    ? LOADING_WIDGET()
                    : SmartRefresher(
                        controller: RefreshController(),
                        onRefresh: () => controller.update(),
                        child: SingleChildScrollView(
                          child: controller.petList.isEmpty
                              ? NO_DATA_WIDGET(
                                  content: 'Sorry, no pet data found.')
                              : Column(
                                  children: controller.petList
                                      .asMap()
                                      .entries
                                      .map(
                                        (e) => e.key.isEven
                                            ? petCardDarkThemeWidget(
                                                petModel: e.value,
                                                screenWidth: screenWidth)
                                            : petCardWidget(
                                                petModel: e.value,
                                                screenWidth: screenWidth),
                                      )
                                      .toList(),
                                ),
                        ),
                      ),
              );
            }),
          ),
        ],
      ),
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
                  'Avatar',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                      fontSize: 13,
                      color: const Color.fromARGB(255, 83, 89, 110),
                      height: 2,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            SizedBox(
              width: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(
                      'Name',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.quicksand(
                        fontSize: 13,
                        color: const Color.fromARGB(255, 83, 89, 110),
                        height: 2,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 3),
                      child: Text(
                        'Pet breed',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.quicksand(
                          fontSize: 13,
                          color: const Color.fromARGB(255, 83, 89, 110),
                          height: 2,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 3),
                    child: Text(
                      'Status',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.quicksand(
                        fontSize: 13,
                        color: const Color.fromARGB(255, 83, 89, 110),
                        height: 2,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget petCardWidget(
      {required PetModel petModel, required double screenWidth}) {
    late String petStatusText;
    late Color petStatusColor;
    switch (petModel.status) {
      case 'NORMAL':
        petStatusText = 'Normal';
        petStatusColor = GREEN_COLOR;
        break;
      case 'IN_POST':
        petStatusText = 'In a post';
        petStatusColor = YELLOW_COLOR;
        break;
      case 'IN_BREED':
        petStatusText = 'Breeding';
        petStatusColor = PINK_COLOR;
        break;
      default:
        petStatusText = petModel.status;
        petStatusColor = YELLOW_COLOR;
    }
    return InkWell(
      onTap: () => Get.toNamed('$PET_DETAIL_PAGE_ROUTE/${petModel.id}'),
      child: Container(
        height: 70,
        width: screenWidth,
        margin: const EdgeInsets.only(left: 12),
        decoration: const BoxDecoration(),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: Image.network(
                    petModel.avatar,
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                    errorBuilder: (_, object, stackTrace) => Image.asset(
                      IMAGE_PATH + NO_IMAGE_PNG,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                      errorBuilder: (_, object, stackTrace) => Image.asset(
                        IMAGE_PATH + NO_IMAGE_PNG,
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 70,
                padding: const EdgeInsets.only(right: 0),
                child: Text(
                  petModel.name,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                    color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              SizedBox(
                width: screenWidth - 240,
                child: Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        petModel.breedModel!.name,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                        style: GoogleFonts.quicksand(
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        '(${petModel.breedModel!.speciesModel!.name} - ${petModel.gender == 'FEMALE' ? 'Female' : 'Male'})',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.quicksand(
                          color: const Color.fromARGB(255, 64, 69, 87),
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 85,
                child: Text(
                  petStatusText,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                    color: petStatusColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
              Visibility(
                visible: petModel.status == 'NORMAL',
                child: Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: InkWell(
                    onTap: () => controller
                      ..selectedPetModel = petModel
                      ..isShowConfirmPopup.value = true,
                    child: Container(
                      height: 70,
                      color: RED_COLOR,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CUSTOM_TEXT('Delete', color: WHITE_COLOR),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget petCardDarkThemeWidget(
      {required PetModel petModel, required double screenWidth}) {
    late String petStatusText;
    late Color petStatusColor;
    switch (petModel.status) {
      case 'NORMAL':
        petStatusText = 'Normal';
        petStatusColor = GREEN_COLOR;
        break;
      case 'IN_POST':
        petStatusText = 'In a post';
        petStatusColor = YELLOW_COLOR;
        break;
      case 'IN_BREED':
        petStatusText = 'Breeding';
        petStatusColor = PINK_COLOR;
        break;
      default:
        petStatusText = petModel.status;
        petStatusColor = YELLOW_COLOR;
    }
    return Column(
      children: [
        Container(
          height: 1,
          margin: const EdgeInsets.symmetric(vertical: 3),
          color: const Color.fromARGB(255, 240, 243, 255),
        ),
        SizedBox(
          width: screenWidth,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: InkWell(
              onTap: () => Get.toNamed('$PET_DETAIL_PAGE_ROUTE/${petModel.id}'),
              child: Container(
                height: 70,
                padding: const EdgeInsets.only(left: 12),
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
                          petModel.avatar,
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                          errorBuilder: (_, object, stackTrace) => Image.asset(
                            IMAGE_PATH + NO_IMAGE_PNG,
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
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
                    ),
                    Container(
                      width: 70,
                      padding: const EdgeInsets.only(right: 0),
                      child: Text(
                        petModel.name,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth - 240,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              petModel.breedModel!.name,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.clip,
                              style: GoogleFonts.quicksand(
                                color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                letterSpacing: 0.5,
                              ),
                            ),
                            Text(
                              '(${petModel.breedModel!.speciesModel!.name} - ${petModel.gender == 'FEMALE' ? 'Female' : 'Male'})',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.quicksand(
                                color: const Color.fromARGB(255, 64, 69, 87),
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 85,
                      child: Text(
                        petStatusText,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                          color: petStatusColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: petModel.status == 'NORMAL',
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: InkWell(
                          onTap: () => controller
                            ..selectedPetModel = petModel
                            ..isShowConfirmPopup.value = true,
                          child: Container(
                            height: 70,
                            color: RED_COLOR,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: CUSTOM_TEXT('Delete', color: WHITE_COLOR),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
}
