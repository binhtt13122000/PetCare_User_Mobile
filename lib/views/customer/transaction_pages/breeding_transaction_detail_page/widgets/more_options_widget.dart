import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/breeding_transaction_detail_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class BreedingTransactionDetailMoreOptionWidget
    extends GetView<BreedingTransactionDetailPageController> {
  const BreedingTransactionDetailMoreOptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isShowMoreOptions.value
          ? InkWell(
              onTap: () => controller.isShowMoreOptions.value = false,
              child: Container(
                color: DARK_GREY_TRANSPARENT,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30, right: 12),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              width: 200,
                              // height: ['CREATED', 'BREEDING_REQUESTED']
                              //         .contains(controller
                              //             .breedingTransactionModel.status)
                              //     ? 240
                              //     : 160,
                              height: 60,
                              decoration: BoxDecoration(
                                color: WHITE_COLOR,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // buttonWidget(
                                  //     content: 'View post detail',
                                  //     onTap: () {}),
                                  // buttonWidget(
                                  //     content: controller
                                  //                 .breedingTransactionModel
                                  //                 .ownerPetFemaleId ==
                                  //             controller
                                  //                 .accountModel.customerModel.id
                                  //         ? 'View seller profile'
                                  //         : 'View buyer profile',
                                  //     onTap: () {}),
                                  // buttonWidget(
                                  //     content: controller
                                  //                 .breedingTransactionModel
                                  //                 .ownerPetFemaleId ==
                                  //             controller
                                  //                 .accountModel.customerModel.id
                                  //         ? 'Report seller'
                                  //         : 'Report buyer',
                                  //     onTap: () {}),
                                  ['CREATED', 'BREEDING_REQUESTED'].contains(
                                              controller
                                                  .breedingTransactionModel
                                                  .status) &&
                                          controller.breedingTransactionModel
                                                  .ownerPetFemaleId ==
                                              controller
                                                  .accountModel.customerModel.id
                                      ? buttonWidget(
                                          content: 'Cancel transaction',
                                          isImportant: true,
                                          onTap: () => controller
                                            ..isShowMoreOptions.value = false
                                            ..isShowCancelPopup.value = true)
                                      : const SizedBox.shrink(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Spacer(flex: 1),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget buttonWidget(
          {required content,
          bool isImportant = false,
          required Function() onTap}) =>
      InkWell(
        onTap: onTap,
        child: Container(
          width: 180,
          decoration: BoxDecoration(
            color: WHITE_COLOR,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: isImportant
                  ? RED_COLOR
                  : DARK_GREY_TEXT_COLOR.withOpacity(0.5),
            ),
          ),
          padding: const EdgeInsets.all(10),
          child: CUSTOM_TEXT(
            content,
            textAlign: TextAlign.center,
            letterSpacing: 1,
            fontSize: 14,
            color: isImportant ? RED_COLOR : DARK_GREY_TEXT_COLOR,
          ),
        ),
      );
}
