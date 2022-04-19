// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:petapp_mobile/configs/path.dart';
// import 'package:petapp_mobile/configs/theme.dart';
// import 'package:petapp_mobile/utilities/utilities.dart';

// class TicketDetail extends StatelessWidget {
//   const TicketDetail({Key? key}) : super(key: key);
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
//                     (ticketModel.type == 'PURCHASE' ? 'Puchase' : 'Breedinf') +
//                         ' Ticket',
//                     style: GoogleFonts.satisfy(
//                       textStyle: const TextStyle(color: PRIMARY_COLOR),
//                       fontWeight: FontWeight.w700,
//                       fontSize: 25,
//                       height: 1,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 color: DARK_GREY_COLOR.withAlpha(20),
//                 child: SingleChildScrollView(
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
//                               'Ticket ID',
//                               style: GoogleFonts.quicksand(
//                                 fontSize: 13,
//                                 color: DARK_GREY_COLOR.withAlpha(130),
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             Text(
//                               '#0' + ticketModel.id.toString(),
//                               style: GoogleFonts.quicksand(
//                                 fontSize: 13,
//                                 color: DARK_GREY_COLOR.withAlpha(130),
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         color: WHITE_COLOR,
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 8,
//                           horizontal: 20,
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Text(
//                                   'Title:  ',
//                                   style: GoogleFonts.quicksand(
//                                     fontSize: 17,
//                                     color: DARK_GREY_COLOR.withAlpha(180),
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 ),
//                                 Text(
//                                   ticketModel.title,
//                                   style: GoogleFonts.quicksand(
//                                     fontSize: 17,
//                                     color: DARK_GREY_COLOR.withAlpha(180),
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             RichText(
//                               text: TextSpan(
//                                 text: 'Description:  ',
//                                 style: GoogleFonts.quicksand(
//                                   fontSize: 17,
//                                   color: DARK_GREY_COLOR.withAlpha(180),
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                                 children: [
//                                   TextSpan(
//                                     text: ticketModel.description,
//                                     style: GoogleFonts.quicksand(
//                                       fontSize: 17,
//                                       color: DARK_GREY_COLOR.withAlpha(180),
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Container(
//                         color: WHITE_COLOR,
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 8,
//                           horizontal: 20,
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Status',
//                                   style: GoogleFonts.quicksand(
//                                     fontSize: 17,
//                                     color: DARK_GREY_COLOR.withAlpha(180),
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 ),
//                                 Text(
//                                   ticketModel.status,
//                                   style: GoogleFonts.quicksand(
//                                     fontSize: 17,
//                                     color: DARK_GREY_COLOR.withAlpha(180),
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 5,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Create time',
//                                   style: GoogleFonts.quicksand(
//                                     fontSize: 17,
//                                     color: DARK_GREY_COLOR.withAlpha(180),
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 ),
//                                 Text(
//                                   FORMAT_DATE_TIME(
//                                       dateTime: ticketModel.date,
//                                       pattern: DATE_TIME_PATTERN),
//                                   style: GoogleFonts.quicksand(
//                                     fontSize: 17,
//                                     color: DARK_GREY_COLOR.withAlpha(180),
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 5,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Meeting time',
//                                   style: GoogleFonts.quicksand(
//                                     fontSize: 17,
//                                     color: DARK_GREY_COLOR.withAlpha(180),
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 ),
//                                 Text(
//                                   false
//                                       ? FORMAT_DATE_TIME(
//                                           dateTime: ticketModel.date,
//                                           pattern: DATE_TIME_PATTERN)
//                                       : 'N/A',
//                                   style: GoogleFonts.quicksand(
//                                     fontSize: 17,
//                                     color: DARK_GREY_COLOR.withAlpha(180),
//                                     fontWeight: FontWeight.w500,
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
//                       Container(
//                         color: WHITE_COLOR,
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 8,
//                           horizontal: 20,
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Image evidence',
//                               style: GoogleFonts.quicksand(
//                                 fontSize: 17,
//                                 color: DARK_GREY_COLOR.withAlpha(180),
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 5,
//                             ),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: SingleChildScrollView(
//                                     scrollDirection: Axis.horizontal,
//                                     child: Row(
//                                       children: ticketModel.evidence
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
//                                                         height: 130,
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
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Container(
//                         color: WHITE_COLOR,
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 8,
//                           horizontal: 20,
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Video evidence',
//                               style: GoogleFonts.quicksand(
//                                 fontSize: 17,
//                                 color: DARK_GREY_COLOR.withAlpha(180),
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 5,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   height: 130,
//                                   width: 230,
//                                   alignment: Alignment.center,
//                                   decoration: BoxDecoration(
//                                     color: DARK_GREY_COLOR.withAlpha(80),
//                                     borderRadius: const BorderRadius.all(
//                                       Radius.circular(7),
//                                     ),
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         'No videos',
//                                         style: GoogleFonts.quicksand(
//                                           fontSize: 17,
//                                           color: DARK_GREY_COLOR.withAlpha(150),
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         width: 10,
//                                       ),
//                                       SvgPicture.asset(
//                                         ICON_PATH + NO_VIDEO_SVG,
//                                         height: 20,
//                                         color: DARK_GREY_COLOR.withAlpha(150),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
