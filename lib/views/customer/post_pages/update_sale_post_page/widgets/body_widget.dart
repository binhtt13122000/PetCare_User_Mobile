import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/update_sale_post_page_controller.dart';
import 'package:petapp_mobile/utilities/utilities.dart';

class UpdatePostBodyWidget extends GetView<UpdateSalePostPageController> {
  const UpdatePostBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        postTypeWidget(),
        titleWidget(),
        receivedMoneyWidget(),
        postPriceWidget(),
      ],
    );
  }

  Widget postTypeWidget() => Padding(
        padding: const EdgeInsets.only(top: 10, left: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Post type',
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
            selectPostTypeWidget(),
          ],
        ),
      );

  Widget selectPostTypeWidget() => Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Obx(
          () => Row(
            children: [
              Row(
                children: [
                  Container(
                    height: 30,
                    width: 130,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: controller.selectedPostType.value == 'SALE'
                          ? const Color.fromARGB(255, 99, 194, 238)
                          : const Color.fromARGB(255, 237, 240, 243),
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(7),
                      ),
                      border: Border.all(
                        color: controller.selectedPostType.value == 'SALE'
                            ? const Color.fromARGB(255, 99, 194, 238)
                            : DARK_GREY_COLOR.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'SALE',
                          style: GoogleFonts.quicksand(
                            color: controller.selectedPostType.value == 'SALE'
                                ? WHITE_COLOR
                                : DARK_GREY_COLOR.withOpacity(0.3),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 130,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: controller.selectedPostType.value == 'BREED'
                          ? const Color.fromARGB(255, 240, 128, 171)
                          : const Color.fromARGB(255, 237, 240, 243),
                      borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(7)),
                      border: Border.all(
                        color: controller.selectedPostType.value == 'BREED'
                            ? const Color.fromARGB(255, 240, 128, 171)
                            : DARK_GREY_COLOR.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'BREED',
                          style: GoogleFonts.quicksand(
                            color: controller.selectedPostType.value == 'BREED'
                                ? WHITE_COLOR
                                : DARK_GREY_COLOR.withOpacity(0.3),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 2,
                          ),
                        ),
                        // SvgPicture.asset(
                        //   ICON_PATH + FEMALE_SVG,
                        //   height: 14,
                        //   color: controller.selectedPostType.value == 'BREED'
                        //       ? WHITE_COLOR
                        //       : DARK_GREY_COLOR.withOpacity(0.3),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      );

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
          Container(
            height: 45,
            alignment: Alignment.center,
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
                    minLines: 1,
                    maxLines: 1,
                    maxLength: 40,
                    controller: controller.titleEditingController,
                    onChanged: (String text) {
                      controller.title.value = text;
                    },
                    keyboardType: TextInputType.multiline,
                    cursorColor: PRIMARY_COLOR,
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 113, 135, 168),
                      fontSize: 15,
                      letterSpacing: 1,
                    ),
                    decoration: InputDecoration(
                      isCollapsed: true,
                      counterText: '',
                      border: InputBorder.none,
                      hintText: 'Type a post title here...',
                      hintStyle: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 162, 176, 194),
                        fontSize: 13,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    controller.title.value.length.toString() + '/40',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 162, 176, 194),
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget receivedMoneyWidget() {
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
          Container(
            height: 45,
            alignment: Alignment.center,
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
                    minLines: 1,
                    maxLines: 1,
                    maxLength: 11,
                    controller: controller.receiveMoneyEditingController,
                    onChanged: (String text) {
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
                        controller.price.value = 0;
                        controller.selectedPurchaseTransactionFeesId.value = -1;
                      }
                    },
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: false, signed: false),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(
                          r'[0-9.]',
                        ),
                      ),
                      CustomTextFormatter(
                          sample: 'xxx.xxx.xxx', separator: '.'),
                    ],
                    cursorColor: PRIMARY_COLOR,
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 113, 135, 168),
                      fontSize: 15,
                      letterSpacing: 1,
                    ),
                    decoration: InputDecoration(
                      isCollapsed: true,
                      counterText: '',
                      border: InputBorder.none,
                      hintText: 'Type the amount you want to receive...',
                      hintStyle: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 162, 176, 194),
                        fontSize: 12,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    controller.receivedMoney.value
                            .replaceAll('.', '')
                            .length
                            .toString() +
                        '/9',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 162, 176, 194),
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget postPriceWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                InkWell(
                  onTap: () =>
                      controller.isShowPurchaseTransactionFeees.value = true,
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
              ],
            ),
          ),
          Container(
            height: 45,
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(10),
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
        ],
      ),
    );
  }
}
