import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/chatting_detail_page_controller.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CreateRequestWidget extends GetView<ChattingDetailPageController> {
  const CreateRequestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: controller.isShowCreateRequest.value,
        child: Stack(
          children: [
            InkWell(
              onTap: () => controller.isShowCreateRequest.value = false,
              child: Container(
                color: const Color.fromARGB(106, 198, 188, 201),
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: 300,
                    height: 470,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      color: WHITE_COLOR,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Create Transaction Request',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.quicksand(
                            color: PRIMARY_COLOR,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                        ),
                        transactionTimeWidget(),
                        transactionLocationWidget(
                            ownerAddress:
                                controller.accountModel.customerModel.address!),
                        descriptionWidget(),
                        sendRequestWidget(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            calendarWidget(),
          ],
        ),
      ),
    );
  }

  Widget sendRequestWidget() => Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: InkWell(
          onTap: () {
            controller.isShowCreateRequest.value = false;
          },
          child: Container(
            height: 35,
            decoration: BoxDecoration(
              color: PRIMARY_COLOR.withOpacity(0.9),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: PRIMARY_COLOR,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: DARK_GREY_COLOR.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Send request to seller',
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: GoogleFonts.quicksand(
                    color: WHITE_COLOR,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: SvgPicture.asset(
                    ICON_PATH + SEND_SVG,
                    height: 18,
                    color: WHITE_COLOR,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget transactionLocationWidget({required String ownerAddress}) {
    TextEditingController _textEditingController = TextEditingController();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: SvgPicture.asset(
                      ICON_PATH + LOCATION_SVG,
                      height: 20,
                      color: const Color.fromARGB(255, 61, 78, 100),
                    ),
                  ),
                  Text(
                    'Transaction location',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 61, 78, 100),
                      fontSize: 16,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    '*',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w800,
                      color: const Color.fromARGB(255, 241, 99, 88),
                      fontSize: 20,
                      height: 0.8,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 100,
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 167, 181, 201),
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Obx(
                    () => Container(
                      width: 20,
                      height: 20,
                      margin: const EdgeInsets.only(right: 5),
                      child: Checkbox(
                        value: controller.isUseOwnerAddress.value,
                        onChanged: (isCheck) {
                          controller.isUseOwnerAddress.value = isCheck!;
                          isCheck
                              ? _textEditingController.text = ownerAddress
                              : null;
                        },
                        activeColor: PRIMARY_COLOR,
                      ),
                    ),
                  ),
                  Text(
                    'Use owner address',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 85, 103, 128),
                      fontSize: 13,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      minLines: 3,
                      maxLines: 3,
                      controller: _textEditingController,
                      onChanged: (String text) {
                        controller.transactionLocation.value = text;
                      },
                      keyboardType: TextInputType.multiline,
                      cursorColor: PRIMARY_COLOR,
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 113, 135, 168),
                        fontSize: 15,
                        letterSpacing: 1,
                      ),
                      decoration: InputDecoration.collapsed(
                        hintText: 'Type transaction location here...',
                        hintStyle: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 162, 176, 194),
                          fontSize: 13,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget descriptionWidget() {
    TextEditingController _textEditingController = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            'Description',
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.w500,
              color: const Color.fromARGB(255, 61, 78, 100),
              fontSize: 16,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          height: 70,
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 167, 181, 201),
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  minLines: 3,
                  maxLines: 3,
                  controller: _textEditingController,
                  onChanged: (String text) {
                    controller.description.value = text;
                  },
                  keyboardType: TextInputType.multiline,
                  cursorColor: PRIMARY_COLOR,
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 113, 135, 168),
                    fontSize: 15,
                    letterSpacing: 1,
                  ),
                  decoration: InputDecoration.collapsed(
                    hintText: 'More information about the transaction...',
                    hintStyle: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 162, 176, 194),
                      fontSize: 13,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget transactionTimeWidget() => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: SvgPicture.asset(
                        ICON_PATH + CLOCK_SVG,
                        height: 17,
                        color: const Color.fromARGB(255, 61, 78, 100),
                      ),
                    ),
                    Text(
                      'Transaction time',
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 61, 78, 100),
                        fontSize: 16,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      '*',
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w800,
                        color: const Color.fromARGB(255, 241, 99, 88),
                        fontSize: 20,
                        height: 0.8,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => controller.isDisplayCalender.value = true,
            child: Container(
              height: 40,
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 167, 181, 201),
                  width: 1.2,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Obx(
                      () => controller.transactionTimeText.value.isEmpty
                          ? Text(
                              'dd/MM/yyyy',
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 162, 176, 194),
                                fontSize: 13,
                                letterSpacing: 1,
                              ),
                            )
                          : Text(
                              controller.transactionTimeText.value,
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 113, 135, 168),
                                fontSize: 15,
                                letterSpacing: 1,
                              ),
                            ),
                    ),
                  ),
                  const Icon(
                    Icons.calendar_month_rounded,
                    color: PRIMARY_COLOR,
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  Widget calendarWidget() => Obx(
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
                          controller.tmpTransactionTime = DateTime.parse(
                              dateRangePickerSelectionChangedArgs.value
                                  .toString());
                        },
                        selectionMode: DateRangePickerSelectionMode.single,
                        backgroundColor: WHITE_COLOR,
                        initialSelectedDate: controller.transactionTime,
                        initialDisplayDate: controller.transactionTime,
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
                              controller.tmpTransactionTime =
                                  controller.transactionTime;
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
                              controller.transactionTime =
                                  controller.tmpTransactionTime;
                              controller.transactionTimeText.value =
                                  FORMAT_DATE_TIME(
                                      dateTime: controller.transactionTime!,
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
