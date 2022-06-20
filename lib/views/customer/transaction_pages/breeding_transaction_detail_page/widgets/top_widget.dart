import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/breeding_transaction_detail_page_controller.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/transaction_list_page_controller.dart';

class BreedingTransactionDetailTopWidget
    extends GetView<BreedingTransactionDetailPageController> {
  const BreedingTransactionDetailTopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            topTitleWidget(),
            Container(
              height: 1,
              margin: const EdgeInsets.only(top: 20),
              color: LIGHT_GREY_COLOR.withOpacity(0.1),
            ),
            Container(
              color: SUPPER_LIGHT_BLUE,
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Transaction ID',
                    style: GoogleFonts.quicksand(
                      fontSize: 13,
                      color: DARK_GREY_COLOR.withAlpha(130),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '#0' + controller.breedingTransactionId.toString(),
                    style: GoogleFonts.quicksand(
                      fontSize: 13,
                      color: DARK_GREY_COLOR.withAlpha(130),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget topTitleWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            InkWell(
              onTap: () => Get
                ..back()
                ..put(TransactionListPageController()).update(),
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: WHITE_COLOR,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: DARK_GREY_COLOR.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Color.fromARGB(255, 61, 78, 100),
                  size: 18,
                ),
              ),
            ),
            Expanded(
              child: Text(
                'Breeding Transaction Page',
                textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(
                  color: const Color.fromARGB(255, 62, 68, 87),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ),
            InkWell(
              onTap: () => controller.isShowMoreOptions.value = true,
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: WHITE_COLOR,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: DARK_GREY_COLOR.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  ICON_PATH + ELLIPSIS_SVG,
                  color: DARK_GREY_TEXT_COLOR,
                  height: 16,
                ),
              ),
            ),
          ],
        ),
      );
}
