import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/create_post_page_controller.dart';
import 'package:petapp_mobile/models/transaction_fees_model/transaction_fees_model.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class CreatePostSaleTransactionFeesWidget
    extends GetView<CreatePostPageController> {
  const CreatePostSaleTransactionFeesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: controller.isShowPurchaseTransactionFees.value,
        child: InkWell(
          onTap: () => controller.isShowPurchaseTransactionFees.value = false,
          child: Container(
            color: DARK_GREY_TRANSPARENT,
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 220,
                width: 370,
                decoration: BoxDecoration(
                  color: WHITE_COLOR,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    CUSTOM_TEXT('Purchase Transaction Fees',
                        fontWeight: FontWeight.w700),
                    const SizedBox(height: 20),
                    // CUSTOM_TEXT(
                    //     'Money received: ${FORMAT_MONEY(price: int.parse(controller.receivedMoney.value.isNotEmpty ? controller.receivedMoney.value : '0'))}'),
                    //   CUSTOM_TEXT(
                    //     'Money received: ${FORMAT_MONEY(price: int.parse(controller.receivedMoney.value.isNotEmpty ? controller.receivedMoney.value : '0'))}'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          Expanded(
                              child: CUSTOM_TEXT('Minimum',
                                  textAlign: TextAlign.center)),
                          Expanded(
                              child: CUSTOM_TEXT('Maximum',
                                  textAlign: TextAlign.center)),
                          Expanded(
                              child: CUSTOM_TEXT('Fees',
                                  textAlign: TextAlign.center)),
                          SizedBox(
                              width: 65,
                              child: CUSTOM_TEXT(
                                'Applied',
                                textAlign: TextAlign.center,
                              )),
                        ],
                      ),
                    ),

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: controller.listPurchaseTransactionFees
                            .asMap()
                            .entries
                            .map((e) => transactionFeesItemWidget(
                                transactionFeesModel: e.value))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget transactionFeesItemWidget(
          {required TransactionFeesModel transactionFeesModel}) =>
      Container(
        decoration: const BoxDecoration(),
        child: Column(
          children: [
            Container(
              color: LIGHT_GREY_COLOR.withOpacity(0.1),
              margin: const EdgeInsets.symmetric(vertical: 5),
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: CUSTOM_TEXT(
                        transactionFeesModel.min == 0
                            ? '-'
                            : FORMAT_MONEY(price: transactionFeesModel.min),
                        fontSize: 12,
                        textAlign: TextAlign.center,
                        color: controller
                                    .selectedPurchaseTransactionFeesId.value ==
                                transactionFeesModel.id
                            ? PRIMARY_COLOR
                            : DARK_GREY_TEXT_COLOR,
                      ),
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: CUSTOM_TEXT(
                        transactionFeesModel.max == 999999999
                            ? '-'
                            : FORMAT_MONEY(price: transactionFeesModel.max),
                        fontSize: 12,
                        textAlign: TextAlign.center,
                        color: controller
                                    .selectedPurchaseTransactionFeesId.value ==
                                transactionFeesModel.id
                            ? PRIMARY_COLOR
                            : DARK_GREY_TEXT_COLOR,
                      ),
                    ),
                  )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: CUSTOM_TEXT(
                          FORMAT_MONEY(price: transactionFeesModel.price),
                          fontSize: 12,
                          textAlign: TextAlign.center,
                          color: controller.selectedPurchaseTransactionFeesId
                                      .value ==
                                  transactionFeesModel.id
                              ? PRIMARY_COLOR
                              : DARK_GREY_TEXT_COLOR,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 65,
                    child: Visibility(
                      visible:
                          controller.selectedPurchaseTransactionFeesId.value ==
                              transactionFeesModel.id,
                      child: const Icon(
                        Icons.verified,
                        color: PRIMARY_COLOR,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: LIGHT_GREY_COLOR.withOpacity(0.1),
              margin: const EdgeInsets.symmetric(vertical: 5),
              height: 1,
            ),
          ],
        ),
      );
}
