import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/center_services_transaction_detail_page_controller.dart';
import 'package:petapp_mobile/views/customer/center_services_transaction_detail_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/center_services_transaction_detail_page/widgets/popup_widget.dart';
import 'package:petapp_mobile/views/customer/center_services_transaction_detail_page/widgets/review_popup_widget.dart';
import 'package:petapp_mobile/views/customer/center_services_transaction_detail_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class CenterServicesTransactionDetailPage
    extends GetView<CenterServicesTransactionDetailPageController> {
  const CenterServicesTransactionDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: const [
                CenterServicesTransactionDetailTopWidget(),
                CenterServicesTransactionDetailBodyWidget(),
              ],
            ),
          ),
          const CenterSerVicesTransactionDetailReviewPopupWidget(),
          const CenterServicesTransactionDetailPopupWidget(),
          Obx(() => Visibility(
              visible: controller.isWaitingUpdate.value,
              child: Container(
                  color: DARK_GREY_TRANSPARENT, child: LOADING_WIDGET()))),
        ],
      ),
    );
  }
}
