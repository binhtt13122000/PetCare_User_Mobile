import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_detail_page_controller.dart';
import 'package:petapp_mobile/models/pet_combo_model/pet_combo_model.dart';
import 'package:petapp_mobile/services/pet_services/pet_combo_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PetDetailServicesComboWidget extends GetView<PetDetailPageController> {
  const PetDetailServicesComboWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PetDetailPageController>(
      builder: (_) {
        controller.isLoadingPetCombo.value = true;
        WidgetsBinding.instance!.addPostFrameCallback((_) async {
          controller
            ..petComboModelList =
                await PetComboServices.fetchListPetComboByPetId(
                    petId: controller.petModel.id)
            ..isLoadingPetCombo.value = false;
        });
        return Obx(
          () => controller.isLoadingPetCombo.value
              ? Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: LOADING_WIDGET(),
                )
              : controller.petComboModelList.isNotEmpty
                  ? petComboListWidget()
                  : noExistPetCombo(),
        );
      },
    );
  }

  Widget petComboListWidget() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Column(
              children: controller.petComboModelList
                  .map((e) => petComboItemWidget(petComboModel: e))
                  .toList(),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 20),
                    child: InkWell(
                      onTap: () => Get.toNamed(
                          '$BUY_SERVICES_COMBO_PAGE_ROUTE?petId=${controller.petModel.id}'),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: CUSTOM_TEXT('BUY MORE PET SERVICES COMBO',
                            color: WHITE_COLOR, letterSpacing: 1, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget petComboItemWidget({required PetComboModel petComboModel}) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: InkWell(
          onTap: () =>
              Get.toNamed('$PET_COMBO_DETAIL_PAGE_ROUTE/${petComboModel.id}'),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
                color: WHITE_COLOR,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: DARK_GREY_COLOR.withOpacity(0.1),
                    offset: const Offset(2, 2),
                    blurRadius: 3,
                  ),
                ]),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CUSTOM_TEXT('#${petComboModel.id}'),
                    CUSTOM_TEXT(
                      petComboModel.servicesComboModel.name,
                      color: PRIMARY_COLOR,
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CUSTOM_TEXT('Type'),
                    CUSTOM_TEXT(petComboModel.servicesComboModel.type),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CUSTOM_TEXT('Register time'),
                    CUSTOM_TEXT(
                      FORMAT_DATE_TIME(
                          dateTime: petComboModel.registerTime,
                          pattern: DATE_PATTERN_2),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CUSTOM_TEXT('Register brach'),
                    CUSTOM_TEXT(petComboModel.branchModel.name),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CUSTOM_TEXT('Status'),
                    CUSTOM_TEXT(
                        petComboModel.isCompleted ? 'Completed' : 'In progress',
                        color: petComboModel.isCompleted
                            ? GREEN_COLOR
                            : YELLOW_COLOR),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget noExistPetCombo() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 200),
        child: Column(
          children: [
            CUSTOM_TEXT(
                'Your pet doesn\'t have any services combo yet! Buy a services combo for your pet now.',
                textAlign: TextAlign.center,
                textOverflow: TextOverflow.clip,
                letterSpacing: 2,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                color: DARK_GREY_TEXT_COLOR.withOpacity(0.7)),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: InkWell(
                onTap: () => Get.toNamed(
                    '$BUY_SERVICES_COMBO_PAGE_ROUTE?petId=${controller.petModel.id}&speciesId=${controller.petModel.breedModel!.speciesId}'),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: CUSTOM_TEXT(
                    'BUY A PET SERVICES COMBO',
                    color: WHITE_COLOR,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
