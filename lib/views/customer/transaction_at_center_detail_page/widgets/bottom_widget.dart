// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:petapp_mobile/configs/route.dart';
// import 'package:petapp_mobile/configs/theme.dart';
// import 'package:petapp_mobile/controllers/transaction_at_center_detail_page_controller.dart';

// class TransactionAtCenterDetailBottomWidget
//     extends GetView<TransactionAtCenterDetailPageController> {
//   const TransactionAtCenterDetailBottomWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) => Container(
//         color: WHITE_COLOR,
//         child: Column(
//           children: [
//             Container(
//               height: 1,
//               color: DARK_GREY_COLOR.withAlpha(50),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//               child: InkWell(
//                 onTap: () {
//                   if (controller.normalTransactionModel.status == 'WAITING') {
//                     Get.toNamed(
//                         '$PAYMENT_FOR_TRANSACTION_AT_CENTER_PAGE_ROUTE/${controller.normalTransactionModel.id}');
//                   } else {
//                     controller.isShowReviewPopup.value = true;
//                   }
//                 },
//                 child: Container(
//                   height: 45,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     color: PRIMARY_COLOR,
//                   ),
//                   child: Text(
//                     controller.normalTransactionModel.status == 'WAITING'
//                         ? 'Go to the Payment page'
//                         : 'Rate Your Services Experience',
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.quicksand(
//                       textStyle: const TextStyle(color: WHITE_COLOR),
//                       fontWeight: FontWeight.w600,
//                       fontSize: 18,
//                       height: 1,
//                       letterSpacing: 1,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
// }
