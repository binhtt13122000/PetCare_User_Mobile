import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/purchase_post_detail_page_controller.dart';
import 'package:petapp_mobile/utilities/utilities.dart';

class PostGeneralInformationWidget
    extends GetView<PurchasePostDetailPageController> {
  const PostGeneralInformationWidget({Key? key}) : super(key: key);

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
                petBreedInforWidget(),
                Text(
                  controller.postModel.description!,
                  style: GoogleFonts.quicksand(
                    fontSize: 15,
                    color: const Color.fromARGB(255, 59, 71, 85),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
                priceWidget(),
                informationCartList(),
              ],
            ),
          ),
          Container(
            height: 1,
            margin: const EdgeInsets.only(top: 5),
            color: LIGHT_GREY_COLOR.withOpacity(0.1),
          ),
          Container(
            height: 8,
            color: const Color.fromARGB(255, 247, 248, 250),
          ),
        ],
      );

  Widget petBreedInforWidget() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            controller.postModel.petModel!.breedModel.name,
            style: GoogleFonts.quicksand(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color.fromARGB(255, 56, 75, 97),
              wordSpacing: 0,
              letterSpacing: 2.5,
            ),
          ),
          Text(
            '(${controller.postModel.petModel!.breedModel.speciesModel!.name})',
            style: GoogleFonts.quicksand(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color.fromARGB(255, 56, 75, 97),
              height: 1.3,
              letterSpacing: 2.5,
            ),
          ),
        ],
      );

  Widget priceWidget() => Padding(
        padding: const EdgeInsets.only(
          top: 4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Price: ',
                  style: GoogleFonts.quicksand(
                    fontSize: 17,
                    color: const Color.fromARGB(255, 95, 114, 136),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  FORMAT_MONEY(price: controller.postModel.provisionalTotal),
                  style: GoogleFonts.quicksand(
                    fontSize: 20,
                    // color:
                    //     const Color.fromARGB(255, 244, 55, 159),
                    color: PRIMARY_COLOR,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Deposit: ',
                  style: GoogleFonts.quicksand(
                    fontSize: 15,
                    color: const Color.fromARGB(255, 95, 114, 136),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  FORMAT_MONEY(price: 235000),
                  style: GoogleFonts.quicksand(
                    fontSize: 18,
                    // color:
                    //     const Color.fromARGB(255, 244, 55, 159),
                    color: PRIMARY_COLOR,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
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
                  Text(
                    controller.postModel.type!,
                    style: GoogleFonts.quicksand(
                        fontSize: 12,
                        color: PRIMARY_COLOR,
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
