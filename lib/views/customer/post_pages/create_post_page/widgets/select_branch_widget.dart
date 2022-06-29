import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/create_post_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class SelectBranchWidget extends GetView<CreatePostPageController> {
  const SelectBranchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.isLoadingBranch.value = true;
    // WidgetsBinding.instance!.addPostFrameCallback((_) async {
    //   controller
    //     ..branchList = await BranchServices.fetchBranchList()
    //     ..selectedBranchIndex.value = 0
    //     ..isLoadingBranch.value = false;
    // });

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              meetingTimeWidget(),
              Row(
                children: [
                  Row(
                    children: [
                      Text(
                        'Select branch',
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w500,
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.95),
                          fontSize: 15,
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
                  const SizedBox(width: 20),
                  Obx(
                    () => DropdownButton<int>(
                      value: controller.selectedBranchIndex.value,
                      items: controller.branchList
                          .asMap()
                          .entries
                          .map((e) => DropdownMenuItem(
                              value: e.key,
                              child: Text(
                                e.value.name,
                                style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromARGB(255, 78, 98, 124),
                                  fontSize: 16,
                                ),
                              )))
                          .toList(),
                      onChanged: (int? value) {
                        controller.selectedBranchIndex.value = value!;
                      },
                    ),
                  ),
                ],
              ),
              Obx(
                () => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CUSTOM_TEXT(
                      'Branch address',
                      color: DARK_GREY_TEXT_COLOR.withOpacity(0.95),
                      padding: const EdgeInsets.only(right: 10),
                      fontSize: 15,
                    ),
                    Expanded(
                      child: CUSTOM_TEXT(
                        controller
                                .branchList[
                                    controller.selectedBranchIndex.value]
                                .address ??
                            'N/A',
                        textOverflow: TextOverflow.clip,
                        color: DARK_GREY_TEXT_COLOR.withOpacity(0.95),
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          margin: const EdgeInsets.only(top: 20),
          color: LIGHT_GREY_COLOR.withAlpha(30),
        ),
        Container(
          height: 30,
          color: SUPPER_LIGHT_BLUE,
        ),
      ],
    );
  }

  Widget meetingTimeWidget() => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Meeting time',
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w500,
                        color: DARK_GREY_TEXT_COLOR.withOpacity(0.95),
                        fontSize: 15,
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
            Expanded(
              child: InkWell(
                onTap: () => controller.isShowCalendar.value = true,
                child: Container(
                  height: 40,
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(left: 20),
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
                          () => controller.meetingTimeText.value.isEmpty
                              ? Text(
                                  'dd/MM/yyyy',
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.w500,
                                    color: const Color.fromARGB(
                                        255, 162, 176, 194),
                                    fontSize: 13,
                                    letterSpacing: 1,
                                  ),
                                )
                              : Text(
                                  controller.meetingTimeText.value,
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.w500,
                                    color: const Color.fromARGB(
                                        255, 113, 135, 168),
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
            ),
          ],
        ),
      );
}
