import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/sale_transaction_detail_page_controller.dart';
import 'package:petapp_mobile/services/transaction_services/sale_transaction_services.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class SaleTransactionMoreOptionWidget
    extends GetView<SaleTransactionDetailPageController> {
  const SaleTransactionMoreOptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(
          () => Visibility(
            visible: controller.isShowMoreOptions.value,
            child: InkWell(
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
                              height: controller.saleTransactionModel.status ==
                                      'CREATED'
                                  ? 240
                                  : 160,
                              decoration: BoxDecoration(
                                color: WHITE_COLOR,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  buttonWidget(
                                      content: 'View post detail',
                                      onTap: () {}),
                                  buttonWidget(
                                      content: controller.saleTransactionModel
                                                  .buyerId ==
                                              controller
                                                  .accountModel.customerModel.id
                                          ? 'View seller profile'
                                          : 'View buyer profile',
                                      onTap: () {}),
                                  buttonWidget(
                                      content: controller.saleTransactionModel
                                                  .buyerId ==
                                              controller
                                                  .accountModel.customerModel.id
                                          ? 'Report seller'
                                          : 'Report buyer',
                                      onTap: () {}),
                                  controller.saleTransactionModel.status ==
                                              'CREATED' &&
                                          controller.saleTransactionModel
                                                  .buyerId ==
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
            ),
          ),
        ),
        cancelWidget(),
      ],
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

  Widget cancelWidget() => Obx(
        () => Visibility(
          visible: controller.isShowCancelPopup.value,
          child: InkWell(
            onTap: () => controller.isShowCancelPopup.value = false,
            child: Container(
              color: const Color.fromARGB(106, 198, 188, 201),
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: 320,
                  height: 360,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                  decoration: BoxDecoration(
                    color: WHITE_COLOR,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Cancel transaction',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                          color: PRIMARY_COLOR,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                        ),
                      ),
                      quickRateWidget(),
                      descriptionWidget(),
                      submitButtonWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget quickRateWidget() => Column(
        children: [
          Container(
            height: 1,
            color: DARK_GREY_COLOR.withOpacity(0.1),
            margin: const EdgeInsets.symmetric(vertical: 10),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Why do you want to cancel this transaction?',
              textAlign: TextAlign.start,
              style: GoogleFonts.quicksand(
                color: const Color.fromARGB(255, 85, 91, 110),
                fontWeight: FontWeight.w500,
                fontSize: 13,
                height: 1,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Wrap(
              alignment: WrapAlignment.start,
              direction: Axis.horizontal,
              crossAxisAlignment: WrapCrossAlignment.start,
              runAlignment: WrapAlignment.start,
              verticalDirection: VerticalDirection.down,
              spacing: 10,
              runSpacing: 10,
              children: [
                quickRateTextWidget(content: 'The seller did not come'),
                quickRateTextWidget(content: 'I\'m busy'),
                quickRateTextWidget(content: 'Sick pet'),
                quickRateTextWidget(content: 'Pet is not correct'),
              ],
            ),
          ),
        ],
      );

  Widget quickRateTextWidget({required content}) => Obx(
        () => InkWell(
          onTap: () => controller.quickCancelList.contains(content)
              ? controller.quickCancelList.remove(content)
              : controller.quickCancelList.add(content),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: controller.quickCancelList.contains(content)
                  ? PRIMARY_COLOR
                  : WHITE_COLOR,
              border: Border.all(
                color: controller.quickCancelList.contains(content)
                    ? PRIMARY_COLOR
                    : const Color.fromARGB(255, 85, 91, 110),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              content,
              textAlign: TextAlign.start,
              style: GoogleFonts.quicksand(
                color: controller.quickCancelList.contains(content)
                    ? WHITE_COLOR
                    : const Color.fromARGB(255, 85, 91, 110),
                fontWeight: FontWeight.w500,
                fontSize: 15,
                height: 1,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      );

  Widget submitButtonWidget() => Padding(
        padding: const EdgeInsets.only(
          top: 30,
        ),
        child: InkWell(
          onTap: () async {
            if (controller.quickCancelList.isNotEmpty ||
                controller.cancelDescription.value.isNotEmpty) {
              String cancelContent = '';
              if (controller.quickCancelList.isNotEmpty) {
                int index = 0;
                do {
                  cancelContent += index == controller.quickCancelList.length
                      ? '${controller.quickCancelList[index]}, '
                      : '${controller.quickCancelList[index]}. ';
                  index++;
                } while (index < controller.quickCancelList.length - 1);
              }

              cancelContent += controller.cancelDescription.value;
              await SaleTransactionService.updateSaleTransaction(
                  id: controller.saleTransactionModel.id,
                  meetingTime: controller.saleTransactionModel.meetingTime,
                  placeMeeting: controller.saleTransactionModel.placeMeeting,
                  transactionTotal:
                      controller.saleTransactionModel.transactionTotal,
                  status: 'CANCELED',
                  reasonCancel: cancelContent,
                  cancelTime: DateTime.now(),
                  message: 'The transaction has been canceled!');
              controller
                ..cancelDescription.value = ''
                ..quickCancelList = <String>[].obs
                ..isShowCancelPopup.value = false
                ..update()
                ..isShowCancelResultPopup.value = true;
            }
          },
          child: Obx(
            () => Container(
              height: 35,
              decoration: BoxDecoration(
                color: controller.quickCancelList.isNotEmpty ||
                        controller.cancelDescription.value.isNotEmpty
                    ? PRIMARY_COLOR.withOpacity(0.9)
                    : PRIMARY_COLOR.withOpacity(0.3),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: controller.quickCancelList.isNotEmpty ||
                          controller.cancelDescription.value.isNotEmpty
                      ? PRIMARY_COLOR
                      : PRIMARY_COLOR.withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: DARK_GREY_COLOR.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Submit',
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: GoogleFonts.quicksand(
                      color: WHITE_COLOR,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 7),
                    child: SvgPicture.asset(
                      ICON_PATH + SEND_SVG,
                      height: 18,
                      color: WHITE_COLOR,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget descriptionWidget() {
    TextEditingController _textEditingController = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
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
        Container(
          height: 70,
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.only(top: 8),
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
                child: TextField(
                  minLines: 3,
                  maxLines: 3,
                  controller: _textEditingController,
                  onChanged: (String text) {
                    controller.cancelDescription.value = text;
                  },
                  keyboardType: TextInputType.multiline,
                  cursorColor: PRIMARY_COLOR,
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 113, 135, 168),
                    fontSize: 15,
                    letterSpacing: 1,
                  ),
                  decoration: InputDecoration.collapsed(
                    hintText:
                        'Tell us more about the reason why you cancel this transaction...',
                    hintStyle: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 162, 176, 194),
                      fontSize: 13,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget cancelResultPopup() => Obx(
        () => Visibility(
          visible: controller.isShowCancelResultPopup.value,
          child: InkWell(
            onTap: () => controller.isShowCancelResultPopup.value = false,
            child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color.fromARGB(106, 201, 188, 190),
              ),
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: 200,
                  width: 250,
                  decoration: BoxDecoration(
                    color: WHITE_COLOR,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Transaction cancel successfully',
                        style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                            color: Color.fromARGB(255, 92, 98, 124),
                          ),
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          height: 1,
                          letterSpacing: 1,
                        ),
                      ),
                      const Icon(Icons.verified_outlined,
                          size: 70, color: PRIMARY_COLOR),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: InkWell(
                          onTap: () =>
                              controller.isShowCancelResultPopup.value = false,
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: PRIMARY_COLOR,
                            ),
                            child: Text(
                              'OK',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.quicksand(
                                textStyle: const TextStyle(color: WHITE_COLOR),
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                height: 1,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
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
