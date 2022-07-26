// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:petapp_mobile/controllers/other_controllers/scan_qr_page_controller.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

// class ScanQRPage extends GetView<ScanQRPageController> {
//   const ScanQRPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//     Barcode? result;
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             flex: 5,
//             child: QRView(
//               key: qrKey,
//               onQRViewCreated: (_) {
//                 print('abc');
//               },
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Center(
//               child: (result != null)
//                   ? const Text('Barcode Type')
//                   : const Text('Scan a code'),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
