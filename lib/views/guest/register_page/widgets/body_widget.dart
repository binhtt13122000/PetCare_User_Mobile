import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/guest_page_controllers/register_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class RegisterPageBodyWidget extends GetView<RegisterPageController> {
  const RegisterPageBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 20,
              color: SUPPER_LIGHT_BLUE,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  avatarWidget(),
                  firstNameWidget(),
                  lastNameWidget(),
                  genderWidget(),
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
    );
  }

  Widget avatarWidget() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
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
                child: controller.avatarFilePath.value.isEmpty
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

  Widget emailWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CUSTOM_TEXT(
                'Email',
                fontWeight: FontWeight.w500,
                color: DARK_GREY_TEXT_COLOR.withOpacity(0.95),
              ),
            ],
          ),
          CUSTOM_REQUIRED_TEXT_FIELD(
              hintText: 'Type your email here...',
              maxLength: 40,
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
              countText: <String>() {
                return controller.email.value.length.toString() + '/40';
              },
              padding: const EdgeInsets.only(top: 5)),
        ],
      );

  Widget addressWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Text(
                'Address',
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 61, 78, 100),
                  fontSize: 16,
                  letterSpacing: 0.5,
                ),
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
                countText: <String>() {
                  return controller.address.value.length.toString() + '/200';
                },
                padding: const EdgeInsets.only(top: 5)),
          ],
        ),
      );

  Widget genderWidget() => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CUSTOM_TEXT(
              'Gender',
              fontWeight: FontWeight.w500,
              color: DARK_GREY_TEXT_COLOR.withOpacity(0.95),
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
            CUSTOM_TEXT(
              checkboxKey,
              fontWeight: FontWeight.w500,
              color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
              letterSpacing: 0,
            )
          ],
        ),
      );

  Widget firstNameWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CUSTOM_TEXT(
                'First name',
                fontWeight: FontWeight.w500,
                color: DARK_GREY_TEXT_COLOR.withOpacity(0.95),
              ),
              CUSTOM_TEXT(
                '*',
                fontWeight: FontWeight.w500,
                color: RED_COLOR,
                fontSize: 20,
              ),
            ],
          ),
          CUSTOM_REQUIRED_TEXT_FIELD(
              hintText: 'Type your first name here...',
              maxLength: 20,
              onChange: (String? text) {
                controller
                  ..firstName.value = text ?? ''
                  ..isFirstInputFirstName = false;
              },
              checkEmptyString: <bool>() {
                return controller.firstName.value.isEmpty;
              },
              checkErrorText: <bool>() {
                return controller.firstName.value.isEmpty &&
                    !controller.isFirstInputFirstName;
              },
              onDelete: () {
                controller.firstName.value = '';
              },
              errorText: 'Field first name is required!',
              countText: <String>() {
                return controller.firstName.value.length.toString() + '/20';
              },
              padding: const EdgeInsets.only(top: 5)),
        ],
      );

  Widget lastNameWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CUSTOM_TEXT(
                'Last name',
                fontWeight: FontWeight.w500,
                color: DARK_GREY_TEXT_COLOR.withOpacity(0.95),
              ),
              CUSTOM_TEXT(
                '*',
                fontWeight: FontWeight.w500,
                color: RED_COLOR,
                fontSize: 20,
              ),
            ],
          ),
          CUSTOM_REQUIRED_TEXT_FIELD(
              hintText: 'Type your last name here...',
              maxLength: 20,
              onChange: (String? text) {
                controller
                  ..lastName.value = text ?? ''
                  ..isFirstInputLastName = false;
              },
              checkEmptyString: <bool>() {
                return controller.lastName.value.isEmpty;
              },
              checkErrorText: <bool>() {
                return controller.lastName.value.isEmpty &&
                    !controller.isFirstInputLastName;
              },
              onDelete: () {
                controller.lastName.value = '';
              },
              errorText: 'Field last name is required!',
              countText: <String>() {
                return controller.lastName.value.length.toString() + '/20';
              },
              padding: const EdgeInsets.only(top: 5)),
        ],
      );
}
