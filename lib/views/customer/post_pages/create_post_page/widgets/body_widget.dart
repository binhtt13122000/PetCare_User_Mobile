import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/create_post_page_controller.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class CreatePostBodyWidget extends GetView<CreatePostPageController> {
  const CreatePostBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        postTypeWidget(),
        titleWidget(),
        const SizedBox(
          height: 15,
        ),
        receivedMoneyWidget(),
        const SizedBox(
          height: 15,
        ),
        postPriceWidget(),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget postTypeWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            Expanded(child: selectPostTypeWidget()),
          ],
        ),
      );

  Widget selectPostTypeWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(
          () => InkWell(
            onTap: () => controller
              ..selectedPostType.value =
                  controller.selectedPostType.value == 'SALE' ? 'BREED' : 'SALE'
              ..update(),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 30,
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
                        // SvgPicture.asset(
                        //   ICON_PATH + MALE_SVG,
                        //   height: 14,
                        //   color: controller.selectedPostType.value == 'SALE'
                        //       ? WHITE_COLOR
                        //       : DARK_GREY_COLOR.withOpacity(0.3),
                        // ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 30,
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
                ),
              ],
            ),
          ),
        ),
      );

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
              hintText: 'Type received money here...',
              maxLength: 10,
              padding: const EdgeInsets.only(left: 20),
              onChange: (String? text) {
                if (text != null && text.isNotEmpty) {
                  controller.isFirstInputReceivedMoney.value = false;
                  String tmpText = text.replaceAll('.', '');
                  controller.receivedMoney.value = tmpText;

                  if (tmpText.isNotEmpty) {
                    int intReceivedMoney = int.parse(tmpText);

                    for (var element
                        in controller.listPurchaseTransactionFees) {
                      if (element.min <= intReceivedMoney &&
                          element.max > intReceivedMoney) {
                        controller.selectedTransactionFeesId.value = element.id;
                        controller.price.value =
                            intReceivedMoney + element.price;
                        break;
                      }
                    }
                  } else {
                    controller
                      ..price.value = 0
                      ..selectedTransactionFeesId.value = -1;
                  }
                }
              },
              checkEmptyString: <bool>() {
                return controller.receivedMoney.value.isEmpty;
              },
              checkErrorText: <bool>() {
                return controller.receivedMoney.value.isEmpty &&
                    !controller.isFirstInputReceivedMoney.value;
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
              hintText: 'Type post title here...',
              maxLength: 40,
              onChange: (String? text) {
                controller
                  ..title.value = text ?? ''
                  ..isFirstInputTitle = false;
              },
              checkEmptyString: <bool>() {
                return controller.title.value.isEmpty;
              },
              checkErrorText: <bool>() {
                return controller.title.value.isEmpty &&
                    !controller.isFirstInputTitle;
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
}
