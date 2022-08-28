import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/breeding_transaction_detail_page_controller.dart';
import 'package:petapp_mobile/services/transaction_services/breeding_transaction_services.dart';
import 'package:petapp_mobile/services/transaction_services/ticket_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/breeding_services_for_female_pet_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/breeding_services_for_male_pet_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/breeding_transaction_detail_page/widgets/transaction_detail_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BreedingTransactionDetailBodyWidget
    extends GetView<BreedingTransactionDetailPageController> {
  const BreedingTransactionDetailBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BreedingTransactionDetailPageController>(
      builder: (_) {
        if (controller.isReloadAll) {
          controller.isWaitingLoadingInitData.value = true;
        }

        WidgetsBinding.instance!.addPostFrameCallback((_) async {
          controller
            ..breedingTransactionModel =
                await BreedingTransactionService.fetchBreedingTransactionById(
                    jwt: controller.accountModel.jwtToken,
                    breedingTransactionId: controller.breedingTransactionId)
            ..ticketModel = await TicketServices.fetchTicketByCustomerId(
                jwt: controller.accountModel.jwtToken,
                customerId: controller.accountModel.customerModel.id)
            ..sortComboList()
            ..isReloadAll = false
            ..isWaitingLoadingInitData.value = false;
        });

        return Obx(
          () => controller.isWaitingLoadingInitData.value
              ? Expanded(
                  child: Column(
                  children: [
                    const BreedingTransactionDetailTopWidget(),
                    Expanded(
                      child: LOADING_WIDGET(),
                    ),
                  ],
                ))
              : Expanded(
                  child: Container(
                    color: SUPPER_LIGHT_BLUE,
                    child: Column(
                      children: [
                        const BreedingTransactionDetailTopWidget(),

                        Expanded(
                          child: SmartRefresher(
                            controller: RefreshController(),
                            onRefresh: () => controller
                              ..isReloadAll = true
                              ..update(),
                            child: SingleChildScrollView(
                              controller: controller.scrollController,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  petInformation(),
                                  viewTypeWidget(),
                                  Obx(
                                    () => controller.selectedViewTab.value ==
                                            'Transaction details'
                                        ? const BreedingTransactionDetailWidget()
                                        : controller.breedingTransactionModel
                                                    .ownerPetFemaleId ==
                                                controller.accountModel
                                                    .customerModel.id
                                            ? const BreedingTransactionDetailBreedingServicesForFemalePetWidget()
                                            : const BreedingTransactionDetailBreedingServicesForMalePetWidget(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Obx(() => controller.isShowBreedingServicesBottom.value
                        //     ? const BreedingTransactionDetailBreedingServicesBottomWidget()
                        //     : const SizedBox.shrink()),
                        Obx(() => controller.isShowBottomWidget.value
                            ? const BreedingTransactionDetailBottomWidget()
                            : const SizedBox.shrink()),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

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
              ..isShowBottomWidget.value = false
              ..isShowBottomWidget.value = false
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
              Container(
                color: WHITE_COLOR,
                padding: const EdgeInsets.only(top: 10, bottom: 0),
                alignment: Alignment.center,
                child: CUSTOM_TEXT(
                  'Breeding for ' +
                      controller.breedingTransactionModel.femalePetModel
                          .breedModel!.name +
                      ' - ' +
                      controller.breedingTransactionModel.femalePetModel
                          .breedModel!.speciesModel!.name,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              malePetInformationWidget(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  height: 1,
                  color: LIGHT_GREY_COLOR.withAlpha(30),
                ),
              ),
              femalePetInformationWidget(),
              Container(
                height: 1,
                color: LIGHT_GREY_COLOR.withAlpha(30),
              ),
            ],
          ),
          Container(
            height: 260,
            margin: const EdgeInsets.only(left: 0),
            child: Center(
              child: Image.asset(
                IMAGE_PATH + HEARTS_PNG,
                height: 30,
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
              padding: const EdgeInsets.only(right: 10),
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
                          fontSize: 14,
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ),
                      Text(
                        controller.breedingTransactionModel.femalePetModel.name,
                        style: GoogleFonts.quicksand(
                          fontSize: 14,
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
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
                          fontSize: 14,
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
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
                            height: 12,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            controller
                                .breedingTransactionModel.femalePetModel.gender,
                            style: GoogleFonts.quicksand(
                              fontSize: 13,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Age range',
                        style: GoogleFonts.quicksand(
                          fontSize: 14,
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ),
                      Text(
                        GET_AGE_RANGE(
                            dob: controller
                                .breedingTransactionModel.femalePetModel.dob,
                            currentTime: controller
                                .breedingTransactionModel.createdTime),
                        style: GoogleFonts.quicksand(
                          fontSize: 14,
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
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
              padding: const EdgeInsets.only(right: 10),
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
                          fontSize: 14,
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ),
                      Text(
                        controller.breedingTransactionModel.malePetModel.name,
                        style: GoogleFonts.quicksand(
                          fontSize: 14,
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
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
                          fontSize: 14,
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
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
                            height: 12,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            controller
                                .breedingTransactionModel.malePetModel.gender,
                            style: GoogleFonts.quicksand(
                              fontSize: 13,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Age range',
                        style: GoogleFonts.quicksand(
                          fontSize: 14,
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ),
                      Text(
                        GET_AGE_RANGE(
                            dob: controller
                                .breedingTransactionModel.malePetModel.dob,
                            currentTime: controller
                                .breedingTransactionModel.createdTime),
                        style: GoogleFonts.quicksand(
                          fontSize: 14,
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
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
