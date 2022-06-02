import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_management_page_controller.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';
import 'package:petapp_mobile/services/pet_services.dart';

class PetsManagementBodyWidget extends GetView<PetManagementPageController> {
  const PetsManagementBodyWidget({Key? key}) : super(key: key);

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
          child: GetBuilder<PetManagementPageController>(builder: (_) {
            controller.isLoadingPetList.value = true;
            WidgetsBinding.instance!.addPostFrameCallback((_) async {
              controller.petList = await PetService.fetchPetListByCustomerId(
                  controller.accountModel.customerModel.id);
              controller.isLoadingPetList.value = false;
            });
            return Obx(
              () => controller.isLoadingPetList.value
                  ? Container(
                      color: const Color.fromARGB(106, 198, 188, 201),
                      alignment: Alignment.center,
                      child: const SpinKitSpinningLines(
                        color: PRIMARY_COLOR,
                        size: 150,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: controller.petList
                            .asMap()
                            .entries
                            .map(
                              (e) => e.key.isEven
                                  ? petCardDarkThemeWidget(petModel: e.value)
                                  : petCardWidget(petModel: e.value),
                            )
                            .toList(),
                      ),
                    ),
            );
          }),
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
                        'Pet name',
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
            Expanded(
              child: InkWell(
                onTap: () => controller.setHeaderFilter('Status'),
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
                              fontSize: 12,
                              color: const Color.fromARGB(255, 83, 89, 110),
                              height: 2,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Obx(
                        () => SvgPicture.asset(
                          controller.postManagementTableHeaders['Title'] == 2
                              ? ICON_PATH + TOPWARD_ARROW_SVG
                              : ICON_PATH + DOWNWARD_ARROW_SVG,
                          color:
                              controller.postManagementTableHeaders['Title'] ==
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
                        'Status',
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

  Widget petCardWidget({required PetModel petModel}) => Container(
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
                  petModel.avatar,
                  fit: BoxFit.cover,
                  width: 50,
                  height: 50,
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
                  color: const Color.fromARGB(255, 64, 69, 87),
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Expanded(
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
                        color: const Color.fromARGB(255, 64, 69, 87),
                        fontWeight: FontWeight.w400,
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
                petModel.status,
                textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(
                  color: const Color.fromARGB(255, 68, 204, 214),
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      );

  Widget petCardDarkThemeWidget({required PetModel petModel}) => Column(
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
                      petModel.avatar,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
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
                      color: const Color.fromARGB(255, 64, 69, 87),
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Expanded(
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
                            color: const Color.fromARGB(255, 64, 69, 87),
                            fontWeight: FontWeight.w400,
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
                    petModel.status,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand(
                      color: const Color.fromARGB(255, 68, 204, 214),
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      letterSpacing: 0.5,
                    ),
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
