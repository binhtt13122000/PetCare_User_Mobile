import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/other_controllers/personal_information_page_controller.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PersonalInformationBodyWidget
    extends GetView<PersonalInformationPageController> {
  const PersonalInformationBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        avatarWidget(),
        Padding(
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  children: [
                    bankNameWidget(),
                    bankBranchWidget(),
                    bankCodeWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget bankCodeWidget() => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 45,
              padding: const EdgeInsets.only(
                right: 30,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Bank code',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 61, 78, 100),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CUSTOM_REQUIRED_TEXT_FIELD(
                hintText: 'Type your bank code here...',
                maxLength: 30,
                onChange: (String? text) {
                  controller.bankCode.value = text ?? '';
                },
                checkEmptyString: <bool>() {
                  return controller.bankCode.value.isEmpty;
                },
                checkErrorText: <bool>() {
                  return false;
                },
                onDelete: () {
                  controller.bankCode.value = '';
                },
                errorText: 'Field first name is required!',
                initText: controller.bankCode.value,
                countText: <String>() {
                  return controller.bankCode.value.length.toString() + '/30';
                },
              ),
            ),
          ],
        ),
      );

  Widget bankBranchWidget() => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 45,
              padding: const EdgeInsets.only(
                right: 15,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Bank branch',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 61, 78, 100),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CUSTOM_REQUIRED_TEXT_FIELD(
                hintText: 'Type your bank branch here...',
                maxLength: 30,
                onChange: (String? text) {
                  controller.bankBranch.value = text ?? '';
                },
                checkEmptyString: <bool>() {
                  return controller.bankBranch.value.isEmpty;
                },
                checkErrorText: <bool>() {
                  return false;
                },
                onDelete: () {
                  controller.bankBranch.value = '';
                },
                errorText: '',
                initText: controller.bankBranch.value,
                countText: <String>() {
                  return controller.bankBranch.value.length.toString() + '/30';
                },
              ),
            ),
          ],
        ),
      );

  Widget bankNameWidget() => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 45,
              padding: const EdgeInsets.only(
                right: 25,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Bank name',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 61, 78, 100),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CUSTOM_REQUIRED_TEXT_FIELD(
                hintText: 'Type your bank name here...',
                maxLength: 30,
                onChange: (String? text) {
                  controller.bankName.value = text ?? '';
                },
                checkEmptyString: <bool>() {
                  return controller.bankName.value.isEmpty;
                },
                checkErrorText: <bool>() {
                  return false;
                },
                onDelete: () {
                  controller.bankName.value = '';
                },
                errorText: '',
                initText: controller.bankName.value,
                countText: <String>() {
                  return controller.bankName.value.length.toString() + '/30';
                },
              ),
            ),
          ],
        ),
      );

  Widget avatarWidget() => Stack(
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
              child: (controller.accountModel.customerModel.avatar == null ||
                          controller
                              .accountModel.customerModel.avatar!.isEmpty) &&
                      controller.avatarFilePath.value.isEmpty
                  ? CircleAvatar(
                      backgroundColor: PRIMARY_COLOR.withOpacity(0.7),
                      maxRadius: 46,
                      minRadius: 46,
                      child: Text(
                        controller.avatarCharacter.value,
                        style: GoogleFonts.quicksand(
                          color: WHITE_COLOR,
                          fontSize: 27,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : controller.avatarFilePath.value.isEmpty
                      ? CircleAvatar(
                          maxRadius: 46,
                          minRadius: 46,
                          backgroundImage: NetworkImage(
                              controller.accountModel.customerModel.avatar!),
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
              onTap: () async {
                controller.avatarFile =
                    await PICK_IMAGE(isPickFromGalley: true);
                controller.avatarFile != null
                    ? controller.avatarFilePath.value =
                        controller.avatarFile!.path
                    : null;
              },
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
      );

  Widget emailWidget() => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 45,
              padding: const EdgeInsets.only(
                right: 25,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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
              child: CUSTOM_REQUIRED_TEXT_FIELD(
                hintText: 'Type your email here...',
                maxLength: 30,
                onChange: (String? text) {
                  controller.email.value = text ?? '';
                },
                checkEmptyString: <bool>() {
                  return controller.email.value.isEmpty;
                },
                checkErrorText: <bool>() {
                  return false;
                },
                onDelete: () {
                  controller.email.value = '';
                },
                errorText: '',
                initText: controller.email.value,
                countText: <String>() {
                  return controller.email.value.length.toString() + '/30';
                },
              ),
            ),
          ],
        ),
      );

  Widget firstNameWidget() => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 45,
              padding: const EdgeInsets.only(
                right: 25,
              ),
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
              child: CUSTOM_REQUIRED_TEXT_FIELD(
                hintText: 'Type your first name here...',
                maxLength: 20,
                onChange: (String? text) {
                  controller.firstName.value = text ?? '';
                },
                checkEmptyString: <bool>() {
                  return controller.firstName.value.isEmpty;
                },
                checkErrorText: <bool>() {
                  return controller.firstName.value.isEmpty;
                },
                onDelete: () {
                  controller.firstName.value = '';
                },
                errorText: 'Field first name is required!',
                initText: controller.firstName.value,
                countText: <String>() {
                  return controller.firstName.value.length.toString() + '/20';
                },
              ),
            ),
          ],
        ),
      );

  Widget addressWidget() => Padding(
        padding: const EdgeInsets.only(top: 20, left: 12, right: 12),
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
            CUSTOM_REQUIRED_TEXT_FIELD(
              hintText: 'Type your address here...',
              maxLength: 200,
              height: 80,
              maxLines: 3,
              onChange: (String? text) {
                controller.address.value = text ?? '';
              },
              checkEmptyString: <bool>() {
                return controller.address.value.isEmpty;
              },
              checkErrorText: <bool>() {
                return false;
              },
              onDelete: () {
                controller.address.value = '';
              },
              errorText: '',
              initText: controller.address.value,
              countText: <String>() {
                return controller.address.value.length.toString() + '/200';
              },
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
              child: CUSTOM_DISABLE_TEXT_FIELD(
                initText: controller.accountModel.phoneNumber,
                textInputFormatter: CustomTextFormatter(
                    sample: 'xxx xx xxx xx xx', separator: ' '),
              ),
            ),
          ],
        ),
      );

  Widget lastNameWidget() => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 45,
              padding: const EdgeInsets.only(
                right: 25,
              ),
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
              child: CUSTOM_REQUIRED_TEXT_FIELD(
                hintText: 'Type your last name here...',
                maxLength: 20,
                onChange: (String? text) {
                  controller.lastName.value = text ?? '';
                },
                checkEmptyString: <bool>() {
                  return controller.lastName.value.isEmpty;
                },
                checkErrorText: <bool>() {
                  return controller.lastName.value.isEmpty;
                },
                onDelete: () {
                  controller.lastName.value = '';
                },
                errorText: 'Field last name is required!',
                initText: controller.lastName.value,
                countText: <String>() {
                  return controller.lastName.value.length.toString() + '/20';
                },
              ),
            ),
          ],
        ),
      );
}
