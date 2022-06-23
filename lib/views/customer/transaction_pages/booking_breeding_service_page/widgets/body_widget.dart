import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/booking_breeding_service_page_controller.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/booking_breeding_service_page/widgets/select_branch_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class BookingBreedingServicesBodyWidget
    extends GetView<BookingBreedingServicesPageController> {
  const BookingBreedingServicesBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: SUPPER_LIGHT_BLUE,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                color: WHITE_COLOR,
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 12),
                child: Row(
                  children: [
                    registerDateTitleWidget(),
                    Expanded(child: bookingDateWidget()),
                  ],
                ),
              ),
              Container(
                color: WHITE_COLOR,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  height: 1,
                  color: LIGHT_GREY_COLOR.withAlpha(30),
                ),
              ),
              Container(
                height: 10,
                color: WHITE_COLOR,
              ),
              const BookingBreedingServicesSelectBranchWidget(),
              Container(
                height: 1,
                color: LIGHT_GREY_COLOR.withAlpha(30),
              ),
              servicesInformationWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget servicesInformationWidget() => Container(
        color: WHITE_COLOR,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 12),
        child: Column(
          children: [
            CUSTOM_TEXT(
              'Services List',
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CUSTOM_TEXT('1.'),
                CUSTOM_TEXT('Breeding services'),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CUSTOM_TEXT('2.'),
                CUSTOM_TEXT('Ultrasound'),
              ],
            ),
          ],
        ),
      );

  Widget registerDateTitleWidget() => Row(
        children: [
          CUSTOM_TEXT(
            'Register date',
            fontSize: 15,
          ),
          CUSTOM_TEXT(
            '*',
            color: RED_COLOR,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ],
      );

  Widget bookingDateWidget() => Padding(
        padding: const EdgeInsets.only(left: 20),
        child: InkWell(
          onTap: () => controller.isDisplayCalender.value = true,
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 167, 181, 201),
                width: 1.2,
              ),
              borderRadius: BorderRadius.circular(5),
              color: WHITE_COLOR,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Obx(
                      () => CUSTOM_TEXT(
                          controller.bookingServicesDateText.value.isNotEmpty
                              ? controller.bookingServicesDateText.value
                              : 'dd/MM/yyyy',
                          textAlign: TextAlign.left,
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                          fontSize: 15),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.calendar_month_rounded,
                    color: PRIMARY_COLOR,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
