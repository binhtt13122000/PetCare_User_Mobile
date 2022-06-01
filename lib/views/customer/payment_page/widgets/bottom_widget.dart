// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:petapp_mobile/configs/path.dart';
// import 'package:petapp_mobile/configs/route.dart';
// import 'package:petapp_mobile/configs/theme.dart';
// import 'package:petapp_mobile/controllers/payment_pay_controller.dart';

// class PaymentBottomWidget extends GetView<PaymentPageController> {
//   const PaymentBottomWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) => Column(
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
//                   onTap: () => Get.toNamed(PAYMENT_METHOD_PAGE_ROUTE),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 20,
//                     ),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Image.asset(
//                           IMAGE_PATH + VISA_PNG,
//                           height: 28,
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           '6789',
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
//                           width: 40,
//                         ),
//                         SvgPicture.asset(
//                           ICON_PATH + UP_ARROW_SVG,
//                           height: 14,
//                         ),
//                         const SizedBox(
//                           width: 20,
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
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Obx(
//                         () => Text(
//                           controller.selectedPromotionName.value,
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.quicksand(
//                             textStyle: const TextStyle(color: PRIMARY_COLOR),
//                             fontWeight: FontWeight.w800,
//                             fontSize: 15,
//                             height: 1,
//                             letterSpacing: 1,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             height: 45,
//             margin: const EdgeInsets.symmetric(
//               horizontal: 20,
//               vertical: 10,
//             ),
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(5),
//               color: PRIMARY_COLOR,
//             ),
//             child: Text(
//               'Payment',
//               textAlign: TextAlign.center,
//               style: GoogleFonts.quicksand(
//                 textStyle: const TextStyle(color: WHITE_COLOR),
//                 fontWeight: FontWeight.w600,
//                 fontSize: 20,
//                 height: 1,
//                 letterSpacing: 2,
//               ),
//             ),
//           ),
//         ],
//       );
// }
