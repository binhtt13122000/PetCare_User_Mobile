// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:petapp_mobile/configs/path.dart';
// import 'package:petapp_mobile/configs/theme.dart';
// import 'package:petapp_mobile/controllers/transaction_page_controller.dart';
// import 'package:petapp_mobile/utilities/utilities.dart';

// class SaleTransactionForSellerDetailPage
//     extends GetView<TransactionPageController> {
//   const SaleTransactionForSellerDetailPage({Key? key, required this.index})
//       : super(key: key);
//   final int index;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.only(
//                 left: 20,
//                 right: 20,
//                 top: 10,
//                 bottom: 10,
//               ),
//               decoration: BoxDecoration(
//                 color: WHITE_COLOR,
//                 boxShadow: [
//                   BoxShadow(
//                     color: DARK_GREY_COLOR.withOpacity(0.35),
//                     offset: const Offset(1, 1),
//                     blurRadius: 5,
//                   ),
//                 ],
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   //!back button
//                   InkWell(
//                     onTap: () => Get.back(),
//                     child: Container(
//                       width: 40,
//                       height: 40,
//                       alignment: Alignment.center,
//                       decoration: const BoxDecoration(
//                         color: PRIMARY_LIGHT_COLOR,
//                         shape: BoxShape.circle,
//                       ),
//                       child: SvgPicture.asset(
//                         ICON_PATH + BACK_SVG,
//                         color: PRIMARY_COLOR,
//                         height: 15,
//                       ),
//                     ),
//                   ),
//                   //!app logo
//                   Text(
//                     'Transaction detail',
//                     style: GoogleFonts.satisfy(
//                       textStyle: const TextStyle(color: PRIMARY_COLOR),
//                       fontWeight: FontWeight.w700,
//                       fontSize: 20,
//                       height: 1,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Container(
//                   color: DARK_GREY_COLOR.withAlpha(20),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 8,
//                           horizontal: 20,
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'Transaction ID',
//                               style: GoogleFonts.quicksand(
//                                 fontSize: 13,
//                                 color: DARK_GREY_COLOR.withAlpha(130),
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             Text(
//                               '#0' +
//                                   controller.saleTransactions[index].id
//                                       .toString(),
//                               style: GoogleFonts.quicksand(
//                                 fontSize: 13,
//                                 color: DARK_GREY_COLOR.withAlpha(130),
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       //!Pet information
//                       Container(
//                         color: WHITE_COLOR,
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 15,
//                           horizontal: 20,
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 CircleAvatar(
//                                   radius: 30,
//                                   backgroundImage: NetworkImage(
//                                     controller.saleTransactions[index].postModel
//                                         .mediaModels![0].url,
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 20,
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Text(
//                                           controller
//                                               .saleTransactions[index]
//                                               .postModel
//                                               .petModel!
//                                               .breedModel
//                                               .name,
//                                           style: GoogleFonts.quicksand(
//                                             fontSize: 17,
//                                             color:
//                                                 DARK_GREY_COLOR.withAlpha(200),
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           'Species: ',
//                                           style: GoogleFonts.quicksand(
//                                             fontSize: 14,
//                                             color:
//                                                 DARK_GREY_COLOR.withAlpha(150),
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                         Text(
//                                           controller
//                                               .saleTransactions[index]
//                                               .postModel
//                                               .petModel!
//                                               .breedModel
//                                               .speciesModel!
//                                               .name,
//                                           style: GoogleFonts.quicksand(
//                                             fontSize: 14,
//                                             color:
//                                                 DARK_GREY_COLOR.withAlpha(180),
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           'Gender: ',
//                                           style: GoogleFonts.quicksand(
//                                             fontSize: 13,
//                                             color:
//                                                 DARK_GREY_COLOR.withAlpha(150),
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                         SvgPicture.asset(
//                                           controller
//                                                       .saleTransactions[index]
//                                                       .postModel
//                                                       .petModel!
//                                                       .gender ==
//                                                   'MALE'
//                                               ? ICON_PATH + MALE_SVG
//                                               : ICON_PATH + FEMALE_SVG,
//                                           color: controller
//                                                       .saleTransactions[index]
//                                                       .postModel
//                                                       .petModel!
//                                                       .gender ==
//                                                   'MALE'
//                                               ? const Color.fromARGB(
//                                                   255, 39, 111, 245)
//                                               : const Color.fromARGB(
//                                                   255, 244, 55, 165),
//                                           height: 10,
//                                         ),
//                                         const SizedBox(
//                                           width: 2,
//                                         ),
//                                         Text(
//                                           controller.saleTransactions[index]
//                                               .postModel.petModel!.gender,
//                                           style: GoogleFonts.quicksand(
//                                             fontSize: 13,
//                                             color: controller
//                                                         .saleTransactions[index]
//                                                         .postModel
//                                                         .petModel!
//                                                         .gender ==
//                                                     'MALE'
//                                                 ? const Color.fromARGB(
//                                                     255, 39, 111, 245)
//                                                 : const Color.fromARGB(
//                                                     255, 244, 55, 165),
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             Text(
//                               'View Detail',
//                               style: GoogleFonts.quicksand(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                                 color: PRIMARY_COLOR,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         color: WHITE_COLOR,
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 15,
//                           horizontal: 40,
//                         ),
//                         margin: const EdgeInsets.symmetric(vertical: 10),
//                         child: Row(
//                           children: [
//                             Column(
//                               children: [
//                                 //!Deposited
//                                 const CircleAvatar(
//                                   radius: 8,
//                                   backgroundColor: PRIMARY_COLOR,
//                                   child: Icon(
//                                     Icons.check_circle_outline_rounded,
//                                     color: WHITE_COLOR,
//                                     size: 15,
//                                   ),
//                                 ),
//                                 controller.saleTransactions[index].status ==
//                                         'NOT_PET_AVAILABLE'
//                                     ? const SizedBox(
//                                         height: 15,
//                                         child: RotatedBox(
//                                           quarterTurns: 1,
//                                           child: SizedBox(
//                                             height: 2,
//                                             child: LinearProgressIndicator(
//                                               valueColor:
//                                                   AlwaysStoppedAnimation<Color>(
//                                                 PRIMARY_COLOR,
//                                               ),
//                                               backgroundColor:
//                                                   Color(0xFFD1C1E0),
//                                             ),
//                                           ),
//                                         ),
//                                       )
//                                     : Container(
//                                         height: 15,
//                                         width: 2,
//                                         color: PRIMARY_COLOR,
//                                       ),
//                                 //!Pet recieved
//                                 CircleAvatar(
//                                   radius: 8,
//                                   backgroundColor: controller
//                                               .saleTransactions[index].status ==
//                                           'NOT_PET_AVAILABLE'
//                                       ? PRIMARY_COLOR.withAlpha(160)
//                                       : PRIMARY_COLOR,
//                                   child: Icon(
//                                     controller.saleTransactions[index].status ==
//                                             'NOT_PET_AVAILABLE'
//                                         ? Icons.remove_circle_outline
//                                         : Icons.check_circle_outline_rounded,
//                                     color: WHITE_COLOR,
//                                     size: 15,
//                                   ),
//                                 ),
//                                 controller.saleTransactions[index].status ==
//                                         'PET_AVAILABLE'
//                                     ? const SizedBox(
//                                         height: 15,
//                                         child: RotatedBox(
//                                           quarterTurns: 1,
//                                           child: SizedBox(
//                                             height: 2,
//                                             child: LinearProgressIndicator(
//                                               valueColor:
//                                                   AlwaysStoppedAnimation<Color>(
//                                                 PRIMARY_COLOR,
//                                               ),
//                                               backgroundColor:
//                                                   Color(0xFFD1C1E0),
//                                             ),
//                                           ),
//                                         ),
//                                       )
//                                     : Container(
//                                         height: 15,
//                                         width: 2,
//                                         color: controller
//                                                         .saleTransactions[index]
//                                                         .status ==
//                                                     'RECEIVED' ||
//                                                 controller
//                                                         .saleTransactions[index]
//                                                         .status ==
//                                                     'PAYMENTED'
//                                             ? PRIMARY_COLOR
//                                             : PRIMARY_COLOR.withAlpha(100),
//                                       ),
//                                 CircleAvatar(
//                                   radius: 8,
//                                   backgroundColor: controller
//                                                   .saleTransactions[index]
//                                                   .status ==
//                                               'RECEIVED' ||
//                                           controller.saleTransactions[index]
//                                                   .status ==
//                                               'PAYMENTED'
//                                       ? PRIMARY_COLOR
//                                       : PRIMARY_COLOR.withAlpha(100),
//                                   child: Icon(
//                                     controller.saleTransactions[index].status ==
//                                                 'RECEIVED' ||
//                                             controller.saleTransactions[index]
//                                                     .status ==
//                                                 'PAYMENTED'
//                                         ? Icons.check_circle_outline_rounded
//                                         : Icons.remove_circle_outline,
//                                     color: WHITE_COLOR,
//                                     size: 15,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             //!Status text
//                             const SizedBox(
//                               width: 40,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(
//                                   child: Text(
//                                     'Buyer deposited',
//                                     style: GoogleFonts.quicksand(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w500,
//                                       color: PRIMARY_COLOR,
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 SizedBox(
//                                   child: Text(
//                                     'Bring pet to the center',
//                                     style: GoogleFonts.quicksand(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w500,
//                                       color: controller.saleTransactions[index]
//                                                   .status ==
//                                               'NOT_PET_AVAILABLE'
//                                           ? PRIMARY_COLOR.withAlpha(160)
//                                           : PRIMARY_COLOR,
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 SizedBox(
//                                   child: Text(
//                                     'Received money',
//                                     style: GoogleFonts.quicksand(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w500,
//                                       color: controller.saleTransactions[index]
//                                                       .status ==
//                                                   'RECEIVED' ||
//                                               controller.saleTransactions[index]
//                                                       .status ==
//                                                   'PAYMENTED'
//                                           ? PRIMARY_COLOR
//                                           : PRIMARY_COLOR.withAlpha(160),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         color: WHITE_COLOR,
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 15,
//                           horizontal: 20,
//                         ),
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Transaction type',
//                                   style: GoogleFonts.quicksand(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w500,
//                                     color: DARK_GREY_COLOR.withAlpha(200),
//                                   ),
//                                 ),
//                                 Text(
//                                   'Purchase',
//                                   style: GoogleFonts.quicksand(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w500,
//                                     color: DARK_GREY_COLOR.withAlpha(200),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Customer role',
//                                   style: GoogleFonts.quicksand(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w500,
//                                     color: DARK_GREY_COLOR.withAlpha(200),
//                                   ),
//                                 ),
//                                 Text(
//                                   controller.saleTransactions[index].buyerId ==
//                                           1
//                                       ? 'Buyer'
//                                       : 'Seller',
//                                   style: GoogleFonts.quicksand(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w500,
//                                     color: DARK_GREY_COLOR.withAlpha(200),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       //*Contract evidence
//                       Container(
//                         color: WHITE_COLOR,
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 15,
//                           horizontal: 20,
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Text(
//                                   'Contract evidences',
//                                   style: GoogleFonts.quicksand(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w500,
//                                     color: DARK_GREY_COLOR.withAlpha(200),
//                                   ),
//                                 ),
//                                 Text(
//                                   '(' +
//                                       controller.saleTransactions[index]
//                                           .mediaModelsForSeller.length
//                                           .toString() +
//                                       ' images)',
//                                   style: GoogleFonts.quicksand(
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.w500,
//                                     fontStyle: FontStyle.italic,
//                                     color: DARK_GREY_COLOR.withAlpha(150),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: SingleChildScrollView(
//                                     scrollDirection: Axis.horizontal,
//                                     child: Row(
//                                       children: controller
//                                           .saleTransactions[index]
//                                           .mediaModelsForSeller
//                                           .asMap()
//                                           .entries
//                                           .map(
//                                             (e) => Row(
//                                               children: [
//                                                 Stack(
//                                                   children: [
//                                                     ClipRRect(
//                                                       borderRadius:
//                                                           const BorderRadius
//                                                               .all(
//                                                         Radius.circular(7),
//                                                       ),
//                                                       child: Image.network(
//                                                         e.value.url,
//                                                         height: 100,
//                                                         fit: BoxFit.cover,
//                                                       ),
//                                                     ),
//                                                     const Positioned(
//                                                       child: Icon(
//                                                         Icons.zoom_out_map,
//                                                         size: 20,
//                                                         color: PRIMARY_COLOR,
//                                                       ),
//                                                       bottom: 5,
//                                                       right: 5,
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 const SizedBox(
//                                                   width: 10,
//                                                 ),
//                                               ],
//                                             ),
//                                           )
//                                           .toList(),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             //*price
//             Container(
//               color: WHITE_COLOR,
//               padding: const EdgeInsets.symmetric(
//                 vertical: 15,
//                 horizontal: 20,
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Pet price',
//                         style: GoogleFonts.quicksand(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                           color: DARK_GREY_COLOR.withAlpha(200),
//                         ),
//                       ),
//                       Text(
//                         FORMAT_MONEY(
//                             price: controller
//                                 .saleTransactions[index].payForSeller),
//                         style: GoogleFonts.quicksand(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                           color: PRIMARY_COLOR.withAlpha(200),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Buyer deposited time',
//                         style: GoogleFonts.quicksand(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                           color: DARK_GREY_COLOR.withAlpha(200),
//                         ),
//                       ),
//                       Text(
//                         FORMAT_DATE_TIME(
//                             dateTime: controller
//                                 .saleTransactions[index].createTime
//                                 .add(const Duration(hours: 7)),
//                             pattern: DATE_TIME_PATTERN),
//                         style: GoogleFonts.quicksand(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                           color: DARK_GREY_COLOR.withAlpha(200),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           Text(
//                             'Buyer deposits',
//                             style: GoogleFonts.quicksand(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w500,
//                               color: DARK_GREY_COLOR.withAlpha(200),
//                             ),
//                           ),
//                           Icon(
//                             Icons.info_outline_rounded,
//                             size: 15,
//                             color: DARK_GREY_COLOR.withAlpha(100),
//                           ),
//                         ],
//                       ),
//                       Text(
//                         FORMAT_MONEY(
//                             price: controller.saleTransactions[index].deposit),
//                         style: GoogleFonts.quicksand(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                           color: PRIMARY_COLOR.withAlpha(200),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Received method',
//                         style: GoogleFonts.quicksand(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                           color: DARK_GREY_COLOR.withAlpha(200),
//                         ),
//                       ),
//                       Text(
//                         'N/A',
//                         style: GoogleFonts.quicksand(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                           color: DARK_GREY_COLOR.withAlpha(150),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Received time',
//                         style: GoogleFonts.quicksand(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                           color: DARK_GREY_COLOR.withAlpha(200),
//                         ),
//                       ),
//                       Text(
//                         controller.saleTransactions[index].payForSellerTime !=
//                                 null
//                             ? FORMAT_DATE_TIME(
//                                 dateTime: controller
//                                     .saleTransactions[index].payForSellerTime!,
//                                 pattern: DATE_TIME_PATTERN)
//                             : 'N/A',
//                         style: GoogleFonts.quicksand(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                           color: controller.saleTransactions[index]
//                                       .payForSellerTime !=
//                                   null
//                               ? DARK_GREY_COLOR.withAlpha(200)
//                               : DARK_GREY_COLOR.withAlpha(150),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Container(
//                     margin: const EdgeInsets.symmetric(
//                       vertical: 5,
//                     ),
//                     height: 1,
//                     color: DARK_GREY_COLOR.withAlpha(150),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Received money',
//                         style: GoogleFonts.quicksand(
//                           fontSize: 17,
//                           fontWeight: FontWeight.w700,
//                           color: DARK_GREY_COLOR.withAlpha(200),
//                         ),
//                       ),
//                       Text(
//                         FORMAT_MONEY(
//                             price: controller.saleTransactions[index].status ==
//                                     'PAYMENTED'
//                                 ? controller
//                                     .saleTransactions[index].payForSeller
//                                 : 0),
//                         style: GoogleFonts.quicksand(
//                           fontSize: 17,
//                           fontWeight: FontWeight.w700,
//                           color: PRIMARY_COLOR,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
