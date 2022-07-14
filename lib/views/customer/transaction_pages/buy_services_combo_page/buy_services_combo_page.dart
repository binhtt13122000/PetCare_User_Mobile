import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/buy_services_combo_page_controller.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/buy_services_combo_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/buy_services_combo_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/calendar_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BuyServicesComboPage extends GetView<BuyServicesComboPageController> {
  const BuyServicesComboPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get.parameters['petId'] != null) {
      controller.initSelectedPetId = int.parse(Get.parameters['petId']!);
    }

    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: [
          Column(
            children: const [
              BuyServicesComboTopWidget(),
              BuyServicesComboBodyWidget(),
            ],
          ),
          Obx(
            () => Visibility(
              visible: controller.isShowCalendar.value,
              child: CalendarWidget(
                title: 'Register date',
                onTapBackGround: () {
                  controller
                    ..tmpRegisterDateText.value =
                        controller.registerDateText.value
                    ..tmpRegisterDate = controller.registerDate
                    ..isShowCalendar.value = false;
                },
                onSelectionChanged: (DateRangePickerSelectionChangedArgs
                    dateRangePickerSelectionChangedArgs) {
                  controller
                    ..tmpRegisterDate = DateTime.parse(
                        dateRangePickerSelectionChangedArgs.value.toString())
                    ..tmpRegisterDateText.value = FORMAT_DATE_TIME(
                        dateTime: controller.tmpRegisterDate!,
                        pattern: DATE_PATTERN_2);
                },
                initialDisplayDate: <DateTime>() => controller.registerDate,
                initialSelectedDate: <DateTime>() => controller.registerDate,
                onTapCancel: () {
                  controller
                    ..tmpRegisterDateText.value =
                        controller.registerDateText.value
                    ..tmpRegisterDate = controller.registerDate
                    ..isShowCalendar.value = false;
                },
                onTapOk: () {
                  controller
                    ..registerDate = controller.tmpRegisterDate
                    ..registerDateText.value =
                        controller.tmpRegisterDateText.value
                    ..isShowCalendar.value = false;
                },
                isAvailableOkButton: <bool>() =>
                    controller.tmpRegisterDateText.value.isNotEmpty,
                minDate: DateTime.now(),
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: controller.isWaitingLoadingDataForeground.value,
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
