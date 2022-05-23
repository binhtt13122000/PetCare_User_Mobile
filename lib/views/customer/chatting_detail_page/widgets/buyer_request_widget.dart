import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/chatting_detail_page_controller.dart';
import 'package:petapp_mobile/utilities/utilities.dart';

class BuyerRequestWidget extends GetView<ChattingDetailPageController> {
  const BuyerRequestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: controller.isShowBuyerRequest.value,
        child: Stack(
          children: [
            InkWell(
              onTap: () => controller.isShowBuyerRequest.value = false,
              child: Container(
                color: const Color.fromARGB(106, 198, 188, 201),
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: 300,
                    height: 470,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      color: WHITE_COLOR,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Buyer Transaction Request',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.quicksand(
                            color: PRIMARY_COLOR,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                        ),
                        transactionTimeWidget(),
                        transactionLocationWidget(
                            ownerAddress:
                                controller.accountModel.customerModel.address!),
                        descriptionWidget(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            denineBuyerRequestWidget(),
                            acceptBuyerRequestWidget(),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget acceptBuyerRequestWidget() => InkWell(
        onTap: () => controller.isShowCreateRequest.value = true,
        child: Container(
          height: 35,
          width: 230,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 60, 202, 190),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: const Color.fromARGB(255, 35, 170, 159),
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
                'Accept request',
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: GoogleFonts.quicksand(
                  color: WHITE_COLOR,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3),
                child: SvgPicture.asset(
                  ICON_PATH + ADD_SVG,
                  height: 16,
                  color: WHITE_COLOR,
                ),
              ),
            ],
          ),
        ),
      );

  Widget transactionLocationWidget({required String ownerAddress}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: SvgPicture.asset(
                      ICON_PATH + LOCATION_SVG,
                      height: 20,
                      color: const Color.fromARGB(255, 61, 78, 100),
                    ),
                  ),
                  Text(
                    'Transaction location',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 61, 78, 100),
                      fontSize: 16,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 100,
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
          child: Text(
            controller.chatRoomModel!.transactionPlace!,
            textAlign: TextAlign.start,
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.w500,
              color: const Color.fromARGB(255, 113, 135, 168),
              fontSize: 15,
              letterSpacing: 1,
            ),
          ),
        ),
      ],
    );
  }

  Widget descriptionWidget() {
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
          child: Expanded(
            child: Text(
              controller.chatRoomModel!.description ?? '',
              textAlign: TextAlign.start,
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(255, 113, 135, 168),
                fontSize: 15,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget transactionTimeWidget() => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: SvgPicture.asset(
                        ICON_PATH + CLOCK_SVG,
                        height: 17,
                        color: const Color.fromARGB(255, 61, 78, 100),
                      ),
                    ),
                    Text(
                      'Transaction time',
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 61, 78, 100),
                        fontSize: 16,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 40,
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
                  child: Text(
                    FORMAT_DATE_TIME(
                        dateTime: controller.chatRoomModel!.transactionTime!,
                        pattern: DATE_TIME_PATTERN),
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 113, 135, 168),
                      fontSize: 15,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const Icon(
                  Icons.calendar_month_rounded,
                  color: PRIMARY_COLOR,
                ),
              ],
            ),
          ),
        ],
      );

  Widget denineBuyerRequestWidget() => InkWell(
        onTap: () => Get.back(),
        child: Container(
          height: 35,
          width: 100,
          decoration: BoxDecoration(
            color: WHITE_COLOR,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: const Color.fromARGB(255, 228, 134, 151),
              width: 0.5,
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
                'Denine request',
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: GoogleFonts.quicksand(
                  color: const Color.fromARGB(255, 226, 66, 93),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: SvgPicture.asset(
                  ICON_PATH + CLOSE_SVG,
                  height: 12,
                  color: const Color.fromARGB(255, 226, 66, 93),
                ),
              ),
            ],
          ),
        ),
      );
}
