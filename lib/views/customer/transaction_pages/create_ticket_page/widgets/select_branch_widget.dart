import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/create_ticket_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class SelectBranchWidget extends GetView<CreateTicketPageController> {
  const SelectBranchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      color: WHITE_COLOR,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                CUSTOM_TEXT('Branch perform services'),
                CUSTOM_TEXT(
                  '*',
                  color: RED_COLOR,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
          Obx(
            () => DropdownButton<int>(
              value: controller.selectBranchIndex.value,
              items: controller.branchModelList
                  .asMap()
                  .entries
                  .map(
                    (e) => DropdownMenuItem(
                      value: e.key,
                      child: Text(
                        e.value.name,
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 78, 98, 124),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (int? value) {
                controller
                  ..selectBranchIndex.value = value!
                  ..update();
              },
            ),
          ),
          Obx(
            () => Visibility(
              visible: controller.selectBranchIndex.value != -1,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CUSTOM_TEXT(
                        'Branch address',
                        padding: const EdgeInsets.only(right: 15),
                        color: DARK_GREY_TEXT_COLOR.withOpacity(0.95),
                      ),
                      Expanded(
                        child: CUSTOM_TEXT(
                          controller.selectBranchIndex.value != -1
                              ? (controller
                                      .branchModelList[
                                          controller.selectBranchIndex.value]
                                      .address ??
                                  'N/A')
                              : 'N/A',
                          textAlign: TextAlign.end,
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.95),
                          textOverflow: controller.isShowBranchDetail.value
                              ? TextOverflow.clip
                              : TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: controller.isShowBranchDetail.value,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CUSTOM_TEXT(
                              'Phone number',
                              padding: const EdgeInsets.only(right: 15),
                              color: DARK_GREY_TEXT_COLOR.withOpacity(0.95),
                            ),
                            Expanded(
                              child: CUSTOM_TEXT(
                                controller.selectBranchIndex.value != -1
                                    ? (controller
                                        .branchModelList[
                                            controller.selectBranchIndex.value]
                                        .phoneNumber)
                                    : 'N/A',
                                textAlign: TextAlign.end,
                                color: DARK_GREY_TEXT_COLOR.withOpacity(0.95),
                                textOverflow:
                                    controller.isShowBranchDetail.value
                                        ? TextOverflow.clip
                                        : TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CUSTOM_TEXT(
                              'Email',
                              padding: const EdgeInsets.only(right: 15),
                              color: DARK_GREY_TEXT_COLOR.withOpacity(0.95),
                            ),
                            Expanded(
                              child: CUSTOM_TEXT(
                                controller.selectBranchIndex.value != -1
                                    ? (controller
                                            .branchModelList[controller
                                                .selectBranchIndex.value]
                                            .email ??
                                        'N/A')
                                    : 'N/A',
                                textAlign: TextAlign.end,
                                color: DARK_GREY_TEXT_COLOR.withOpacity(0.95),
                                textOverflow:
                                    controller.isShowBranchDetail.value
                                        ? TextOverflow.clip
                                        : TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      InkWell(
                        onTap: () => controller.isShowBranchDetail.value =
                            !controller.isShowBranchDetail.value,
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CUSTOM_TEXT(
                                controller.isShowBranchDetail.value
                                    ? 'Hide branch details'
                                    : 'View branch details',
                                color: PRIMARY_COLOR,
                                fontSize: 13,
                                letterSpacing: 2,
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                controller.isShowBranchDetail.value
                                    ? Icons.keyboard_double_arrow_up_outlined
                                    : Icons.keyboard_double_arrow_down_outlined,
                                size: 18,
                                color: PRIMARY_COLOR,
                              ),
                            ],
                          ),
                          Container(
                            height: 1,
                            width: 180,
                            color: PRIMARY_COLOR,
                            margin: const EdgeInsets.only(top: 2),
                          ),
                        ]),
                      ),
                      const Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
