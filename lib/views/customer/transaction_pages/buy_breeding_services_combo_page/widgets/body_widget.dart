import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/buy_breeding_services_combo_page_controller.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/buy_breeding_services_combo_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/buy_breeding_services_combo_page/widgets/list_combo_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class BuyBreedingServicesComboBodyWidget
    extends GetView<BuyBreedingServicesComboPageController> {
  const BuyBreedingServicesComboBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          color: SUPPER_LIGHT_BLUE,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const BuyBreedingServicesComboListComboWidget(),
                      Container(
                        height: 1,
                        color: LIGHT_GREY_COLOR.withAlpha(30),
                      ),
                      Container(
                        height: 20,
                        color: SUPPER_LIGHT_BLUE,
                      ),
                      branchWidget(),
                      Container(
                        height: 1,
                        color: LIGHT_GREY_COLOR.withAlpha(30),
                      ),
                      Container(
                        height: 50,
                        color: SUPPER_LIGHT_BLUE,
                      ),
                    ],
                  ),
                ),
              ),
              const BuyBreedingServicesComboBottomWidget(),
            ],
          ),
        ),
      );

  Widget branchWidget() => Container(
        color: WHITE_COLOR,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            CUSTOM_TEXT(
              'Branch perform services',
              padding: const EdgeInsets.only(bottom: 10),
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
            textCardWidget(
                keyText: 'Name',
                valueText: controller
                    .breedingTransactionModel.breedingBranchModel!.name),
            textCardWidget(
                keyText: 'Phone number',
                valueText: controller
                    .breedingTransactionModel.breedingBranchModel!.phoneNumber),
            textCardWidget(
                keyText: 'Address',
                valueText: controller.breedingTransactionModel
                        .breedingBranchModel!.address ??
                    'N/A'),
          ],
        ),
      );

  Widget textCardWidget({required String keyText, required String valueText}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CUSTOM_TEXT(
              keyText,
              fontSize: 15,
              color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
              padding: const EdgeInsets.only(right: 20),
            ),
            Expanded(
              child: CUSTOM_TEXT(valueText,
                  fontSize: 15,
                  textAlign: TextAlign.end,
                  textOverflow: TextOverflow.clip),
            ),
          ],
        ),
      );

  // Widget bookingDateWidget() => Expanded(
  //       child: Padding(
  //         padding: const EdgeInsets.only(left: 20, right: 30),
  //         child: InkWell(
  //           onTap: () {},
  //           child: Container(
  //             height: 40,
  //             decoration: BoxDecoration(
  //               border: Border.all(
  //                 color: const Color.fromARGB(255, 167, 181, 201),
  //                 width: 1.2,
  //               ),
  //               borderRadius: BorderRadius.circular(5),
  //               color: WHITE_COLOR,
  //             ),
  //             child: Row(
  //               children: [
  //                 Expanded(
  //                   child: Padding(
  //                     padding: const EdgeInsets.only(left: 20),
  //                     child: Obx(
  //                       () => CUSTOM_TEXT(
  //                         controller.registerDateText.value.isNotEmpty
  //                             ? controller.registerDateText.value
  //                             : 'dd/MM/yyyy',
  //                         textAlign: TextAlign.left,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 const Padding(
  //                   padding: EdgeInsets.only(right: 10),
  //                   child: Icon(
  //                     Icons.calendar_month_rounded,
  //                     color: PRIMARY_COLOR,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
}
