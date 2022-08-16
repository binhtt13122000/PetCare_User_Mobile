import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/update_pet_page_controller.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class UpdatePetBodyWidget extends GetView<UpdatePetPageController> {
  const UpdatePetBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              avatarWidget(),
              const SizedBox(
                height: 25,
              ),
              petNameWidget(),
              genderAndFertilityWidget(),
              const SizedBox(
                height: 25,
              ),
              dateOfBirthWidget(),
              const SizedBox(
                height: 20,
              ),
              colorWidget(),
              descriptionWidget(),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
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
              child: controller.avatarFilePath.value.isEmpty
                  ? CircleAvatar(
                      maxRadius: 46,
                      minRadius: 46,
                      backgroundImage: NetworkImage(controller.petModel.avatar),
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

  Widget fertilityWidget() => Padding(
        padding: const EdgeInsets.only(
          top: 5,
        ),
        child: Obx(
          () => InkWell(
            onTap: () => controller.selectedFertility.value == 'YES'
                ? controller.selectedFertility.value = 'NO'
                : controller.selectedFertility.value = 'YES',
            child: Row(
              children: [
                Container(
                  height: 30,
                  width: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: controller.selectedFertility.value == 'YES'
                        ? PRIMARY_COLOR
                        : const Color.fromARGB(255, 237, 240, 243),
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(7),
                    ),
                    border: Border.all(
                      color: controller.selectedFertility.value == 'YES'
                          ? PRIMARY_COLOR
                          : DARK_GREY_COLOR.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'YES',
                    style: GoogleFonts.quicksand(
                      color: controller.selectedFertility.value == 'YES'
                          ? WHITE_COLOR
                          : DARK_GREY_COLOR.withOpacity(0.3),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  width: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: controller.selectedFertility.value == 'NO'
                        ? PRIMARY_COLOR
                        : const Color.fromARGB(255, 237, 240, 243),
                    borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(7)),
                    border: Border.all(
                      color: controller.selectedFertility.value == 'NO'
                          ? PRIMARY_COLOR
                          : DARK_GREY_COLOR.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'NO',
                    style: GoogleFonts.quicksand(
                      color: controller.selectedFertility.value == 'NO'
                          ? WHITE_COLOR
                          : DARK_GREY_COLOR.withOpacity(0.3),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget dateOfBirthWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 5),
                    //   child: SvgPicture.asset(
                    //     ICON_PATH + CLOCK_SVG,
                    //     height: 17,
                    //     color: const Color.fromARGB(255, 61, 78, 100),
                    //   ),
                    // ),
                    Text(
                      'Date of birth',
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
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: InkWell(
                  onTap: () => controller.isShowCalendar.value = true,
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 167, 181, 201),
                        width: 1.2,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Obx(
                            () => controller.dayOfBirthText.value.isEmpty
                                ? Text(
                                    'dd/MM/yyyy',
                                    style: GoogleFonts.quicksand(
                                      fontWeight: FontWeight.w500,
                                      color: const Color.fromARGB(
                                          255, 162, 176, 194),
                                      fontSize: 13,
                                      letterSpacing: 2,
                                    ),
                                  )
                                : Text(
                                    controller.dayOfBirthText.value,
                                    style: GoogleFonts.quicksand(
                                      fontWeight: FontWeight.w500,
                                      color: const Color.fromARGB(
                                          255, 113, 135, 168),
                                      fontSize: 15,
                                      letterSpacing: 2,
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
              ),
            ),
          ],
        ),
      );

  Widget genderWidget() => Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Obx(
          () => InkWell(
            onTap: () => controller.selectedGender.value == 'MALE'
                ? controller.selectedGender.value = 'FEMALE'
                : controller.selectedGender.value = 'MALE',
            child: Row(
              children: [
                Container(
                  height: 30,
                  width: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: controller.selectedGender.value == 'MALE'
                        ? const Color.fromARGB(255, 99, 194, 238)
                        : const Color.fromARGB(255, 237, 240, 243),
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(7),
                    ),
                    border: Border.all(
                      color: controller.selectedGender.value == 'MALE'
                          ? const Color.fromARGB(255, 99, 194, 238)
                          : DARK_GREY_COLOR.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'MALE',
                        style: GoogleFonts.quicksand(
                          color: controller.selectedGender.value == 'MALE'
                              ? WHITE_COLOR
                              : DARK_GREY_COLOR.withOpacity(0.3),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SvgPicture.asset(
                        ICON_PATH + MALE_SVG,
                        height: 14,
                        color: controller.selectedGender.value == 'MALE'
                            ? WHITE_COLOR
                            : DARK_GREY_COLOR.withOpacity(0.3),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 30,
                  width: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: controller.selectedGender.value == 'FEMALE'
                        ? const Color.fromARGB(255, 240, 128, 171)
                        : const Color.fromARGB(255, 237, 240, 243),
                    borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(7)),
                    border: Border.all(
                      color: controller.selectedGender.value == 'FEMALE'
                          ? const Color.fromARGB(255, 240, 128, 171)
                          : DARK_GREY_COLOR.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'FEMALE',
                        style: GoogleFonts.quicksand(
                          color: controller.selectedGender.value == 'FEMALE'
                              ? WHITE_COLOR
                              : DARK_GREY_COLOR.withOpacity(0.3),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SvgPicture.asset(
                        ICON_PATH + FEMALE_SVG,
                        height: 14,
                        color: controller.selectedGender.value == 'FEMALE'
                            ? WHITE_COLOR
                            : DARK_GREY_COLOR.withOpacity(0.3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget genderAndFertilityWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            //*Gender
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Gender',
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
                      ),
                    ),
                  ],
                ),
                genderWidget(),
              ],
            ),
            const SizedBox(width: 20),
            //*Fertility
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Fertility',
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
                      ),
                    ),
                  ],
                ),
                fertilityWidget(),
              ],
            ),
          ],
        ),
      );

  Widget petNameWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 45,
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                Text(
                  'Pet name',
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
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: CUSTOM_REQUIRED_TEXT_FIELD(
                hintText: 'Type your pet name here...',
                maxLength: 20,
                onChange: (String? text) {
                  controller
                    ..petName.value = text ?? ''
                    ..isFirstInputPetName.value = false;
                },
                checkEmptyString: <bool>() {
                  return controller.petName.value.isEmpty;
                },
                checkErrorText: <bool>() {
                  return controller.petName.value.isEmpty &&
                      !controller.isFirstInputPetName.value;
                },
                onDelete: () {
                  controller.petName.value = '';
                },
                errorText: 'Field pet name is required!',
                countText: <String>() {
                  return controller.petName.value.length.toString() + '/20';
                },
                initText: controller.petModel.name),
          ),
        ],
      ),
    );
  }

  Widget colorWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 45,
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                Text(
                  'Pet color',
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 61, 78, 100),
                    fontSize: 16,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: CUSTOM_REQUIRED_TEXT_FIELD(
              hintText: 'Type your pet color here...',
              maxLength: 20,
              onChange: (String? text) {
                controller.color.value = text ?? '';
              },
              checkEmptyString: <bool>() {
                return controller.color.value.isEmpty;
              },
              checkErrorText: <bool>() {
                return false;
              },
              onDelete: () {
                controller.color.value = '';
              },
              errorText: '',
              countText: <String>() {
                return controller.color.value.length.toString() + '/20';
              },
              initText: controller.petModel.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget descriptionWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0),
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
          CUSTOM_REQUIRED_TEXT_FIELD(
            hintText: 'More information about your pet...',
            maxLength: 200,
            height: 80,
            maxLines: 3,
            onChange: (String? text) {
              controller.description.value = text ?? '';
            },
            checkEmptyString: <bool>() {
              return controller.description.value.isEmpty;
            },
            checkErrorText: <bool>() {
              return false;
            },
            onDelete: () {
              controller.description.value = '';
            },
            errorText: '',
            countText: <String>() {
              return controller.description.value.length.toString() + '/200';
            },
            padding: const EdgeInsets.only(top: 5),
            initText: controller.petModel.description,
          ),
        ],
      ),
    );
  }
}
