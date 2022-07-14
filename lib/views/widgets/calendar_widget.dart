import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({
    Key? key,
    required this.onTapBackGround,
    required this.onSelectionChanged,
    required this.initialSelectedDate,
    required this.initialDisplayDate,
    required this.title,
    this.isRequired = true,
    required this.onTapCancel,
    required this.onTapOk,
    required this.isAvailableOkButton,
    this.minDate,
    this.maxDate,
  }) : super(key: key);
  final Function<DateTime>() initialSelectedDate;
  final Function<DateTime>() initialDisplayDate;
  final Function() onTapBackGround;
  final Function() onTapCancel;
  final Function() onTapOk;
  final Function<bool>() isAvailableOkButton;
  final DateTime? minDate;
  final DateTime? maxDate;
  final String title;
  final bool isRequired;
  final Function(
      DateRangePickerSelectionChangedArgs
          dateRangePickerSelectionChangedArgs) onSelectionChanged;
  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTapBackGround,
        child: Container(
          color: DARK_GREY_TRANSPARENT,
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {},
            child: Container(
              height: 380,
              width: 310,
              decoration: BoxDecoration(
                color: WHITE_COLOR,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: DARK_GREY_COLOR.withOpacity(0.2),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CUSTOM_TEXT(
                          title,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          letterSpacing: 1.5,
                        ),
                        Visibility(
                          visible: isRequired,
                          child: CUSTOM_TEXT(
                            '*',
                            color: RED_COLOR,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: BLUE_COLOR.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SfDateRangePicker(
                          onSelectionChanged: onSelectionChanged,
                          selectionMode: DateRangePickerSelectionMode.single,
                          backgroundColor: WHITE_COLOR,
                          initialSelectedDate: initialSelectedDate.call(),
                          initialDisplayDate: initialDisplayDate.call(),
                          minDate: minDate,
                          maxDate: maxDate,
                        ),
                      ),
                    ),
                  ),
                  bottomButtonWidget(),
                ],
              ),
            ),
          ),
        ),
      );

  Widget bottomButtonWidget() => Container(
        margin: const EdgeInsets.only(top: 20),
        height: 40,
        child: Column(
          children: [
            Container(
              height: 1.5,
              color: LIGHT_GREY_COLOR.withAlpha(30),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: onTapBackGround,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: WHITE_COLOR,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CUSTOM_TEXT(
                              'CANCEL',
                              textAlign: TextAlign.start,
                              color: PRIMARY_COLOR,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 2,
                    color: LIGHT_GREY_COLOR.withAlpha(30),
                  ),
                  Obx(
                    () => Expanded(
                      child: InkWell(
                        onTap: isAvailableOkButton.call() ? onTapOk : () {},
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isAvailableOkButton.call()
                                ? PRIMARY_COLOR.withOpacity(0.9)
                                : PRIMARY_COLOR.withOpacity(0.3),
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CUSTOM_TEXT(
                                'OK',
                                textAlign: TextAlign.start,
                                color: WHITE_COLOR,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
