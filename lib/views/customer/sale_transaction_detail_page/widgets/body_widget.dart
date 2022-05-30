// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:petapp_mobile/configs/path.dart';
// import 'package:petapp_mobile/configs/theme.dart';
// import 'package:petapp_mobile/controllers/sale_transaction_detail_page_controller.dart';
// import 'package:petapp_mobile/utilities/utilities.dart';

// class PurchaseTransactionDetaiBodyWidget
//     extends GetView<SaleTransactionDetailPageController> {
//   const PurchaseTransactionDetaiBodyWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;

//     return Expanded(
//       child: Container(
//         color: const Color.fromARGB(255, 245, 248, 253),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               saleTransactionInformationWidget(),
//               //saleTransactionStatusWidget(),

//               petInfomationWidget(),
//               Container(
//                 height: 1,
//                 color: LIGHT_GREY_COLOR.withOpacity(0.1),
//               ),
//               Container(
//                 color: const Color.fromARGB(255, 245, 248, 253),
//                 height: 16,
//               ),
//               saleTransactionPriceWidget(width: width),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget saleTransactionPriceWidget({required double width}) => Stack(
//         children: [
//           Column(
//             children: [
//               Container(
//                 color: WHITE_COLOR,
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 15,
//                   horizontal: 20,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Provisional total',
//                           style: GoogleFonts.quicksand(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500,
//                             color: const Color.fromARGB(255, 77, 82, 105),
//                           ),
//                         ),
//                         Text(
//                           FORMAT_MONEY(
//                               price: controller
//                                   .saleTransactionModel.transactionTotal),
//                           style: GoogleFonts.quicksand(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500,
//                             color: const Color.fromARGB(255, 77, 82, 105),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Fees charged ',
//                               style: GoogleFonts.quicksand(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w500,
//                                 color: const Color.fromARGB(255, 77, 82, 105),
//                               ),
//                             ),
//                             Icon(
//                               Icons.info_outline_rounded,
//                               size: 15,
//                               color: DARK_GREY_COLOR.withAlpha(100),
//                             ),
//                           ],
//                         ),
//                         Text(
//                           FORMAT_MONEY(price: 0),
//                           style: GoogleFonts.quicksand(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500,
//                             color: const Color.fromARGB(255, 77, 82, 105),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       margin: const EdgeInsets.symmetric(vertical: 15),
//                       height: 1,
//                       color: DARK_GREY_COLOR.withAlpha(150),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Total price',
//                           style: GoogleFonts.quicksand(
//                             fontSize: 17,
//                             fontWeight: FontWeight.w700,
//                             color: const Color.fromARGB(255, 77, 82, 105),
//                             letterSpacing: 1,
//                           ),
//                         ),
//                         Text(
//                           FORMAT_MONEY(
//                               price: controller
//                                   .saleTransactionModel.transactionTotal),
//                           style: GoogleFonts.quicksand(
//                             fontSize: 20,
//                             fontWeight: FontWeight.w700,
//                             color: PRIMARY_COLOR,
//                             letterSpacing: 1,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 color: WHITE_COLOR,
//                 height: 10,
//               ),
//               Container(
//                 color: const Color.fromARGB(255, 245, 248, 253),
//                 height: 16,
//               ),
//             ],
//           ),
//           rhombusItemListWidget(screenWidth: width),
//         ],
//       );

