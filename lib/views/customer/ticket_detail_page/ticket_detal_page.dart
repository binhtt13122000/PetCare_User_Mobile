import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/ticket_detail_page_controller.dart';
import 'package:petapp_mobile/services/ticket_services.dart';
import 'package:petapp_mobile/views/customer/ticket_detail_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/ticket_detail_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class TicketDetailPage extends GetView<TicketDetailPageController> {
  const TicketDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Column(
        children: [
          const TicketDetailTopWidget(),
          GetBuilder<TicketDetailPageController>(builder: (_) {
            controller.isLoadingData.value = true;
            WidgetsBinding.instance!.addPostFrameCallback((_) async {
              controller.ticketModel = await TicketServices.fetchTicketById(
                  ticketId: int.parse(Get.parameters['ticketId']!));
              controller.isLoadingData.value = false;
            });
            return Obx(() => controller.isLoadingData.value
                ? LOADING_WIDGET()
                : const TicketDetailBodyWidget());
          })
        ],
      ),
    );
  }
}
