import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/update_post_page_controller.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class UpdatePostBodyWidget extends GetView<UpdatePostPageController> {
  const UpdatePostBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        titleWidget(),
        const SizedBox(
          height: 15,
        ),
        receivedMoneyWidget(),
        const SizedBox(
          height: 15,
        ),
        postPriceWidget(),
      ],
    );
  }

  Widget titleWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Text(
                  'Post title',
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
          CUSTOM_REQUIRED_TEXT_FIELD(
              initText: controller.title.value,
              hintText: 'Type post title here...',
              maxLength: 40,
              onChange: (String? text) {
                controller.title.value = text ?? '';
              },
              checkEmptyString: <bool>() {
                return controller.title.value.isEmpty;
              },
              checkErrorText: <bool>() {
                return controller.title.value.isEmpty;
              },
              onDelete: () {
                controller.title.value = '';
              },
              errorText: 'Field post title is required!',
              countText: <String>() {
                return controller.title.value.length.toString() + '/40';
              },
              padding: const EdgeInsets.only(top: 5)),
        ],
      ),
    );
  }

  Widget receivedMoneyWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 45,
            child: Row(
              children: [
                Text(
                  'Received money',
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
              initText: controller.receivedMoney.value,
              hintText: 'Type received money here...',
              maxLength: 10,
              padding: const EdgeInsets.only(left: 20),
              onChange: (String? text) {
                if (text != null && text.isNotEmpty) {
                  String tmpText = text.replaceAll('.', '');
                  controller.receivedMoney.value = tmpText;

                  if (tmpText.isNotEmpty) {
                    int intReceivedMoney = int.parse(tmpText);

                    for (var element
                        in controller.listPurchaseTransactionFees) {
                      if (element.min <= intReceivedMoney &&
                          element.max > intReceivedMoney) {
                        controller.selectedPurchaseTransactionFeesId.value =
                            element.id;
                        controller.price.value =
                            intReceivedMoney + element.price;
                        break;
                      }
                    }
                  } else {
                    controller
                      ..price.value = 0
                      ..selectedPurchaseTransactionFeesId.value = -1;
                  }
                }
              },
              checkEmptyString: <bool>() {
                return controller.receivedMoney.value.isEmpty;
              },
              checkErrorText: <bool>() {
                return controller.receivedMoney.value.isEmpty;
              },
              onDelete: () {
                controller
                  ..receivedMoney.value = ''
                  ..price.value = 0;
              },
              errorText: 'Field received money is required!',
              countText: <String>() {
                return controller.receivedMoney.value.length.toString() + '/10';
              },
              isNumberTextField: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget postPriceWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => controller.isShowPurchaseTransactionFees.value = true,
            child: SizedBox(
              height: 45,
              child: Row(
                children: [
                  Text(
                    'Post price',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 61, 78, 100),
                      fontSize: 16,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Icon(
                      Icons.info_outline_rounded,
                      size: 15,
                      color: DARK_GREY_COLOR.withAlpha(100),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 45,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 167, 181, 201),
                  width: 1.2,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Obx(
                () => Text(
                  FORMAT_MONEY(price: controller.price.value),
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w700,
                    color: PRIMARY_COLOR,
                    fontSize: 20,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
