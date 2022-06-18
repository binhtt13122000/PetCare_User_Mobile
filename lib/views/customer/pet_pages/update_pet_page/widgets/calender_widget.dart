import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/update_pet_page_controller.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class UpdatePetCalenderWidget extends GetView<UpdatePetPageController> {
  const UpdatePetCalenderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Obx(
        () => Visibility(
          visible: controller.isDisplayCalender.value,
          child: InkWell(
            onTap: () {
              controller.isDisplayCalender.value = false;
            },
            child: Container(
              color: const Color.fromARGB(106, 198, 188, 201),
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 250,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                      child: SfDateRangePicker(
                        onSelectionChanged: (DateRangePickerSelectionChangedArgs
                            dateRangePickerSelectionChangedArgs) {
                          controller.tmpDateOfBirthTime = DateTime.parse(
                              dateRangePickerSelectionChangedArgs.value
                                  .toString());
                        },
                        selectionMode: DateRangePickerSelectionMode.single,
                        backgroundColor: WHITE_COLOR,
                        initialSelectedDate: controller.dateOfBirthTime,
                        initialDisplayDate: controller.dateOfBirthTime,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      decoration: const BoxDecoration(
                        color: WHITE_COLOR,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MaterialButton(
                            onPressed: () {
                              controller.tmpDateOfBirthTime =
                                  controller.dateOfBirthTime;
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
                          MaterialButton(
                            onPressed: () {
                              controller.dateOfBirthTime =
                                  controller.tmpDateOfBirthTime;
                              controller.dayOfBirthText.value =
                                  FORMAT_DATE_TIME(
                                      dateTime: controller.dateOfBirthTime!,
                                      pattern: DATE_PATTERN_2);
                              controller.isDisplayCalender.value = false;
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
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
