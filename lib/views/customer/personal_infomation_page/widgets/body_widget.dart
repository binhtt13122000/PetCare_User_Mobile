import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/personal_information_page_controller.dart';

class PersonalInformationBodyWidget
    extends GetView<PersonalInfomationPageController> {
  const PersonalInformationBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
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
            color: const Color.fromARGB(255, 247, 248, 250),
          ),
          addressWidget(),
          saveWidget(),
        ],
      ),
    );
  }

  Widget saveWidget() => Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: Container(
          height: 45,
          decoration: BoxDecoration(
              color: PRIMARY_COLOR.withOpacity(0.9),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: DARK_GREY_COLOR.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(2, 2),
                ),
              ],
              border: Border.all(color: PRIMARY_COLOR)),
          alignment: Alignment.center,
          child: Text(
            'SAVE',
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.w500,
              color: WHITE_COLOR,
              fontSize: 16,
            ),
          ),
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
                  initialValue: controller.accountModel.email,
                  maxLength: 40,
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 78, 98, 124),
                    fontSize: 16,
                  ),
                  decoration: controller.accountModel.email!.isEmpty
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
                              controller.accountModel.email!.length.toString() +
                                  '/40',
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 78, 98, 124),
                                fontSize: 13,
                              ),
                            ),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                  onChanged: (String? value) {},
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
              height: 100,
              child: TextFormField(
                cursorColor: PRIMARY_COLOR,
                initialValue: 'No 157/265',
                maxLength: 200,
                maxLines: 3,
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 138, 154, 175),
                  fontSize: 16,
                ),
                decoration: controller.accountModel.phoneNumber.isEmpty
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
                              controller.accountModel.phoneNumber.length
                                      .toString() +
                                  '/200',
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 78, 98, 124),
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                onChanged: (String? value) {},
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
                      isChecked: controller.selectedGender.value == 'MALE',
                      checkboxKey: 'Male',
                      onChange: () => controller.selectedGender.value = 'MALE',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: genderItemWidget(
                        isChecked: controller.selectedGender.value == 'FEMALE',
                        checkboxKey: 'Female',
                        onChange: () =>
                            controller.selectedGender.value = 'FEMALE',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: genderItemWidget(
                        isChecked: controller.selectedGender.value == 'OTHERS',
                        checkboxKey: 'Others',
                        onChange: () =>
                            controller.selectedGender.value = 'OTHERS',
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
            Expanded(
              child: SizedBox(
                height: 45,
                child: TextFormField(
                  cursorColor: PRIMARY_COLOR,
                  initialValue: controller.accountModel.phoneNumber,
                  maxLength: 15,
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 78, 98, 124),
                    fontSize: 16,
                  ),
                  decoration: controller.accountModel.phoneNumber.isEmpty
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
                              controller.accountModel.phoneNumber.length
                                      .toString() +
                                  '/15',
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 78, 98, 124),
                                fontSize: 13,
                              ),
                            ),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                  onChanged: (String? value) {},
                ),
              ),
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
                  initialValue: controller.accountModel.customerModel.firstName,
                  maxLength: 40,
                  maxLines: 1,
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 78, 98, 124),
                    fontSize: 16,
                  ),
                  decoration: controller
                          .accountModel.customerModel.firstName.isEmpty
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
                              controller.accountModel.customerModel.firstName
                                      .length
                                      .toString() +
                                  '/40',
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 78, 98, 124),
                                fontSize: 13,
                              ),
                            ),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                  onChanged: (String? value) {},
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
                  initialValue: controller.accountModel.customerModel.lastName,
                  maxLength: 40,
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 78, 98, 124),
                    fontSize: 16,
                  ),
                  decoration: controller
                          .accountModel.customerModel.lastName.isEmpty
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
                              controller.accountModel.customerModel.lastName
                                      .length
                                      .toString() +
                                  '/40',
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 78, 98, 124),
                                fontSize: 13,
                              ),
                            ),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                  onChanged: (String? value) {},
                ),
              ),
            ),
          ],
        ),
      );
}
