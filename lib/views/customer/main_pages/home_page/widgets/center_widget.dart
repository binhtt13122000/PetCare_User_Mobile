import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/main_page_controllers/home_page_controller.dart';
import 'package:petapp_mobile/models/branch_model/branch_model.dart';
import 'package:petapp_mobile/services/other_services/branch_services.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class HomeCenterWidget extends GetView<HomePageController> {
  const HomeCenterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          CUSTOM_TEXT(
            'Pet care centers',
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
            fontSize: 18,
            padding: const EdgeInsets.only(bottom: 15),
          ),
          GetBuilder<HomePageController>(builder: (_) {
            controller.isWaitingLoadingBranchList.value = true;
            WidgetsBinding.instance!.addPostFrameCallback((_) async {
              controller
                ..branchModelList = await BranchServices.fetchBranchList()
                ..isWaitingLoadingBranchList.value = false;
            });
            return Obx(() => controller.isWaitingLoadingBranchList.value
                ? Expanded(child: LOADING_WIDGET())
                : Expanded(
                    child:
                        SingleChildScrollView(child: branchListItemWidget())));
          }),
        ],
      ),
    );
  }

  Widget branchListItemWidget() => Column(
        children: controller.branchModelList
            .asMap()
            .entries
            .map((e) => branchItemWidget(branchModel: e.value, index: e.key))
            .toList(),
      );

  Widget branchItemWidget(
          {required BranchModel branchModel, required int index}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              height: 1,
              color: LIGHT_GREY_COLOR.withAlpha(30),
              margin: const EdgeInsets.only(top: 5, bottom: 3),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              color: index.isEven
                  ? LIGHT_GREY_COLOR.withAlpha(10)
                  : LIGHT_GREY_COLOR.withAlpha(3),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CUSTOM_TEXT(
                        'Name',
                        color: DARK_GREY_TEXT_COLOR.withOpacity(0.95),
                      ),
                      Row(
                        children: [
                          CUSTOM_TEXT(
                            branchModel.name,
                            color: DARK_GREY_TEXT_COLOR.withOpacity(0.95),
                          ),
                          CUSTOM_TEXT(
                            ' (10.5 km)',
                            fontSize: 15,
                            color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Obx(
                    () => Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CUSTOM_TEXT(
                              'Address',
                              padding: const EdgeInsets.only(right: 15),
                              color: DARK_GREY_TEXT_COLOR.withOpacity(0.95),
                            ),
                            Expanded(
                              child: CUSTOM_TEXT(
                                branchModel.address ?? 'N/A',
                                textAlign: TextAlign.end,
                                color: DARK_GREY_TEXT_COLOR.withOpacity(0.95),
                                textOverflow: controller.selectedBranch
                                        .contains(branchModel.name)
                                    ? TextOverflow.clip
                                    : TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: controller.selectedBranch
                              .contains(branchModel.name),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CUSTOM_TEXT(
                                    'Phone number',
                                    padding: const EdgeInsets.only(right: 15),
                                    color:
                                        DARK_GREY_TEXT_COLOR.withOpacity(0.95),
                                  ),
                                  Expanded(
                                    child: CUSTOM_TEXT(
                                      branchModel.phoneNumber,
                                      textAlign: TextAlign.end,
                                      color: DARK_GREY_TEXT_COLOR
                                          .withOpacity(0.95),
                                      textOverflow: controller.selectedBranch
                                              .contains(branchModel.name)
                                          ? TextOverflow.clip
                                          : TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CUSTOM_TEXT(
                                    'Email',
                                    padding: const EdgeInsets.only(right: 15),
                                    color:
                                        DARK_GREY_TEXT_COLOR.withOpacity(0.95),
                                  ),
                                  Expanded(
                                    child: CUSTOM_TEXT(
                                      branchModel.email ?? 'N/A',
                                      textAlign: TextAlign.end,
                                      color: DARK_GREY_TEXT_COLOR
                                          .withOpacity(0.95),
                                      textOverflow: controller.selectedBranch
                                              .contains(branchModel.name)
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
                              onTap: () => controller.selectedBranch
                                      .contains(branchModel.name)
                                  ? controller.selectedBranch
                                      .remove(branchModel.name)
                                  : controller.selectedBranch
                                      .add(branchModel.name),
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CUSTOM_TEXT(
                                      controller.selectedBranch
                                              .contains(branchModel.name)
                                          ? 'Hide details'
                                          : 'View details',
                                      color: PRIMARY_COLOR,
                                      fontSize: 13,
                                      letterSpacing: 2,
                                    ),
                                    const SizedBox(width: 5),
                                    Icon(
                                      controller.selectedBranch
                                              .contains(branchModel.name)
                                          ? Icons
                                              .keyboard_double_arrow_up_outlined
                                          : Icons
                                              .keyboard_double_arrow_down_outlined,
                                      size: 18,
                                      color: PRIMARY_COLOR,
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 1,
                                  width: 120,
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
                ],
              ),
            ),
            Container(
              height: 1,
              color: LIGHT_GREY_COLOR.withAlpha(30),
              margin: const EdgeInsets.only(top: 3, bottom: 5),
            ),
          ],
        ),
      );
}
