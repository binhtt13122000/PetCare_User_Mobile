import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_combo_detail_page_controller.dart';
import 'package:petapp_mobile/models/pet_combo_detail_model/pet_combo_detail_model.dart';
import 'package:petapp_mobile/services/pet_services/pet_combo_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PetComboDetailBodyWidget extends GetView<PetComboDetailPageController> {
  const PetComboDetailBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          color: SUPPER_LIGHT_BLUE,
          child: Column(
            children: [
              petComboIdWidget(),
              Expanded(
                child: SingleChildScrollView(
                  controller: controller.scrollController,
                  child: Column(
                    children: [
                      petServicesComboGeneralInformationWidget(),
                      Container(
                        height: 1,
                        color: DARK_GREY_COLOR.withAlpha(30),
                      ),
                      branchInformationWidget(),
                      Container(
                        height: 1,
                        color: DARK_GREY_COLOR.withAlpha(30),
                      ),
                      petServicesComboItemListWidget(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget petServicesComboItemListWidget() => Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(vertical: 10),
        color: WHITE_COLOR,
        child: Column(
          children: [
            CUSTOM_TEXT(
              'Pet services list',
              fontWeight: FontWeight.w700,
              fontSize: 16,
              letterSpacing: 2,
              padding: const EdgeInsets.only(bottom: 10),
            ),
            servicesStatusWidget(),
            GetBuilder<PetComboDetailPageController>(builder: (_) {
              controller.isWaitLoadingPetServicesList.value = true;
              List<PetComboDetailModel> filterPetComboDetailModelList = [];

              WidgetsBinding.instance!.addPostFrameCallback((_) async {
                controller
                  ..petComboModel = await PetComboServices.fetchPetComboById(
                      petComboId: controller.petComboModel.id.toString())
                  ..petComboStatus.value = controller.petComboModel.isCompleted
                      ? 'Completed'
                      : 'In progress';

                DateTime now = DateTime.now();
                for (var e
                    in controller.petComboModel.petComboDetailModelList!) {
                  switch (controller.selectServicesStatus.value) {
                    case 'Waiting':
                      if (e.workingTime.isAfter(DateTime.now())) {
                        filterPetComboDetailModelList.add(e);
                      }
                      break;
                    case 'Available':
                      if (e.workingTime.day == now.day &&
                          e.workingTime.month == now.month &&
                          e.workingTime.year == now.year &&
                          !e.isCompleted) {
                        filterPetComboDetailModelList.add(e);
                      }
                      break;
                    case 'Completed':
                      if (e.isCompleted) {
                        filterPetComboDetailModelList.add(e);
                      }
                      break;
                    case 'Expired':
                      if (e.workingTime
                              .add(const Duration(hours: 24))
                              .isBefore(DateTime.now()) &&
                          !e.isCompleted) {
                        filterPetComboDetailModelList.add(e);
                      }
                      break;
                  }
                }

                if (filterPetComboDetailModelList.isNotEmpty) {
                  switch (controller.selectServicesStatus.value) {
                    case 'Waiting':
                      filterPetComboDetailModelList.sort(
                          (a, b) => a.workingTime.compareTo(b.workingTime));
                      break;
                    case 'Completed':
                      filterPetComboDetailModelList
                          .sort((b, a) => a.realTime!.compareTo(b.realTime!));
                      break;
                    case 'Expired':
                      filterPetComboDetailModelList.sort(
                          (b, a) => a.workingTime.compareTo(b.workingTime));
                      break;
                  }
                }

                controller.isWaitLoadingPetServicesList.value = false;
              });
              return Obx(() {
                if (!controller.isWaitLoadingPetServicesList.value) {}
                return controller.isWaitLoadingPetServicesList.value
                    ? Padding(
                        padding: const EdgeInsets.only(top: 200, bottom: 1000),
                        child: LOADING_WIDGET(),
                      )
                    : Column(
                        children: filterPetComboDetailModelList
                            .asMap()
                            .entries
                            .map((e) => petServicesComboItemWidget(
                                petComboDetailModel: e.value, index: e.key + 1))
                            .toList());
              });
            })
          ],
        ),
      );

  Widget petServicesComboItemWidget(
      {required PetComboDetailModel petComboDetailModel, required int index}) {
    String timeText = '';
    int hours = petComboDetailModel.centerServiceModel.estimatedTime ~/ 60;
    int minutes = petComboDetailModel.centerServiceModel.estimatedTime % 60;

    if (hours > 0 && minutes > 0) {
      timeText = '$hours hours : $minutes minutes';
    } else if (hours > 0) {
      timeText = '$hours hours';
    } else {
      timeText = '$minutes minutes';
    }
    Color backgroundColor;

    switch (controller.selectServicesStatus.value) {
      case 'Waiting':
        backgroundColor = YELLOW_COLOR.withOpacity(0.05);
        break;
      case 'Available':
        backgroundColor = BLUE_COLOR.withOpacity(0.05);
        break;
      case 'Completed':
        backgroundColor = GREEN_COLOR.withOpacity(0.05);
        break;
      case 'Expired':
        backgroundColor = RED_COLOR.withOpacity(0.05);
        break;
      default:
        backgroundColor = YELLOW_COLOR.withOpacity(0.05);
        break;
    }

    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            height: 1,
            color: DARK_GREY_COLOR.withAlpha(30),
            margin: const EdgeInsets.only(bottom: 5),
          ),
          textCardWidget(
              keyText: 'No.${index.toString()}',
              valueText: petComboDetailModel.centerServiceModel.name,
              isImportantValue: true),
          Visibility(
            visible: controller.selectServicesStatus.value != 'Completed',
            child: textCardWidget(
                keyText: 'Estimated execution date',
                valueText: FORMAT_DATE_TIME(
                    dateTime: petComboDetailModel.workingTime,
                    pattern: DATE_PATTERN_2)),
          ),
          Visibility(
            visible: controller.selectServicesStatus.value != 'Completed',
            child: textCardWidget(
                keyText: 'Estimated execution time', valueText: timeText),
          ),
          Visibility(
            visible: controller.selectServicesStatus.value == 'Completed',
            child: textCardWidget(
                keyText: 'Completed date',
                valueText: petComboDetailModel.realTime != null
                    ? FORMAT_DATE_TIME(
                        dateTime: petComboDetailModel.realTime!,
                        pattern: DATE_TIME_PATTERN)
                    : 'N/A'),
          ),
          textCardWidget(
            keyText: 'Description',
            valueText:
                petComboDetailModel.centerServiceModel.description ?? 'N/A',
          ),
          Visibility(
            visible: controller.selectServicesStatus.value == 'Available' ||
                controller.selectServicesStatus.value == 'Expired',
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: InkWell(
                onTap: () async => controller
                  ..selectedPetComboDetailModel = petComboDetailModel
                  ..isShowPopup.value = true,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                      color: PRIMARY_COLOR,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CUSTOM_TEXT('Mark this pet service as completed',
                          color: WHITE_COLOR,
                          padding: const EdgeInsets.only(right: 5)),
                      const Icon(
                        Icons.verified_outlined,
                        color: WHITE_COLOR,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: controller.selectServicesStatus.value == 'Completed' &&
                (petComboDetailModel.star == null ||
                    petComboDetailModel.star == 0),
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: InkWell(
                onTap: () async => controller
                  ..selectedPetComboDetailModel = petComboDetailModel
                  ..isShowRatingPopup.value = true,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                      color: PRIMARY_COLOR,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CUSTOM_TEXT('Rating this pet services',
                          color: WHITE_COLOR,
                          padding: const EdgeInsets.only(right: 5)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: controller.selectServicesStatus.value == 'Completed' &&
                (petComboDetailModel.star == null ||
                    petComboDetailModel.star != 0),
            child: CUSTOM_TEXT(
              'You have submitted a review for this pet services',
              fontSize: 12,
              color: DARK_GREY_TEXT_COLOR.withOpacity(0.7),
            ),
          ),
          Container(
            height: 1,
            color: DARK_GREY_COLOR.withAlpha(30),
            margin: const EdgeInsets.only(top: 5),
          ),
        ],
      ),
    );
  }

  Widget petComboIdWidget() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CUSTOM_TEXT(
              'Pet services combo ID',
              fontSize: 13,
              color: DARK_GREY_TEXT_COLOR.withOpacity(0.7),
            ),
            CUSTOM_TEXT(
              (controller.petComboModel.id < 10 ? '#0' : '#') +
                  controller.petComboModel.id.toString(),
              fontSize: 13,
              color: DARK_GREY_TEXT_COLOR.withOpacity(0.7),
            ),
          ],
        ),
      );

  Widget petServicesComboGeneralInformationWidget() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        color: WHITE_COLOR,
        child: Column(
          children: [
            textCardWidget(
                keyText: 'Name',
                valueText: controller.petComboModel.servicesComboModel!.name),
            textCardWidget(
                keyText: 'Type',
                valueText: controller.petComboModel.servicesComboModel!.type),
            Obx(() => textCardWidget(
                keyText: 'Status',
                valueText: controller.petComboStatus.value,
                valueColor: controller.petComboStatus.value == 'Completed'
                    ? BLUE_COLOR
                    : YELLOW_COLOR)),
            textCardWidget(
              keyText: 'Register date',
              valueText: FORMAT_DATE_TIME(
                  dateTime: controller.petComboModel.registerTime,
                  pattern: DATE_PATTERN_2),
            ),
          ],
        ),
      );

  Widget branchInformationWidget() => Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        color: WHITE_COLOR,
        child: Column(
          children: [
            CUSTOM_TEXT(
              'Branch perform services',
              fontWeight: FontWeight.w700,
              fontSize: 16,
              letterSpacing: 2,
              padding: const EdgeInsets.only(bottom: 10),
            ),
            textCardWidget(
                keyText: 'Name',
                valueText: controller.petComboModel.branchModel!.name,
                isImportantValue: true),
            textCardWidget(
                keyText: 'Address',
                valueText: controller.petComboModel.branchModel!.address!),
            textCardWidget(
                keyText: 'Phone number',
                valueText: controller.petComboModel.branchModel!.phoneNumber),
            textCardWidget(
                keyText: 'Email',
                valueText:
                    controller.petComboModel.branchModel!.email ?? 'N/A'),
          ],
        ),
      );

  Widget textCardWidget(
          {required String keyText,
          required String valueText,
          Color valueColor = DARK_GREY_TEXT_COLOR,
          bool isImportantValue = false}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CUSTOM_TEXT(keyText),
            Expanded(
              child: CUSTOM_TEXT(valueText,
                  textAlign: TextAlign.right,
                  textOverflow: TextOverflow.clip,
                  color: valueColor,
                  fontWeight:
                      isImportantValue ? FontWeight.w700 : FontWeight.w500,
                  letterSpacing: isImportantValue ? 1 : 0.5),
            ),
          ],
        ),
      );

  Widget servicesStatusWidget() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: controller.servicesStatus
            .asMap()
            .entries
            .map((e) => servicesStatusItemWidget(viewType: e.value))
            .toList(),
      );

  Widget servicesStatusItemWidget({required String viewType, int flex = 1}) =>
      Expanded(
        flex: flex,
        child: Obx(
          () => InkWell(
            onTap: () => controller
              ..selectServicesStatus.value = viewType
              ..update(),
            child: Column(
              children: [
                Container(
                  height: 30,
                  color: controller.selectServicesStatus.value == viewType
                      ? PRIMARY_LIGHT_COLOR.withOpacity(0.3)
                      : Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      controller.selectServicesStatus.value == viewType
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
                          color:
                              controller.selectServicesStatus.value == viewType
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
                  color: controller.selectServicesStatus.value == viewType
                      ? PRIMARY_COLOR
                      : const Color.fromARGB(255, 233, 235, 241),
                ),
              ],
            ),
          ),
        ),
      );
}
