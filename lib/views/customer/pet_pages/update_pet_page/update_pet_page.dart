import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_detail_page_controller.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/update_pet_page_controller.dart';
import 'package:petapp_mobile/services/pet_services/pet_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/customer/pet_pages/update_pet_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/update_pet_page/widgets/bottom_widget.dart';

import 'package:petapp_mobile/views/customer/pet_pages/update_pet_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/calendar_widget.dart';
import 'package:petapp_mobile/views/widgets/confirm_popup_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:petapp_mobile/views/widgets/notification_popup_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class UpdatePetPage extends GetView<UpdatePetPageController> {
  const UpdatePetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get.parameters['petId'] != null) {
      controller.petId = int.parse(Get.parameters['petId']!);
    }

    controller.isLoadingData.value = true;

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      controller.petModel = await PetService.fetchPetById(
        jwt: controller.accountModel.jwtToken,
        petId: controller.petId.toString(),
      );

      controller
        ..petName.value = controller.petModel.name
        ..selectedGender.value = controller.petModel.gender
        ..dateOfBirthTime = controller.petModel.dob
        ..dayOfBirthText.value = FORMAT_DATE_TIME(
            dateTime: controller.petModel.dob, pattern: DATE_PATTERN_2)
        ..tmpDayOfBirthTimeText.value = controller.dayOfBirthText.value
        ..selectedFertility.value =
            controller.petModel.isFertility ? "YES" : "NO"
        ..color.value = controller.petModel.color ?? ""
        ..description.value = controller.petModel.description ?? ""
        ..isLoadingData.value = false;
    });

    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: [
          Column(
            children: [
              const UpdatePetTopWidget(),
              Obx(
                () => controller.isLoadingData.value
                    ? Expanded(child: LOADING_WIDGET())
                    : Expanded(
                        child: Column(
                          children: const [
                            UpdatePetBodyWidget(),
                            UpdatePetBottomWidget(),
                          ],
                        ),
                      ),
              ),
            ],
          ),
          Obx(
            () => controller.isShowCalendar.value
                ? CalendarWidget(
                    title: 'Date of birth',
                    onTapBackGround: () {
                      controller
                        ..tmpDayOfBirthTimeText.value =
                            controller.dayOfBirthText.value
                        ..tmpDateOfBirthTime = controller.dateOfBirthTime
                        ..isShowCalendar.value = false;
                    },
                    onSelectionChanged: (DateRangePickerSelectionChangedArgs
                        dateRangePickerSelectionChangedArgs) {
                      controller
                        ..tmpDateOfBirthTime = DateTime.parse(
                            dateRangePickerSelectionChangedArgs.value
                                .toString())
                        ..tmpDayOfBirthTimeText.value = FORMAT_DATE_TIME(
                            dateTime: controller.tmpDateOfBirthTime!,
                            pattern: DATE_PATTERN_2);
                    },
                    initialDisplayDate: <DateTime>() =>
                        controller.dateOfBirthTime,
                    initialSelectedDate: <DateTime>() =>
                        controller.dateOfBirthTime,
                    onTapCancel: () {
                      controller
                        ..tmpDayOfBirthTimeText.value =
                            controller.dayOfBirthText.value
                        ..tmpDateOfBirthTime = controller.dateOfBirthTime
                        ..isShowCalendar.value = false;
                    },
                    onTapOk: () {
                      controller
                        ..dateOfBirthTime = controller.tmpDateOfBirthTime
                        ..dayOfBirthText.value =
                            controller.tmpDayOfBirthTimeText.value
                        ..isShowCalendar.value = false;
                    },
                    isAvailableOkButton: <bool>() =>
                        controller.tmpDayOfBirthTimeText.value.isNotEmpty,
                    maxDate: DateTime.now(),
                  )
                : const SizedBox.shrink(),
          ),
          Obx(
            () => controller.isShowSuccessfullyPopup.value
                ? NotificationPopupWidget(
                    onTapBackground: () {},
                    onTapOk: () => Get
                      ..back()
                      ..find<PetDetailPageController>().update(),
                    content:
                        'Update pet ${controller.petName.value} successfully.',
                    isSuccessNotification: true,
                  )
                : const SizedBox.shrink(),
          ),
          Obx(
            () => controller.isShowConfirmPopup.value
                ? ConfirmPopupWidget(
                    onTapBackground: () {
                      controller.isShowConfirmPopup.value = false;
                    },
                    title: 'Update pet',
                    content:
                        'Are you sure to update pet ${controller.petName.value} ?',
                    onTapSubmit: () async {
                      controller
                        ..isShowConfirmPopup.value = false
                        ..isWaitingUpdatePet.value = true;
                      await PetService.updatePet(
                        jwt: controller.accountModel.jwtToken,
                        id: controller.petId,
                        ownerId: controller.accountModel.customerModel.id,
                        avatarFile: null,
                        avatarFilePath: controller.petModel.avatar,
                        name: controller.petName.value,
                        isSeed: controller.selectedFertility.value == 'YES',
                        gender: controller.selectedGender.value,
                        dob: controller.dateOfBirthTime!,
                        breedId: controller.petModel.breedId!,
                        status: 'NORMAL',
                        description: controller.description.value,
                        color: controller.color.value,
                        specialMarkings: controller.petModel.specialMarkings,
                      );

                      controller
                        ..isWaitingUpdatePet.value = false
                        ..isShowSuccessfullyPopup.value = true;
                    })
                : const SizedBox.shrink(),
          ),
          Obx(
            () => Visibility(
              visible: controller.isWaitingUpdatePet.value,
              child: Container(
                color: DARK_GREY_TRANSPARENT,
                child: LOADING_WIDGET(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
