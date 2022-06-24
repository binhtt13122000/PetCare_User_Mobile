import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/transaction_list_page_controller.dart';
import 'package:petapp_mobile/models/breeding_transaction_model/breeding_transaction_model.dart';
import 'package:petapp_mobile/services/transaction_services/breeding_transaction_services.dart';
import 'package:petapp_mobile/services/other_services/customer_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class BreedingTransactionListWidget
    extends GetView<TransactionListPageController> {
  const BreedingTransactionListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          breedingTransactionTypeListWidget(),
          Expanded(
            child: GetBuilder<TransactionListPageController>(
              builder: (_) {
                controller.isLoadingBreedingTransaction.value = true;
                WidgetsBinding.instance!.addPostFrameCallback((_) async {
                  controller
                    ..breedingTransactionModelList =
                        await BreedingTransactionService
                            .fetchBreedingTransactionList(
                      petOwnerFemaleId: controller
                                  .selectedBreedingTransactionType.value ==
                              'Transaction role: [BUYER]'
                          ? controller.accountModel.customerModel.id.toString()
                          : null,
                      petOwnerMaleId: controller
                                  .selectedBreedingTransactionType.value ==
                              'Transaction role: [SELLER]'
                          ? controller.accountModel.customerModel.id.toString()
                          : null,
                      page: controller.page.toString(),
                      limit: controller.limit.toString(),
                    )
                    ..accountModel.customerModel =
                        await CustomerService.fetchCustomerById(
                            controller.accountModel.customerModel.id);
                  Get.find<AuthController>().accountModel.customerModel =
                      controller.accountModel.customerModel;
                  controller.isLoadingBreedingTransaction.value = false;
                });
                return Obx(
                  () => controller.isLoadingBreedingTransaction.value
                      ? const SpinKitSpinningLines(
                          color: PRIMARY_COLOR,
                          size: 150,
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: controller.breedingTransactionModelList
                                .asMap()
                                .entries
                                .map((e) => breedingTransactionItemWidget(
                                    breedingTransactionModel: e.value))
                                .toList(),
                          ),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget breedingTransactionTypeItemWidget(
          {required String saleTransactionType, int flex = 1}) =>
      Expanded(
        flex: flex,
        child: Obx(
          () => InkWell(
            onTap: () => controller
              ..selectedBreedingTransactionType.value = saleTransactionType
              ..update(),
            child: Column(
              children: [
                Container(
                  height: 30,
                  color: controller.selectedBreedingTransactionType.value ==
                          saleTransactionType
                      ? PRIMARY_LIGHT_COLOR.withOpacity(0.3)
                      : Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          maxRadius: 3,
                          backgroundColor: controller
                                      .selectedBreedingTransactionType.value ==
                                  saleTransactionType
                              ? PRIMARY_COLOR
                              : Colors.transparent,
                        ),
                      ),
                      Text(
                        saleTransactionType,
                        style: GoogleFonts.quicksand(
                          color: controller
                                      .selectedBreedingTransactionType.value ==
                                  saleTransactionType
                              ? PRIMARY_COLOR
                              : const Color.fromARGB(255, 116, 122, 143),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 3,
                  color: controller.selectedBreedingTransactionType.value ==
                          saleTransactionType
                      ? PRIMARY_COLOR
                      : const Color.fromARGB(255, 233, 235, 241),
                ),
              ],
            ),
          ),
        ),
      );

  Widget breedingTransactionTypeListWidget() => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: controller.saleTransactionTypeList
              .asMap()
              .entries
              .map((e) => breedingTransactionTypeItemWidget(
                  saleTransactionType: e.value))
              .toList(),
        ),
      );

  Widget breedingTransactionItemWidget(
      {required BreedingTransactionModel breedingTransactionModel}) {
    late String displayStatus;
    late Color statusColor;
    late String timeTitle;
    late DateTime timeValue;

    if (controller.accountModel.customerModel.id ==
        breedingTransactionModel.ownerPetFemaleId) {
      switch (breedingTransactionModel.status) {
        case 'CREATED':
          displayStatus = 'Waiting to pick up pet and pay';
          statusColor = YELLOW_COLOR;
          timeTitle = 'Meeting time';
          timeValue = breedingTransactionModel.meetingTime;
          break;
        case 'CANCELED':
          displayStatus = 'The transaction has been canceled';
          statusColor = RED_COLOR;
          timeTitle = 'Cancel time';
          timeValue = DateTime.now();
          break;
        case 'SUCCESS':
          displayStatus = 'The transaction is completed';
          statusColor = GREEN_COLOR;
          timeTitle = 'Payment time';
          timeValue = breedingTransactionModel.paymentForBranchTime!;
          break;

        default:
          displayStatus = 'Waiting to pick up pet and pay';
          statusColor = YELLOW_COLOR;
          timeTitle = 'Meeting time';
          timeValue = breedingTransactionModel.meetingTime;
      }
    } else {
      switch (breedingTransactionModel.status) {
        case 'CREATED':
          displayStatus = 'Waiting for meeting with buyer';
          statusColor = YELLOW_COLOR;
          timeTitle = 'Meeting time';
          timeValue = breedingTransactionModel.meetingTime;
          break;
        case 'CANCELED':
          displayStatus = 'The transaction has been canceled';

          statusColor = RED_COLOR;
          timeTitle = 'Cancel time';
          timeValue = DateTime.now();
          break;
        case 'SUCCESS':
          displayStatus = 'The transaction is completed';
          statusColor = GREEN_COLOR;
          timeTitle = 'Payment time';
          timeValue = breedingTransactionModel.paymentForBranchTime!;
          break;
        default:
          displayStatus = breedingTransactionModel.status;
          statusColor = GREEN_COLOR;
          timeTitle = 'Meeting time';
          timeValue = DateTime.now();
      }
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: InkWell(
        onTap: () => Get.toNamed(
            '$BREEDING_TRANSACTION_DETAIL_PAGE_ROUTE/${breedingTransactionModel.id}'),
        child: Container(
          height: 110,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 247, 249, 253),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 227, 230, 238),
                blurRadius: 3,
                offset: Offset(3, 3),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Transaction id',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.quicksand(
                      color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      height: 1,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    '#0${breedingTransactionModel.id}',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.quicksand(
                      color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      height: 1,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total price',
                    textAlign: TextAlign.end,
                    style: GoogleFonts.quicksand(
                      color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      height: 1,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    FORMAT_MONEY(
                        price: breedingTransactionModel.transactionTotal),
                    textAlign: TextAlign.end,
                    style: GoogleFonts.quicksand(
                      color: PRIMARY_COLOR,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      height: 1,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Status',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.quicksand(
                      color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      height: 1,
                    ),
                  ),
                  Text(
                    displayStatus,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.quicksand(
                      color: statusColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      height: 1,
                    ),
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       controller.selectedBreedingTransactionType.value ==
              //               'Transaction role: [BUYER]'
              //           ? 'Seller'
              //           : 'Buyer',
              //       textAlign: TextAlign.start,
              //       style: GoogleFonts.quicksand(
              //         color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
              //         fontWeight: FontWeight.w500,
              //         fontSize: 13,
              //         height: 1,
              //       ),
              //     ),
              //     Text(
              //       controller.selectedBreedingTransactionType.value ==
              //               'Transaction role: [BUYER]'
              //           ? '${breedingTransactionModel.ownerPetFemaleCustomerModel.firstName} ${breedingTransactionModel.ownerPetFemaleCustomerModel.lastName}'
              //           : '${breedingTransactionModel.ownerPetMaleCustomerModel.firstName} ${breedingTransactionModel.ownerPetMaleCustomerModel.lastName}',
              //       textAlign: TextAlign.start,
              //       style: GoogleFonts.quicksand(
              //         color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
              //         fontWeight: FontWeight.w500,
              //         fontSize: 13,
              //         height: 1,
              //       ),
              //     ),
              //   ],
              // ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CUSTOM_TEXT(
                    'Female pet',
                    color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
                    fontSize: 13,
                  ),
                  CUSTOM_TEXT(
                    breedingTransactionModel.femalePetModel.breedModel!.name +
                        ' - ' +
                        breedingTransactionModel
                            .femalePetModel.breedModel!.speciesModel!.name,
                    color: PINK_COLOR,
                    fontSize: 13,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    timeTitle,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.quicksand(
                      color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      height: 1,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    FORMAT_DATE_TIME(
                        dateTime: timeValue, pattern: DATE_TIME_PATTERN),
                    textAlign: TextAlign.start,
                    style: GoogleFonts.quicksand(
                      color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      height: 1,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
