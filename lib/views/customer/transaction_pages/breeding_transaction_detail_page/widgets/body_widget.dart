import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/breeding_transaction_detail_page_controller.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/breeding_services_bottom_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/breeding_services_for_female_pet_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/breeding_services_for_male_pet_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/transaction_detail_widget.dart';

class BreedingTransactionDetailBodyWidget
    extends GetView<BreedingTransactionDetailPageController> {
  const BreedingTransactionDetailBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          color: SUPPER_LIGHT_BLUE,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: controller.scrollController,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      controller.breedingTransactionModel.self
                          ? const SizedBox.shrink()
                          : petInformation(),
                      Container(
                        height: 1,
                        color: LIGHT_GREY_COLOR.withAlpha(30),
                      ),
                      Container(
                        color: SUPPER_LIGHT_BLUE,
                        height: 16,
                      ),
                      viewTypeWidget(),
                      Obx(
                        () => controller.selectedViewTab.value ==
                                'Transaction details'
                            ? const BreedingTransactionDetailWidget()
                            : controller.breedingTransactionModel
                                        .ownerPetFemaleId ==
                                    controller.accountModel.customerModel.id
                                ? const BreedingTransactionDetailBreedingServicesForFemalePetWidget()
                                : const BreedingTransactionDetailBreedingServicesForMalePetWidget(),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(() => controller.isShowBreedingServicesBottom.value
                  ? const BreedingTransactionDetailBreedingServicesBottomWidget()
                  : const SizedBox.shrink()),
              Obx(() => controller.isShowTransactionDetailBottom.value
                  ? const BreedingTransactionDetailBottomWidget()
                  : const SizedBox.shrink()),
            ],
          ),
        ),
      );

  Widget viewTypeWidget() => Container(
        color: WHITE_COLOR,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: controller.viewTabList
              .map((e) => viewTypeItemWidget(viewType: e))
              .toList(),
        ),
      );

  Widget viewTypeItemWidget({required String viewType, int flex = 1}) =>
      Expanded(
        flex: flex,
        child: Obx(
          () => InkWell(
            onTap: () => controller
              ..isShowTransactionDetailBottom.value = false
              ..isShowBreedingServicesBottom.value = false
              ..selectedViewTab.value = viewType
              ..update(),
            child: Column(
              children: [
                Container(
                  height: 30,
                  color: controller.selectedViewTab.value == viewType
                      ? PRIMARY_LIGHT_COLOR.withOpacity(0.3)
                      : WHITE_COLOR,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      controller.selectedViewTab.value == viewType
                          ? const Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: CircleAvatar(
                                maxRadius: 3,
                                backgroundColor: PRIMARY_COLOR,
                              ),
                            )
                          : const SizedBox.shrink(),
                      Text(
                        viewType,
                        style: GoogleFonts.quicksand(
                          color: controller.selectedViewTab.value == viewType
                              ? PRIMARY_COLOR
                              : const Color.fromARGB(255, 116, 122, 143),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 3,
                  color: controller.selectedViewTab.value == viewType
                      ? PRIMARY_COLOR
                      : const Color.fromARGB(255, 233, 235, 241),
                ),
              ],
            ),
          ),
        ),
      );

  Widget petInformation() => Stack(
        children: [
          Column(
            children: [
              malePetInformationWidget(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  height: 1,
                  color: LIGHT_GREY_COLOR.withAlpha(30),
                ),
              ),
              femalePetInformationWidget(),
            ],
          ),
          SizedBox(
            height: 180,
            child: Center(
              child: Image.asset(
                IMAGE_PATH + HEARTS_PNG,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      );

  Widget femalePetInformationWidget() => Container(
        color: WHITE_COLOR,
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  controller.breedingTransactionModel.femalePetModel.avatar,
                  fit: BoxFit.cover,
                  height: 60,
                  width: 60,
                  errorBuilder: (_, object, stackTrace) => Image.asset(
                    IMAGE_PATH + NO_IMAGE_PNG,
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pet name',
                        style: GoogleFonts.quicksand(
                          fontSize: 17,
                          color: const Color.fromARGB(255, 100, 107, 133),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ),
                      Text(
                        controller.breedingTransactionModel.femalePetModel.name,
                        style: GoogleFonts.quicksand(
                          fontSize: 17,
                          color: const Color.fromARGB(255, 77, 82, 105),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Breed',
                        style: GoogleFonts.quicksand(
                          fontSize: 15,
                          color: const Color.fromARGB(255, 100, 107, 133),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ),
                      Text(
                        controller.breedingTransactionModel.femalePetModel
                            .breedModel!.name,
                        style: GoogleFonts.quicksand(
                          fontSize: 15,
                          color: const Color.fromARGB(255, 77, 82, 105),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Gender',
                        style: GoogleFonts.quicksand(
                          fontSize: 15,
                          color: const Color.fromARGB(255, 100, 107, 133),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            controller.breedingTransactionModel.femalePetModel
                                        .gender ==
                                    'MALE'
                                ? ICON_PATH + MALE_SVG
                                : ICON_PATH + FEMALE_SVG,
                            color: controller.breedingTransactionModel
                                        .femalePetModel.gender ==
                                    'MALE'
                                ? const Color.fromARGB(255, 39, 111, 245)
                                : const Color.fromARGB(255, 244, 55, 165),
                            height: 10,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            controller
                                .breedingTransactionModel.femalePetModel.gender,
                            style: GoogleFonts.quicksand(
                              fontSize: 15,
                              color: controller.breedingTransactionModel
                                          .femalePetModel.gender ==
                                      'MALE'
                                  ? const Color.fromARGB(255, 39, 111, 245)
                                  : const Color.fromARGB(255, 244, 55, 165),
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget malePetInformationWidget() => Container(
        color: WHITE_COLOR,
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  controller
                      .breedingTransactionModel.postModel!.mediaModels![0].url,
                  fit: BoxFit.cover,
                  height: 60,
                  width: 60,
                  errorBuilder: (_, object, stackTrace) => Image.asset(
                    IMAGE_PATH + NO_IMAGE_PNG,
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pet name',
                        style: GoogleFonts.quicksand(
                          fontSize: 17,
                          color: const Color.fromARGB(255, 100, 107, 133),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ),
                      Text(
                        controller.breedingTransactionModel.malePetModel.name,
                        style: GoogleFonts.quicksand(
                          fontSize: 17,
                          color: const Color.fromARGB(255, 77, 82, 105),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Breed',
                        style: GoogleFonts.quicksand(
                          fontSize: 15,
                          color: const Color.fromARGB(255, 100, 107, 133),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ),
                      Text(
                        controller.breedingTransactionModel.malePetModel
                            .breedModel!.name,
                        style: GoogleFonts.quicksand(
                          fontSize: 15,
                          color: const Color.fromARGB(255, 77, 82, 105),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Gender',
                        style: GoogleFonts.quicksand(
                          fontSize: 15,
                          color: const Color.fromARGB(255, 100, 107, 133),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            controller.breedingTransactionModel.malePetModel
                                        .gender ==
                                    'MALE'
                                ? ICON_PATH + MALE_SVG
                                : ICON_PATH + FEMALE_SVG,
                            color: controller.breedingTransactionModel
                                        .malePetModel.gender ==
                                    'MALE'
                                ? const Color.fromARGB(255, 39, 111, 245)
                                : const Color.fromARGB(255, 244, 55, 165),
                            height: 10,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            controller
                                .breedingTransactionModel.malePetModel.gender,
                            style: GoogleFonts.quicksand(
                              fontSize: 15,
                              color: controller.breedingTransactionModel
                                          .malePetModel.gender ==
                                      'MALE'
                                  ? const Color.fromARGB(255, 39, 111, 245)
                                  : const Color.fromARGB(255, 244, 55, 165),
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
