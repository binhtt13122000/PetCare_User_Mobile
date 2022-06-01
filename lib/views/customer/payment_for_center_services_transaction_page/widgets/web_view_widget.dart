import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/payment_for_center_services_transaction_page_controller.dart';

class PaymentForCenterServicesTransactionWebViewWidget
    extends GetView<PaymentForCenterServicesTransactionPageController> {
  const PaymentForCenterServicesTransactionWebViewWidget({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Visibility(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              decoration: const BoxDecoration(
                color: Color.fromARGB(106, 198, 188, 201),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: Uri.parse(controller.paymentUrl.value),
                  ),
                  onLoadStart: (InAppWebViewController controller, Uri? uri) {
                    // PaymentForCenterServicesTransactionPageController
                    //     paymentForCenterServicesTransactionPageController =
                    //     Get.find<
                    //         PaymentForCenterServicesTransactionPageController>();
                    // if (uri!.path ==
                    //     paymentForCenterServicesTransactionPageController) {
                    //   paymentForCenterServicesTransactionPageController
                    //       ..isShowPopup.value = true..paymentUrl.value = '';

                    // }
                  },
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 30,
              child: InkWell(
                onTap: () => controller.paymentUrl.value = '',
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: WHITE_COLOR,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: Colors.red,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: DARK_GREY_COLOR.withOpacity(0.15),
                        blurRadius: 5,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    ICON_PATH + CLOSE_SVG,
                    height: 15,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
