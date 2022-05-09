import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/register_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class RegisterPageBodyWidget extends GetView<RegisterPageController> {
  const RegisterPageBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    avatarWidget(),
                    firstNameWidget(),
                    lastNameWidget(),
                    genderWidget(),
                    phoneNumberWidget(),
                    emailWidget(),
                  ],
                ),
              ),
              Container(
                height: 1,
                margin: const EdgeInsets.only(top: 10),
                color: LIGHT_GREY_COLOR.withOpacity(0.1),
              ),
              Container(
                height: 8,
                color: const Color.fromARGB(255, 243, 247, 255),
              ),
              addressWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget avatarWidget() => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Stack(
          children: [
            GRADIENT_WIDGET(
              child: const CircleAvatar(
                maxRadius: 50,
                minRadius: 50,
              ),
            ),
            Obx(
              () => CircleAvatar(
                maxRadius: 50,
                minRadius: 50,
                backgroundColor: Colors.transparent,
                child: controller.avatarfilePath.value.isEmpty
                    ? const CircleAvatar(
                        backgroundImage:
                            AssetImage(IMAGE_PATH + GUEST_AVATAR_PNG),
                        maxRadius: 46,
                        minRadius: 46,
                      )
                    : CircleAvatar(
                        maxRadius: 46,
                        minRadius: 46,
                        backgroundImage: FileImage(controller.avatarFile!),
                      ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                onTap: () => controller.isSelectPickImageType.value = true,
                child: const CircleAvatar(
                  backgroundColor: Color.fromARGB(210, 193, 204, 233),
                  child: Icon(
                    Icons.camera_alt,
                    color: Color.fromARGB(255, 127, 137, 163),
                    size: 23,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget emailWidget() => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Row(
                children: [
                  Text(
                    'Email',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 61, 78, 100),
                      fontSize: 16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: Icon(
                      Icons.info_outline_rounded,
                      size: 15,
                      color: DARK_GREY_COLOR.withAlpha(100),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 45,
                child: TextFormField(
                  cursorColor: PRIMARY_COLOR,
                  initialValue: controller.email.value,
                  maxLength: 40,
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 78, 98, 124),
                    fontSize: 16,
                  ),
                  decoration: false
                      ? const InputDecoration(
                          errorText: 'The field title is required',
                          suffixIcon: Icon(
                            Icons.error,
                            color: Color.fromARGB(255, 241, 99, 88),
                            size: 20,
                          ),
                        )
                      : InputDecoration(
                          counterText: '',
                          suffixIcon: Align(
                            widthFactor: 1,
                            heightFactor: 1,
                            child: Text(
                              controller.email.value.length.toString() + '/40',
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 78, 98, 124),
                                fontSize: 13,
                              ),
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 136, 154, 180),
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 136, 154, 180),
                            ),
                          ),
                        ),
                  onChanged: (String? value) {
                    controller.email.value = value ?? '';
                  },
                ),
              ),
            ),
          ],
        ),
      );

  Widget addressWidget() => Padding(
        padding:
            const EdgeInsets.only(top: 20, bottom: 12, left: 12, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Text(
                    'Address',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 61, 78, 100),
                      fontSize: 16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: Icon(
                      Icons.info_outline_rounded,
                      size: 15,
                      color: DARK_GREY_COLOR.withAlpha(100),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 60,
              child: TextFormField(
                cursorColor: PRIMARY_COLOR,
                initialValue: controller.address.value,
                maxLength: 200,
                maxLines: 2,
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 138, 154, 175),
                  fontSize: 14,
                ),
                decoration: false
                    ? const InputDecoration(
                        errorText: 'The field title is required',
                        suffixIcon: Icon(
                          Icons.error,
                          color: Color.fromARGB(255, 241, 99, 88),
                          size: 20,
                        ),
                      )
                    : InputDecoration(
                        counterText: '',
                        suffixIcon: Container(
                          width: 30,
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5, right: 5),
                            child: Text(
                              controller.address.value.length.toString() +
                                  '/200',
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 78, 98, 124),
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 136, 154, 180),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 136, 154, 180),
                          ),
                        ),
                      ),
                onChanged: (String? value) {
                  controller.address.value = value ?? '';
                },
              ),
            ),
          ],
        ),
      );

  Widget genderWidget() => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gender',
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(255, 61, 78, 100),
                fontSize: 16,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Obx(
                () => Row(
                  children: [
                    genderItemWidget(
                      isChecked: controller.gender.value == 'MALE',
                      checkboxKey: 'Male',
                      onChange: () => controller.gender.value = 'MALE',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: genderItemWidget(
                        isChecked: controller.gender.value == 'FEMALE',
                        checkboxKey: 'Female',
                        onChange: () => controller.gender.value = 'FEMALE',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: genderItemWidget(
                        isChecked: controller.gender.value == 'OTHERS',
                        checkboxKey: 'Others',
                        onChange: () => controller.gender.value = 'OTHERS',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget genderItemWidget(
          {bool isChecked = false,
          required String checkboxKey,
          required Function() onChange}) =>
      Container(
        height: 40,
        padding: const EdgeInsets.only(right: 13.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border:
              Border.all(color: isChecked ? PRIMARY_COLOR : Colors.transparent),
        ),
        child: Row(
          children: [
            Checkbox(
              value: isChecked,
              checkColor: WHITE_COLOR,
              activeColor: PRIMARY_COLOR,
              onChanged: (bool? value) {
                onChange.call();
              },
            ),
            Text(
              checkboxKey,
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(255, 61, 78, 100),
                fontSize: 16,
              ),
            ),
          ],
        ),
      );

  Widget phoneNumberWidget() => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 25, bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Phone number',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 61, 78, 100),
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '*',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w800,
                      color: const Color.fromARGB(255, 241, 99, 88),
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                    height: 45,
                    child: TextFormField(
                      cursorColor: PRIMARY_COLOR,
                      initialValue: controller.phoneNumber.value,
                      maxLength: 15,
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 78, 98, 124),
                        fontSize: 16,
                      ),
                      decoration: false
                          ? const InputDecoration(
                              errorText: 'The field title is required',
                              suffixIcon: Icon(
                                Icons.error,
                                color: Color.fromARGB(255, 241, 99, 88),
                                size: 20,
                              ),
                            )
                          : InputDecoration(
                              counterText: '',
                              suffixIcon: Align(
                                widthFactor: 1,
                                heightFactor: 1,
                                child: Text(
                                  controller.phoneNumber.value.length
                                          .toString() +
                                      '/15',
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.w500,
                                    color:
                                        const Color.fromARGB(255, 78, 98, 124),
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 136, 154, 180),
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 136, 154, 180),
                                ),
                              ),
                            ),
                      onChanged: (String? value) {
                        controller.phoneNumber.value = value ?? '';
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget firstNameWidget() => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'First name',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 61, 78, 100),
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '*',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w800,
                      color: const Color.fromARGB(255, 241, 99, 88),
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 45,
                child: TextFormField(
                  cursorColor: PRIMARY_COLOR,
                  initialValue: controller.firstName.value,
                  maxLength: 40,
                  maxLines: 1,
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 78, 98, 124),
                    fontSize: 16,
                  ),
                  decoration: false
                      ? const InputDecoration(
                          errorText: 'The field title is required',
                          suffixIcon: Icon(
                            Icons.error,
                            color: Color.fromARGB(255, 241, 99, 88),
                            size: 20,
                          ),
                        )
                      : InputDecoration(
                          counterText: '',
                          suffixIcon: Container(
                            width: 30,
                            alignment: Alignment.centerRight,
                            margin: const EdgeInsets.only(right: 5),
                            child: Text(
                              controller.firstName.value.length.toString() +
                                  '/40',
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 78, 98, 124),
                                fontSize: 13,
                              ),
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 136, 154, 180),
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 136, 154, 180),
                            ),
                          ),
                        ),
                  onChanged: (String? value) {
                    controller.firstName.value = value ?? '';
                  },
                ),
              ),
            ),
          ],
        ),
      );

  Widget lastNameWidget() => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Last name',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 61, 78, 100),
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '*',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w800,
                      color: const Color.fromARGB(255, 241, 99, 88),
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 45,
                child: TextFormField(
                  cursorColor: PRIMARY_COLOR,
                  initialValue: controller.lastName.value,
                  maxLength: 40,
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 78, 98, 124),
                    fontSize: 16,
                  ),
                  decoration: false
                      ? const InputDecoration(
                          errorText: 'The field title is required',
                          suffixIcon: Icon(
                            Icons.error,
                            color: Color.fromARGB(255, 241, 99, 88),
                            size: 20,
                          ),
                        )
                      : InputDecoration(
                          counterText: '',
                          suffixIcon: Align(
                            widthFactor: 1,
                            heightFactor: 1,
                            child: Text(
                              controller.lastName.value.length.toString() +
                                  '/40',
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 78, 98, 124),
                                fontSize: 13,
                              ),
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 136, 154, 180),
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 136, 154, 180),
                            ),
                          ),
                        ),
                  onChanged: (String? value) {
                    controller.lastName.value = value ?? '';
                  },
                ),
              ),
            ),
          ],
        ),
      );
}
