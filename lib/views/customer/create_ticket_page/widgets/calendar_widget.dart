import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/ticket_page_controller.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CreateTicketCalendarWidget extends GetView<CreateTicketPageController> {
  const CreateTicketCalendarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Obx(
        () => Visibility(
          visible: controller.isDisplayCalender.value,
          child: InkWell(
            onTap: () {
              controller.isDisplayCalender.value = false;
            },
            child: Container(
              color: DARK_GREY_TRANSPARENT,
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: 400,
                  width: 340,
                  decoration: BoxDecoration(
                    color: WHITE_COLOR,
                    borderRadius: BorderRadius.circular(10),
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
                              'Date booking',
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                            CUSTOM_TEXT(
                              '*',
                              color: RED_COLOR,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
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
                              onSelectionChanged:
                                  (DateRangePickerSelectionChangedArgs
                                      dateRangePickerSelectionChangedArgs) {
                                controller.tmpBookingServicesDate =
                                    DateTime.parse(
                                        dateRangePickerSelectionChangedArgs
                                            .value
                                            .toString());
                              },
                              selectionMode:
                                  DateRangePickerSelectionMode.single,
                              backgroundColor: WHITE_COLOR,
                              initialSelectedDate:
                                  controller.bookingServicesDate,
                              initialDisplayDate:
                                  controller.bookingServicesDate,
                              // enablePastDates: false,
                              minDate:
                                  DateTime.now().add(const Duration(days: 1)),
                              maxDate:
                                  DateTime.now().add(const Duration(days: 5)),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 12),
                        decoration: const BoxDecoration(
                          color: WHITE_COLOR,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: MaterialButton(
                                onPressed: () {
                                  controller.tmpBookingServicesDate =
                                      controller.bookingServicesDate;
                                  controller.isDisplayCalender.value = false;
                                },
                                color: PRIMARY_LIGHT_COLOR,
                                child: Text(
                                  'Cancel',
                                  style: GoogleFonts.quicksand(
                                    color: PRIMARY_COLOR,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            Expanded(
                              child: MaterialButton(
                                onPressed: () {
                                  controller
                                    ..bookingServicesDate =
                                        controller.tmpBookingServicesDate
                                    ..bookingServicesDateText.value =
                                        FORMAT_DATE_TIME(
                                            dateTime:
                                                controller.bookingServicesDate,
                                            pattern: DATE_PATTERN_2)
                                    ..isDisplayCalender.value = false
                                    ..update();
                                },
                                color: PRIMARY_COLOR,
                                child: Text(
                                  'OK',
                                  style: GoogleFonts.quicksand(
                                    color: WHITE_COLOR,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