//   Widget evidenceWidget() => Container(
//         color: WHITE_COLOR,
//         padding: const EdgeInsets.symmetric(
//           vertical: 15,
//           horizontal: 20,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Contract evidences',
//               style: GoogleFonts.quicksand(
//                   fontSize: 15, fontWeight: FontWeight.w500),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             // Row(
//             //   children: [
//             //     Expanded(
//             //       child: SingleChildScrollView(
//             //         scrollDirection: Axis.horizontal,
//             //         child: Row(
//             //           children: controller
//             //               .saleTransactionModel
//             //               .mediaModelsForBuyer
//             //               .asMap()
//             //               .entries
//             //               .map(
//             //                 (e) => Row(
//             //                   children: [
//             //                     Stack(
//             //                       children: [
//             //                         ClipRRect(
//             //                           borderRadius:
//             //                               const BorderRadius
//             //                                   .all(
//             //                             Radius
//             //                                 .circular(
//             //                                     7),
//             //                           ),
//             //                           child: Image
//             //                               .network(
//             //                             e.value.url,
//             //                             height: 100,
//             //                             fit: BoxFit
//             //                                 .cover,
//             //                           ),
//             //                         ),
//             //                         const Positioned(
//             //                           child: Icon(
//             //                             Icons
//             //                                 .zoom_out_map,
//             //                             size: 20,
//             //                             color:
//             //                                 PRIMARY_COLOR,
//             //                           ),
//             //                           bottom: 5,
//             //                           right: 5,
//             //                         ),
//             //                       ],
//             //                     ),
//             //                     const SizedBox(
//             //                       width: 10,
//             //                     ),
//             //                   ],
//             //                 ),
//             //               )
//             //               .toList(),
//             //         ),
//             //       ),
//             //     ),
//             //   ],
//             // )
//           ],
//         ),
//       );

//   Widget saleTransactionStatusWidget() => Container(
//         color: WHITE_COLOR,
//         padding: const EdgeInsets.symmetric(
//           vertical: 15,
//           horizontal: 40,
//         ),
//         child: Row(
//           children: [
//             Column(
//               children: [
//                 const CircleAvatar(
//                   radius: 8,
//                   backgroundColor: PRIMARY_COLOR,
//                   child: Icon(
//                     Icons.check_circle_outline_rounded,
//                     color: WHITE_COLOR,
//                     size: 15,
//                   ),
//                 ),
//                 controller.saleTransactionModel.status == 'NOT_PET_AVAILABLE'
//                     ? const SizedBox(
//                         height: 15,
//                         child: RotatedBox(
//                           quarterTurns: 1,
//                           child: SizedBox(
//                             height: 2,
//                             child: LinearProgressIndicator(
//                               valueColor: AlwaysStoppedAnimation<Color>(
//                                 PRIMARY_COLOR,
//                               ),
//                               backgroundColor: Color(0xFFD1C1E0),
//                             ),
//                           ),
//                         ),
//                       )
//                     : Container(
//                         height: 15,
//                         width: 2,
//                         color: PRIMARY_COLOR,
//                       ),
//                 CircleAvatar(
//                   radius: 8,
//                   backgroundColor: controller.saleTransactionModel.status ==
//                           'NOT_PET_AVAILABLE'
//                       ? PRIMARY_COLOR.withAlpha(160)
//                       : PRIMARY_COLOR,
//                   child: Icon(
//                     controller.saleTransactionModel.status ==
//                             'NOT_PET_AVAILABLE'
//                         ? Icons.remove_circle_outline
//                         : Icons.check_circle_outline_rounded,
//                     color: WHITE_COLOR,
//                     size: 15,
//                   ),
//                 ),
//                 controller.saleTransactionModel.status == 'PET_AVAILABLE'
//                     ? const SizedBox(
//                         height: 15,
//                         child: RotatedBox(
//                           quarterTurns: 1,
//                           child: SizedBox(
//                             height: 2,
//                             child: LinearProgressIndicator(
//                               valueColor: AlwaysStoppedAnimation<Color>(
//                                 PRIMARY_COLOR,
//                               ),
//                               backgroundColor: Color(0xFFD1C1E0),
//                             ),
//                           ),
//                         ),
//                       )
//                     : Container(
//                         height: 15,
//                         width: 2,
//                         color: controller.saleTransactionModel.status ==
//                                     'RECEIVED' ||
//                                 controller.saleTransactionModel.status ==
//                                     'PAYMENTED'
//                             ? PRIMARY_COLOR
//                             : PRIMARY_COLOR.withAlpha(100),
//                       ),
//                 CircleAvatar(
//                   radius: 8,
//                   backgroundColor: controller.saleTransactionModel.status ==
//                               'RECEIVED' ||
//                           controller.saleTransactionModel.status == 'PAYMENTED'
//                       ? PRIMARY_COLOR
//                       : PRIMARY_COLOR.withAlpha(100),
//                   child: Icon(
//                     controller.saleTransactionModel.status == 'RECEIVED' ||
//                             controller.saleTransactionModel.status ==
//                                 'PAYMENTED'
//                         ? Icons.check_circle_outline_rounded
//                         : Icons.remove_circle_outline,
//                     color: WHITE_COLOR,
//                     size: 15,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               width: 40,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   child: Text(
//                     'Deposited',
//                     style: GoogleFonts.quicksand(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: PRIMARY_COLOR,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 SizedBox(
//                   child: Text(
//                     'Pet available to recive',
//                     style: GoogleFonts.quicksand(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: controller.saleTransactionModel.status ==
//                               'NOT_PET_AVAILABLE'
//                           ? PRIMARY_COLOR.withAlpha(160)
//                           : PRIMARY_COLOR,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 SizedBox(
//                   child: Text(
//                     'Paymented and recieved pet',
//                     style: GoogleFonts.quicksand(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: controller.saleTransactionModel.status ==
//                                   'RECEIVED' ||
//                               controller.saleTransactionModel.status ==
//                                   'PAYMENTED'
//                           ? PRIMARY_COLOR
//                           : PRIMARY_COLOR.withAlpha(160),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       );

