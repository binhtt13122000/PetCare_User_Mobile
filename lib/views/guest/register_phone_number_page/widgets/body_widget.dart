import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/guest_page_controllers/register_page_controller.dart';
import 'package:petapp_mobile/utilities/utilities.dart';

class RegisterPhoneNumberPageBodyWidget
    extends GetView<RegisterPageController> {
  const RegisterPhoneNumberPageBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            decorateWidget(),
            inputWidget(),
          ],
        ),
      );

  Widget decorateWidget() => Image.asset(
        IMAGE_PATH + LORETTA_PNG,
        height: 270,
        fit: BoxFit.cover,
      );

  Widget signInTitleWidget() => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 25, bottom: 10),
            child: Row(
              children: [
                Text(
                  'Register',
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w700,
                    color: PRIMARY_COLOR,
                    fontSize: 25,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Type your phone number to register',
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 78, 96, 121),
                    fontSize: 15,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  Widget areaCodeWidget() => Obx(
        () => Container(
          height: 45,
          margin: const EdgeInsets.only(right: 15),
          padding: const EdgeInsets.only(left: 10, right: 3),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 136, 154, 180),
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: DropdownButton<String>(
            value: controller.selectedAreaCode.value,
            style: GoogleFonts.quicksand(
              color: PRIMARY_COLOR,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
            underline: const SizedBox.shrink(),
            onChanged: (String? value) {
              controller.selectedAreaCode.value = value!;
            },
            items: controller.areaCodeMap.entries
                .map(
                  (e) => DropdownMenuItem(
                    child: Row(
                      children: [
                        Image.asset(
                          IMAGE_PATH + e.key,
                          height: 30,
                        ),
                        Text(' ' + e.value),
                      ],
                    ),
                    value: e.value,
                  ),
                )
                .toList(),
          ),
        ),
      );

  Widget inputWidget() => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            signInTitleWidget(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                areaCodeWidget(),
                phoneNumberWidget(),
              ],
            ),
          ],
        ),
      );

  Widget phoneNumberWidget() => Expanded(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 45,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: (controller.phoneNumber.value.isEmpty &&
                                !controller.isFirstInputPhoneNumber) ||
                            controller.isUsedPhoneNumber.value
                        ? RED_COLOR
                        : const Color.fromARGB(255, 136, 154, 180),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.textEditingController,
                        cursorColor: controller.phoneNumber.value.isEmpty &&
                                !controller.isFirstInputPhoneNumber
                            ? RED_COLOR
                            : PRIMARY_COLOR,
                        maxLength: 12,
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w500,
                          color: DARK_GREY_TEXT_COLOR,
                          fontSize: 16,
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: false, signed: false),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(
                              r'[0-9 ]',
                            ),
                          ),
                          CustomTextFormatter(
                              sample: 'xx xxx xx xx', separator: ' '),
                        ],
                        decoration: InputDecoration(
                          hintText: 'Type your phone number here...',
                          hintStyle: GoogleFonts.quicksand(
                            fontSize: 12,
                            color: DARK_GREY_TEXT_COLOR.withOpacity(0.6),
                            fontWeight: FontWeight.w500,
                          ),
                          counterText: '',
                          isCollapsed: true,
                          border: InputBorder.none,
                        ),
                        onChanged: (String? value) {
                          controller
                            ..phoneNumber.value = value ?? ''
                            ..isFirstInputPhoneNumber = false
                            ..isUsedPhoneNumber.value = false;
                        },
                      ),
                    ),
                    Obx(
                      () => Visibility(
                        visible: controller.phoneNumber.isNotEmpty,
                        child: InkWell(
                          onTap: () => controller
                            ..phoneNumber.value = ''
                            ..isFirstInputPhoneNumber = true
                            ..textEditingController.text = '',
                          child: CircleAvatar(
                            backgroundColor: RED_COLOR.withOpacity(0.9),
                            maxRadius: 10,
                            child: SvgPicture.asset(
                              ICON_PATH + CLOSE_SVG,
                              height: 10,
                              color: WHITE_COLOR,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: (controller.phoneNumber.value.isEmpty &&
                        !controller.isFirstInputPhoneNumber) ||
                    controller.isUsedPhoneNumber.value,
                child: Text(
                  controller.isUsedPhoneNumber.value
                      ? 'This phone number has been used!'
                      : 'Phone number field is required!',
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 255, 83, 83),
                    fontSize: 10,
                    letterSpacing: 1,
                    height: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
