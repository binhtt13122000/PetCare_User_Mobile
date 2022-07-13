import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/post_detail_page_controller.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PostDetailGeneralInformationWidget
    extends GetView<PostDetailPageController> {
  const PostDetailGeneralInformationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
              top: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                petBreedInformationWidget(),
                CUSTOM_TEXT(
                  controller.postModel.title,
                  fontSize: 17,
                  letterSpacing: 1,
                  textOverflow: TextOverflow.clip,
                ),
                Row(
                  children: [
                    priceWidget(),
                    const SizedBox(
                      width: 20,
                    ),
                    idWidget(),
                  ],
                ),
                Visibility(
                    visible: controller.accountModel.customerModel.id ==
                        controller.postModel.customerId,
                    child: statusWidget()),
                informationCartList(),
              ],
            ),
          ),
          Container(
            height: 1,
            margin: const EdgeInsets.only(top: 5),
            color: LIGHT_GREY_COLOR.withAlpha(30),
          ),
          Container(
            height: 8,
            color: SUPPER_LIGHT_BLUE,
          ),
        ],
      );

  Widget statusWidget() {
    late Color color;
    late String statusText;

    switch (controller.postModel.status) {
      case 'REQUESTED':
        color = YELLOW_COLOR.withOpacity(0.8);
        statusText = 'Waiting for approved';
        break;
      case 'REJECTED':
        color = RED_COLOR;
        statusText = 'Rejected';
        break;
      case 'PUBLISHED':
        color = GREEN_COLOR;
        statusText = 'Published for anyone';
        break;
      case 'CLOSED':
        color = DARK_GREY_TEXT_COLOR.withOpacity(0.7);
        statusText = 'Closed';
        break;
      case 'WAITING_FOR_PAYMENT':
        color = YELLOW_COLOR;
        statusText = 'Waiting for buyer payment';
        break;
      case 'CANCELED':
        color = RED_COLOR;
        statusText = 'Canceled';
        break;
      default:
        color = YELLOW_COLOR;
        statusText = controller.postModel.status;
    }
    return Row(children: [
      CUSTOM_TEXT(
        'Status: ',
        color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
      ),
      CUSTOM_TEXT(
        statusText,
        color: color,
      )
    ]);
  }

  Widget petBreedInformationWidget() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CUSTOM_TEXT('[${controller.postModel.type}] ',
              fontSize: 16,
              letterSpacing: 0,
              color: controller.postModel.type == 'SALE'
                  ? BLUE_COLOR
                  : PINK_COLOR),
          CUSTOM_TEXT(
            controller.postModel.petModel!.breedModel!.name,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
            color: DARK_GREY_TEXT_COLOR.withOpacity(0.85),
          ),
          CUSTOM_TEXT(
            ' (${controller.postModel.petModel!.breedModel!.speciesModel!.name})',
            color: DARK_GREY_TEXT_COLOR.withOpacity(0.85),
          ),
        ],
      );

  Widget idWidget() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CUSTOM_TEXT(
                'Id: ',
                fontSize: 18,
                color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
              ),
              CUSTOM_TEXT(
                (controller.postModel.id > 9 ? '#' : '#0') +
                    controller.postModel.id.toString(),
                color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
                fontSize: 18,
                letterSpacing: 1.5,
              )
            ],
          ),
        ],
      );

  Widget priceWidget() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CUSTOM_TEXT(
                'Price: ',
                fontSize: 18,
                color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
              ),
              CUSTOM_TEXT(
                FORMAT_MONEY(price: controller.postModel.transactionTotal),
                color: PRIMARY_COLOR,
                fontWeight: FontWeight.w500,
                fontSize: 25,
                letterSpacing: 1.5,
              )
            ],
          ),
        ],
      );

  Widget informationCartList() => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(
                  width: 1,
                  color: Colors.black12,
                ),
                color: WHITE_COLOR.withOpacity(0.6),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Type',
                    style: GoogleFonts.quicksand(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 95, 114, 136),
                    ),
                  ),
                  CUSTOM_TEXT(controller.postModel.type,
                      fontSize: 14,
                      letterSpacing: 1,
                      color: controller.postModel.type == 'SALE'
                          ? BLUE_COLOR
                          : PINK_COLOR),
                ],
              ),
            ),
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(
                  width: 1,
                  color: Colors.black12,
                ),
                color: WHITE_COLOR.withOpacity(0.6),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Gender',
                    style: GoogleFonts.quicksand(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 95, 114, 136),
                    ),
                  ),
                  Text(
                    controller.postModel.petModel!.gender,
                    style: GoogleFonts.quicksand(
                        fontSize: 15,
                        color: controller.postModel.petModel!.gender == 'MALE'
                            ? const Color.fromARGB(255, 39, 111, 245)
                            : const Color.fromARGB(255, 244, 55, 165),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(
                  width: 1,
                  color: Colors.black12,
                ),
                color: WHITE_COLOR.withOpacity(0.6),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Age',
                    style: GoogleFonts.quicksand(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 95, 114, 136),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: FittedBox(
                      alignment: Alignment.center,
                      fit: BoxFit.scaleDown,
                      child: Text(
                        controller.postModel.petModel!.ageRange,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                          fontSize: 13,
                          color: const Color.fromARGB(255, 68, 89, 114),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(
                  width: 1,
                  color: Colors.black12,
                ),
                color: WHITE_COLOR.withOpacity(0.6),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Weight',
                    style: GoogleFonts.quicksand(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 95, 114, 136),
                    ),
                  ),
                  Text(
                    '3.5 kg',
                    style: GoogleFonts.quicksand(
                        fontSize: 15,
                        color: const Color.fromARGB(255, 68, 89, 114),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
