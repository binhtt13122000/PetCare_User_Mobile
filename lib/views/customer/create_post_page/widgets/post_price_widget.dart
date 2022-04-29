import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/create_post_page_controller.dart';
import 'package:petapp_mobile/utilities/utilities.dart';

class PostPriceWidget extends GetView<CreatePostPageController> {
  const PostPriceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          receivedMoneyWidget(size: size),
          depositWidget(size: size),
          postPriceWidget(),
        ],
      ),
    );
  }

  Widget depositWidget({required Size size}) => Padding(
        padding: const EdgeInsets.only(
          top: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Deposit',
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 78, 98, 124),
                    fontSize: 16,
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
            SizedBox(
              width: size.width - 190,
              height: 45,
              child: Obx(
                () => TextFormField(
                  cursorColor: PRIMARY_COLOR,
                  initialValue: controller.title.value,
                  maxLength: 10,
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 78, 98, 124),
                    fontSize: 16,
                  ),
                  decoration: controller.title.value.isEmpty &&
                          !controller.isFirstInputTitle
                      ? const InputDecoration(
                          errorText: 'The field title is required',
                          suffixIcon: Icon(
                            Icons.error,
                            color: Color.fromARGB(255, 241, 99, 88),
                            size: 20,
                          ),
                        )
                      : InputDecoration(
                          counterText: '',
                          suffixIcon: Align(
                            widthFactor: 1,
                            heightFactor: 1,
                            child: Text(
                              controller.title.value.length.toString() + '/10',
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 78, 98, 124),
                                fontSize: 13,
                              ),
                            ),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                  onChanged: (String? value) {
                    controller.deposit.value =
                        value != null && int.tryParse(value) != null
                            ? int.tryParse(value)!
                            : 0;
                  },
                ),
              ),
            ),
          ],
        ),
      );

  Widget receivedMoneyWidget({required Size size}) => Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Received money',
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 78, 98, 124),
                    fontSize: 16,
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
            SizedBox(
              width: size.width - 190,
              height: 45,
              child: Obx(
                () => TextFormField(
                  cursorColor: PRIMARY_COLOR,
                  initialValue: controller.title.value,
                  maxLength: 10,
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 78, 98, 124),
                    fontSize: 16,
                  ),
                  decoration: controller.title.value.isEmpty &&
                          !controller.isFirstInputTitle
                      ? const InputDecoration(
                          errorText: 'The field title is required',
                          suffixIcon: Icon(
                            Icons.error,
                            color: Color.fromARGB(255, 241, 99, 88),
                            size: 20,
                          ),
                        )
                      : InputDecoration(
                          counterText: '',
                          suffixIcon: Align(
                            widthFactor: 1,
                            heightFactor: 1,
                            child: Text(
                              controller.title.value.length.toString() + '/10',
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(255, 78, 98, 124),
                                fontSize: 13,
                              ),
                            ),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                  onChanged: (String? value) {
                    controller.moneyReceived.value = value!;
                    controller.isFirstInputPrice = false;
                    if (int.tryParse(controller.moneyReceived.value) != null) {
                      controller.price.value =
                          (int.parse(controller.moneyReceived.value) /
                                  100 *
                                  110)
                              .toInt();
                      controller.deposit.value =
                          (int.parse(controller.moneyReceived.value) / 100 * 15)
                              .toInt();
                    } else {
                      controller.price.value = 0;
                      controller.deposit.value = 0;
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      );

  Widget postPriceWidget() => Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Post price',
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 78, 98, 124),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.info_outline_rounded,
                  size: 15,
                  color: DARK_GREY_COLOR.withAlpha(100),
                ),
              ],
            ),
            Obx(
              () => Text(
                FORMAT_MONEY(price: controller.price.value),
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w700,
                  color: PRIMARY_COLOR,
                  fontSize: 21,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      );

  // Widget depositWidget() => Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Row(
  //           children: [
  //             Text(
  //               'Buyer ',
  //               style: GoogleFonts.quicksand(
  //                 fontWeight: FontWeight.w500,
  //                 color: const Color.fromARGB(255, 78, 98, 124),
  //                 fontSize: 16,
  //               ),
  //             ),
  //             const SizedBox(
  //               width: 5,
  //             ),
  //             Icon(
  //               Icons.info_outline_rounded,
  //               size: 15,
  //               color: DARK_GREY_COLOR.withAlpha(100),
  //             ),
  //           ],
  //         ),
  //         Obx(
  //           () => Text(
  //             FORMAT_MONEY(price: controller.deposit.value),
  //             style: GoogleFonts.quicksand(
  //               fontWeight: FontWeight.w700,
  //               color: PRIMARY_COLOR,
  //               fontSize: 19,
  //             ),
  //           ),
  //         ),
  //       ],
  //     );
}
