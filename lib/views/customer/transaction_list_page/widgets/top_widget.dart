import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_list_page_controller.dart';

class TransactionListTopWidget extends GetView<TransactionListPageController> {
  const TransactionListTopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          topWidget(),
          listTransactionType(),
          Container(
            height: 1,
            color: DARK_GREY_COLOR.withAlpha(30),
          ),
          Container(
            height: 15,
            color: const Color.fromARGB(255, 242, 244, 247),
          ),
        ],
      );

  Widget listTransactionType() => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            transactionTypeWidget(typeName: 'Center\'s services'),
            transactionTypeWidget(typeName: 'Sale'),
            transactionTypeWidget(typeName: 'Breeding'),
          ],
        ),
      );

  Widget transactionTypeWidget({required String typeName}) => Obx(
        () => Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 12),
          child: InkWell(
            onTap: () => controller.selectedTransactionType.value = typeName,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: controller.selectedTransactionType.value == typeName
                    ? PRIMARY_COLOR
                    : const Color.fromARGB(255, 247, 249, 253),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: controller.selectedTransactionType.value == typeName
                      ? PRIMARY_COLOR
                      : const Color.fromARGB(255, 207, 214, 226),
                ),
              ),
              child: Text(
                typeName,
                textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(
                  color: controller.selectedTransactionType.value == typeName
                      ? WHITE_COLOR
                      : const Color.fromARGB(255, 62, 68, 87),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ),
      );

  Widget topWidget() => Padding(
        padding:
            const EdgeInsets.only(left: 12, right: 12, bottom: 10, top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //*back button
            InkWell(
              onTap: () => Get.back(),
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
            //*app logo
            Expanded(
              child: Text(
                'Transactions History',
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
              onTap: () {},
              child: Container(
                height: 35,
                width: 35,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 238, 230, 245),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: PRIMARY_COLOR.withOpacity(0.7),
                  ),
                ),
                child: SvgPicture.asset(
                  ICON_PATH + FILTER_SVG,
                  color: PRIMARY_COLOR,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      );
}
