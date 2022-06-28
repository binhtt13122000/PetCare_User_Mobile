// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:petapp_mobile/configs/path.dart';
// import 'package:petapp_mobile/configs/route.dart';
// import 'package:petapp_mobile/configs/theme.dart';
// import 'package:petapp_mobile/controllers/transaction_page_controllers/breeding_transaction_detail_page_controller.dart';
// import 'package:petapp_mobile/services/transaction_services/breeding_transaction_services.dart';
// import 'package:petapp_mobile/utilities/utilities.dart';

// class BreedingTransactionDetailBreedingServicesBottomWidget
//     extends GetView<BreedingTransactionDetailPageController> {
//   const BreedingTransactionDetailBreedingServicesBottomWidget({Key? key})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) => Container(
//       color: WHITE_COLOR,
//       child:
//           controller.breedingTransactionModel.ownerPetFemaleCustomerModel.id ==
//                   controller.accountModel.customerModel.id
//               ? femalePetBottomWidget()
//               : malePetBottomWidget());

//   Widget ratingWidget() => Column(
//         children: [
//           Container(
//             height: 1,
//             color: DARK_GREY_COLOR.withAlpha(50),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             child: InkWell(
//               onTap: () async {
//                 controller
//                   ..reviewType = 'SERVICES_REVIEW'
//                   ..isShowReviewPopup.value = true;
//               },
//               child: Container(
//                 height: 35,
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   color: PRIMARY_COLOR,
//                 ),
//                 child: Text(
//                   'Rate Your Services Experience',
//                   textAlign: TextAlign.center,
//                   style: GoogleFonts.quicksand(
//                     textStyle: const TextStyle(color: WHITE_COLOR),
//                     fontWeight: FontWeight.w600,
//                     fontSize: 13,
//                     height: 1,
//                     letterSpacing: 2,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       );

//   Widget malePetBottomWidget() => Column(
//         children: [
//           Visibility(
//             visible: ![
//                   'CREATED',
//                   'CANCELED',
//                   'EXPIRED',
//                   'SUCCESS',
//                   'BREEDING_REQUESTED',
//                   'BREEDING_EXPIRED',
//                   'BREEDING_CANCELED',
//                   'IN_PROGRESS',
//                   'PAYMENTED',
//                 ].contains(controller.breedingTransactionModel.status) &&
//                 controller.breedingTransactionModel.pickupMalePetTime == null,
//             child: pickupWidget(),
//           ),
//         ],
//       );

//   Widget femalePetBottomWidget() => Column(
//         children: [
//           controller.breedingTransactionModel.status == 'BREEDING_FINISHED'
//               ? paymentWidget()
//               : const SizedBox.shrink(),
//           controller.breedingTransactionModel.paymentTime != null &&
//                   (controller.breedingTransactionModel.starBranch == null ||
//                       controller.breedingTransactionModel.starBranch == 0)
//               ? ratingWidget()
//               : const SizedBox.shrink(),
//         ],
//       );

//   Widget pickupWidget() => Column(
//         children: [
//           Container(
//             height: 1,
//             color: DARK_GREY_COLOR.withAlpha(50),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             child: InkWell(
//               onTap: () async {
//                 controller
//                   ..confirmPopupTitle =
//                       'Are you sure to confirm you have been pickup your pet?'
//                   ..onTapOk = () async {
//                     controller
//                       ..isShowConfirmPopup.value = false
//                       ..isWaitingForeground.value = true;
//                     await BreedingTransactionService.pickUpMalePet(
//                         id: controller.breedingTransactionModel.id,
//                         pickupMalePetTime: DateTime.now());
//                     controller
//                       ..isWaitingForeground.value = false
//                       ..popupTitle =
//                           'Confirm you have been pickup your pet successfully!'
//                       ..isShowPopup.value = true;
//                   }
//                   ..isShowConfirmPopup.value = true;
//               },
//               child: Container(
//                 height: 35,
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   color: PRIMARY_COLOR,
//                 ),
//                 child: Text(
//                   'Confirm Pickup Pet',
//                   textAlign: TextAlign.center,
//                   style: GoogleFonts.quicksand(
//                     textStyle: const TextStyle(color: WHITE_COLOR),
//                     fontWeight: FontWeight.w700,
//                     fontSize: 15,
//                     height: 1,
//                     letterSpacing: 2,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       );

//   Widget paymentWidget() => Column(
//         children: [
//           Container(
//             height: 1,
//             color: DARK_GREY_COLOR.withAlpha(50),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(
//               top: 10,
//             ),
//             child: Row(
//               children: [
//                 InkWell(
//                   onTap: () => Get.toNamed(
//                       CENTER_SERVICES_TRANSACTION_PAYMENT_METHOD_PAGE_ROUTE),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 10,
//                     ),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Image.asset(
//                           IMAGE_PATH + VNPAY_PNG,
//                           height: 28,
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           '****98',
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.quicksand(
//                             textStyle:
//                                 const TextStyle(color: PRIMARY_DARK_COLOR),
//                             fontWeight: FontWeight.w600,
//                             fontSize: 18,
//                             height: 1,
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 20,
//                         ),
//                         SvgPicture.asset(
//                           ICON_PATH + UP_ARROW_SVG,
//                           height: 14,
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Container(
//                           height: 30,
//                           width: 1.5,
//                           color: LIGHT_GREY_COLOR.withAlpha(60),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: FittedBox(
//                     fit: BoxFit.scaleDown,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           FORMAT_MONEY(
//                               price: controller
//                                   .breedingTransactionModel.transactionTotal),
//                           textAlign: TextAlign.start,
//                           style: GoogleFonts.quicksand(
//                             textStyle: const TextStyle(
//                               color: PRIMARY_COLOR,
//                             ),
//                             fontWeight: FontWeight.w500,
//                             fontSize: 24,
//                             height: 1,
//                             letterSpacing: 2,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             child: InkWell(
//               onTap: () async {
//                 controller.isWaitingForeground.value = true;
//                 await BreedingTransactionService.quickPaymentForBranch(
//                     id: controller.breedingTransactionModel.id,
//                     paymentForBranchTime: DateTime.now());
//                 controller
//                   ..isWaitingForeground.value = false
//                   ..popupTitle = 'Payment successfully!'
//                   ..isShowPopup.value = true;
//               },
//               child: Container(
//                 height: 45,
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   color: PRIMARY_COLOR,
//                 ),
//                 child: Text(
//                   'Payment',
//                   textAlign: TextAlign.center,
//                   style: GoogleFonts.quicksand(
//                     textStyle: const TextStyle(color: WHITE_COLOR),
//                     fontWeight: FontWeight.w600,
//                     fontSize: 20,
//                     height: 1,
//                     letterSpacing: 2,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       );
// }
