import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/add_pet_page_controller.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_management_page_controller.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/customer/pet_pages/create_pet_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/create_pet_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/create_pet_page/widgets/loading_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/create_pet_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/calendar_widget.dart';
import 'package:petapp_mobile/views/widgets/notification_popup_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CreatePetPage extends GetView<CreatePetPageController> {
  const CreatePetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: [
          Column(
            children: const [
              CreatePetTopWidget(),
              CreatePetBodyWidget(),
              CreatePetBottomWidget(),
            ],
          ),
          const CreatePetLoadingWidget(),
          Obx(
            () => Visibility(
              visible: controller.isShowCalendar.value,
              child: CalendarWidget(
                title: 'Date of birth',
                onTapBackGround: () {
                  controller
                    ..tmpDayOfBirthText.value = controller.dayOfBirthText.value
                    ..tmpDateOfBirthTime = controller.dateOfBirthTime
                    ..isShowCalendar.value = false;
                },
                onSelectionChanged: (DateRangePickerSelectionChangedArgs
                    dateRangePickerSelectionChangedArgs) {
                  controller
                    ..tmpDateOfBirthTime = DateTime.parse(
                        dateRangePickerSelectionChangedArgs.value.toString())
                    ..tmpDayOfBirthText.value = FORMAT_DATE_TIME(
                        dateTime: controller.tmpDateOfBirthTime!,
                        pattern: DATE_PATTERN_2);
                },
                initialDisplayDate: <DateTime>() => controller.dateOfBirthTime,
                initialSelectedDate: <DateTime>() => controller.dateOfBirthTime,
                onTapCancel: () {
                  controller
                    ..tmpDayOfBirthText.value = controller.dayOfBirthText.value
                    ..tmpDateOfBirthTime = controller.dateOfBirthTime
                    ..isShowCalendar.value = false;
                },
                onTapOk: () {
                  controller
                    ..dateOfBirthTime = controller.tmpDateOfBirthTime
                    ..dayOfBirthText.value = controller.tmpDayOfBirthText.value
                    ..isShowCalendar.value = false;
                },
                isAvailableOkButton: <bool>() =>
                    controller.tmpDayOfBirthText.value.isNotEmpty,
                maxDate: DateTime.now(),
              ),
            ),
          ),
          Obx(
            () => controller.isShowSuccessfullyPopup.value
                ? NotificationPopupWidget(
                    onTapBackground: () {},
                    onTapOk: () {
                      if (controller.isSuccessCreate) {
                        Get
                          ..back()
                          ..find<PetManagementPageController>().update();
                      } else {
                        controller.isShowSuccessfullyPopup.value = false;
                      }
                    },
                    content: controller.isSuccessCreate
                        ? 'Create pet ${controller.petName} successfully.'
                        : 'Create pet ${controller.petName} failed, pet name already used.\n Please try another name.',
                    isSuccessNotification: controller.isSuccessCreate,
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