//   Widget saleTransactionInformationWidget() {
//     late String displayStatus;
//     late Color statusColor;
//     if (controller.accountModel.customerModel.id ==
//         controller.saleTransactionModel.buyerId) {
//       switch (controller.saleTransactionModel.status) {
//         case 'CREATED':
//           displayStatus = 'Waiting to pick up pet and pay';
//           statusColor = const Color.fromARGB(255, 247, 203, 60);
//           break;
//         default:
//           displayStatus = controller.saleTransactionModel.status;
//           statusColor = const Color.fromARGB(255, 43, 248, 204);
//       }
//     } else {
//       switch (controller.saleTransactionModel.status) {
//         default:
//           displayStatus = controller.saleTransactionModel.status;
//           statusColor = const Color.fromARGB(255, 43, 248, 204);
//       }
//     }
//     return Column(
//       children: [
//         Container(
//           color: const Color.fromARGB(255, 245, 248, 253),
//           padding: const EdgeInsets.symmetric(
//             vertical: 8,
//             horizontal: 20,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Transaction ID',
//                 style: GoogleFonts.quicksand(
//                   fontSize: 13,
//                   color: DARK_GREY_COLOR.withAlpha(130),
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               Text(
//                 '#0' + controller.saleTransactionModel.id.toString(),
//                 style: GoogleFonts.quicksand(
//                   fontSize: 13,
//                   color: DARK_GREY_COLOR.withAlpha(130),
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Container(
//           color: WHITE_COLOR,
//           padding: const EdgeInsets.symmetric(
//             vertical: 15,
//             horizontal: 20,
//           ),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Transaction type',
//                     style: GoogleFonts.quicksand(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                       color: const Color.fromARGB(255, 77, 82, 105),
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                   Text(
//                     'Purchase',
//                     style: GoogleFonts.quicksand(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                       color: const Color.fromARGB(255, 77, 82, 105),
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Your transaction role',
//                     style: GoogleFonts.quicksand(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                       color: const Color.fromARGB(255, 77, 82, 105),
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                   Text(
//                     controller.saleTransactionModel.buyerId ==
//                             controller.accountModel.customerModel.id
//                         ? 'Buyer'
//                         : 'Seller',
//                     style: GoogleFonts.quicksand(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                       color: const Color.fromARGB(255, 77, 82, 105),
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Create time',
//                     style: GoogleFonts.quicksand(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                       color: const Color.fromARGB(255, 77, 82, 105),
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                   Text(
//                     FORMAT_DATE_TIME(
//                         dateTime: controller.saleTransactionModel.createdTime,
//                         pattern: DATE_TIME_PATTERN),
//                     style: GoogleFonts.quicksand(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                       color: const Color.fromARGB(255, 77, 82, 105),
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Status',
//                     style: GoogleFonts.quicksand(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                       color: const Color.fromARGB(255, 77, 82, 105),
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                   Text(
//                     displayStatus,
//                     style: GoogleFonts.quicksand(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                       color: statusColor,
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                 ],
//               ),
//               Container(
//                 margin: const EdgeInsets.symmetric(
//                   vertical: 5,
//                   horizontal: 15,
//                 ),
//                 height: 1,
//                 color: DARK_GREY_COLOR.withAlpha(50),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Meeting time',
//                     style: GoogleFonts.quicksand(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                       color: const Color.fromARGB(255, 77, 82, 105),
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                   Text(
//                     FORMAT_DATE_TIME(
//                         dateTime: controller.saleTransactionModel.meetingTime,
//                         pattern: DATE_TIME_PATTERN),
//                     style: GoogleFonts.quicksand(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                       color: const Color.fromARGB(255, 77, 82, 105),
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Metting place',
//                     style: GoogleFonts.quicksand(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                       color: const Color.fromARGB(255, 77, 82, 105),
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                   Text(
//                     controller.saleTransactionModel.placeMeeting,
//                     style: GoogleFonts.quicksand(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                       color: const Color.fromARGB(255, 77, 82, 105),
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                 ],
//               ),
//               Container(
//                 margin: const EdgeInsets.symmetric(
//                   vertical: 5,
//                   horizontal: 15,
//                 ),
//                 height: 1,
//                 color: DARK_GREY_COLOR.withAlpha(50),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Deposits time',
//                     style: GoogleFonts.quicksand(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                       color: const Color.fromARGB(255, 77, 82, 105),
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                   Text(
//                     'N/A',
//                     style: GoogleFonts.quicksand(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                       color: const Color.fromARGB(255, 77, 82, 105),
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         'Deposits',
//                         style: GoogleFonts.quicksand(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                           color: const Color.fromARGB(255, 77, 82, 105),
//                           letterSpacing: 0.5,
//                         ),
//                       ),
//                       Icon(
//                         Icons.info_outline_rounded,
//                         size: 15,
//                         color: DARK_GREY_COLOR.withAlpha(100),
//                       ),
//                     ],
//                   ),
//                   Text(
//                     FORMAT_MONEY(price: 0),
//                     style: GoogleFonts.quicksand(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                       letterSpacing: 0.5,
//                       color: PRIMARY_COLOR,
//                     ),
//                   ),
//                 ],
//               ),
//               Container(
//                 margin: const EdgeInsets.symmetric(
//                   vertical: 5,
//                   horizontal: 15,
//                 ),
//                 height: 1,
//                 color: DARK_GREY_COLOR.withAlpha(50),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Paymented time',
//                     style: GoogleFonts.quicksand(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                       color: const Color.fromARGB(255, 77, 82, 105),
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                   Text(
//                     controller.saleTransactionModel.transactionTime != null
//                         ? FORMAT_DATE_TIME(
//                             dateTime: controller
//                                 .saleTransactionModel.transactionTime!,
//                             pattern: DATE_TIME_PATTERN)
//                         : 'N/A',
//                     style: GoogleFonts.quicksand(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                       color: const Color.fromARGB(255, 77, 82, 105),
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Payment method',
//                     style: GoogleFonts.quicksand(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                       color: const Color.fromARGB(255, 77, 82, 105),
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                   Text(
//                     controller.saleTransactionModel.paymentMethod ?? 'N/A',
//                     style: GoogleFonts.quicksand(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                       color: const Color.fromARGB(255, 77, 82, 105),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         Container(
//           height: 1,
//           color: LIGHT_GREY_COLOR.withOpacity(0.1),
//         ),
//         Container(
//           color: const Color.fromARGB(255, 245, 248, 253),
//           height: 16,
//         ),
//       ],
//     );
//   }

//   Widget petInfomationWidget() => Container(
//         color: WHITE_COLOR,
//         padding: const EdgeInsets.symmetric(
//           vertical: 15,
//           horizontal: 20,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(right: 20),
//               child: CircleAvatar(
//                 radius: 30,
//                 backgroundImage: NetworkImage(
//                   controller.saleTransactionModel.postModel.mediaModels![0].url,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Pet name',
//                         style: GoogleFonts.quicksand(
//                           fontSize: 17,
//                           color: const Color.fromARGB(255, 100, 107, 133),
//                           fontWeight: FontWeight.w500,
//                           letterSpacing: 1,
//                         ),
//                       ),
//                       Text(
//                         controller.saleTransactionModel.petModel.name,
//                         style: GoogleFonts.quicksand(
//                           fontSize: 17,
//                           color: const Color.fromARGB(255, 77, 82, 105),
//                           fontWeight: FontWeight.w500,
//                           letterSpacing: 1,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Breed',
//                         style: GoogleFonts.quicksand(
//                           fontSize: 15,
//                           color: const Color.fromARGB(255, 100, 107, 133),
//                           fontWeight: FontWeight.w500,
//                           letterSpacing: 1,
//                         ),
//                       ),
//                       Text(
//                         controller
//                                 .saleTransactionModel.petModel.breedModel.name +
//                             ' - ' +
//                             controller.saleTransactionModel.petModel.breedModel
//                                 .speciesModel!.name,
//                         style: GoogleFonts.quicksand(
//                           fontSize: 15,
//                           color: const Color.fromARGB(255, 77, 82, 105),
//                           fontWeight: FontWeight.w500,
//                           letterSpacing: 1,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Gender',
//                         style: GoogleFonts.quicksand(
//                           fontSize: 15,
//                           color: const Color.fromARGB(255, 100, 107, 133),
//                           fontWeight: FontWeight.w500,
//                           letterSpacing: 1,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           SvgPicture.asset(
//                             controller.saleTransactionModel.petModel.gender ==
//                                     'MALE'
//                                 ? ICON_PATH + MALE_SVG
//                                 : ICON_PATH + FEMALE_SVG,
//                             color: controller
//                                         .saleTransactionModel.petModel.gender ==
//                                     'MALE'
//                                 ? const Color.fromARGB(255, 39, 111, 245)
//                                 : const Color.fromARGB(255, 244, 55, 165),
//                             height: 10,
//                           ),
//                           const SizedBox(
//                             width: 2,
//                           ),
//                           Text(
//                             controller.saleTransactionModel.petModel.gender,
//                             style: GoogleFonts.quicksand(
//                               fontSize: 15,
//                               color: controller.saleTransactionModel.petModel
//                                           .gender ==
//                                       'MALE'
//                                   ? const Color.fromARGB(255, 39, 111, 245)
//                                   : const Color.fromARGB(255, 244, 55, 165),
//                               fontWeight: FontWeight.w500,
//                               letterSpacing: 1,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );

//   Widget rhombusItemListWidget({required double screenWidth}) {
//     List<Widget> listRhombus = [rhombusItemWidget()];
//     int numberOfRhombus = screenWidth ~/ 8;

//     do {
//       numberOfRhombus--;
//       listRhombus.add(rhombusItemWidget());
//     } while (numberOfRhombus > 0);

//     return Positioned(
//       bottom: 10,
//       child: Row(
//         children: listRhombus,
//       ),
//     );
//   }

//   Widget rhombusItemWidget() => Stack(
//         children: [
//           Container(
//             height: 8,
//             width: 9,
//             alignment: Alignment.topCenter,
//             child: RotationTransition(
//               turns: const AlwaysStoppedAnimation(45 / 360),
//               child: Container(
//                 height: 7,
//                 width: 7,
//                 color: DARK_GREY_COLOR.withAlpha(50),
//               ),
//             ),
//           ),
//           Container(
//             height: 8,
//             width: 9,
//             alignment: Alignment.bottomCenter,
//             child: RotationTransition(
//               turns: const AlwaysStoppedAnimation(45 / 360),
//               child: Container(
//                 height: 7,
//                 width: 7,
//                 color: const Color.fromARGB(255, 245, 248, 253),
//               ),
//             ),
//           ),
//         ],
//       );
// }