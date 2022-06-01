// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:petapp_mobile/configs/path.dart';
// import 'package:petapp_mobile/configs/theme.dart';
// import 'package:petapp_mobile/controllers/payment_pay_controller.dart';

// class PaymentMethodTopWidget extends GetView<PaymentPageController> {
//   const PaymentMethodTopWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) => Column(
//         children: [
//           Padding(
//             padding:
//                 const EdgeInsets.only(left: 12, right: 12, bottom: 10, top: 30),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 //*back button
//                 InkWell(
//                   onTap: () => Get.back(),
//                   child: Container(
//                     height: 35,
//                     width: 35,
//                     decoration: BoxDecoration(
//                       color: WHITE_COLOR,
//                       borderRadius: BorderRadius.circular(100),
//                       boxShadow: [
//                         BoxShadow(
//                           color: DARK_GREY_COLOR.withOpacity(0.1),
//                           blurRadius: 5,
//                           offset: const Offset(2, 2),
//                         ),
//                       ],
//                     ),
//                     alignment: Alignment.center,
//                     child: SvgPicture.asset(
//                       ICON_PATH + CLOSE_SVG,
//                       height: 15,
//                       color: const Color.fromARGB(255, 61, 78, 100),
//                     ),
//                   ),
//                 ),
//                 //*app logo
//                 Expanded(
//                   child: Text(
//                     'Payment Method',
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.quicksand(
//                       color: const Color.fromARGB(255, 62, 68, 87),
//                       fontSize: 18,
//                       fontWeight: FontWeight.w700,
//                       letterSpacing: 1,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             height: 1,
//             margin: const EdgeInsets.only(top: 10),
//             color: DARK_GREY_COLOR.withAlpha(30),
//           ),
//           Container(
//             height: 15,
//             color: const Color.fromARGB(255, 242, 244, 247),
//           ),
//         ],
//       );
// }
