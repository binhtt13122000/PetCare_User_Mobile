import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/register_page_controller.dart';
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
            phoneNumberWidget(),
          ],
        ),
      );

  Widget decorateWidget() => Image.asset(
        IMAGE_PATH + LORETTA_PNG,
        height: 270,
        fit: BoxFit.cover,
      );

  Widget phoneNumberWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
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
              ),
              Expanded(
                child: SizedBox(
                  height: 75,
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 45,
                          child: TextFormField(
                            cursorColor: controller.phoneNumber.value.isEmpty &&
                                    !controller.isFirstInputPhoneNumber.value
                                ? const Color.fromARGB(255, 255, 83, 83)
                                : PRIMARY_COLOR,
                            initialValue: controller.phoneNumber.value,
                            maxLength: 12,
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 78, 98, 124),
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
                            decoration: controller.phoneNumber.value.isEmpty &&
                                    !controller.isFirstInputPhoneNumber.value
                                ? const InputDecoration(
                                    counterText: '',
                                    suffixIcon: Align(
                                      widthFactor: 1,
                                      heightFactor: 1,
                                      child: Icon(
                                        Icons.error,
                                        color: Color.fromARGB(255, 255, 83, 83),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(255, 255, 83, 83),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(255, 255, 83, 83),
                                      ),
                                    ),
                                  )
                                : InputDecoration(
                                    counterText: '',
                                    suffixIcon: Align(
                                      widthFactor: 1,
                                      heightFactor: 1,
                                      child: Text(
                                        (controller.phoneNumber.value.length)
                                                .toString() +
                                            '/12',
                                        style: GoogleFonts.quicksand(
                                          fontWeight: FontWeight.w500,
                                          color: const Color.fromARGB(
                                              255, 78, 98, 124),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 136, 154, 180),
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 136, 154, 180),
                                      ),
                                    ),
                                  ),
                            onChanged: (String? value) {
                              controller.phoneNumber.value = value ?? '';
                              controller.isFirstInputPhoneNumber.value = false;
                              controller.isUsedPhoneNumber.value = false;
                            },
                          ),
                        ),
                        Expanded(
                          child: Visibility(
                            visible: (controller.phoneNumber.value.isEmpty &&
                                    !controller
                                        .isFirstInputPhoneNumber.value) ||
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
}
