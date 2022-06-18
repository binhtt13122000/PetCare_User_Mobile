import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/main_page_controllers/action_page_controller.dart';
import 'package:petapp_mobile/services/transaction_services/ticket_services.dart';
import 'package:petapp_mobile/views/customer/main_pages/action_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/main_pages/action_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/customer/other_pages/custom_bottom_navigation_bar/custom_bottom_navigator_bar.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class ActionPage extends GetView<ActionPageController> {
  const ActionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    const ActionTopWidget(),
                    GetBuilder<ActionPageController>(builder: (_) {
                      controller.isLoadingData.value = true;
                      WidgetsBinding.instance!.addPostFrameCallback((_) async {
                        controller
                          ..ticketModel =
                              await TicketServices.fetchTicketByCustomerId(
                                  customerId:
                                      controller.accountModel.customerModel.id)
                          ..ticketId.value = controller.ticketModel != null
                              ? controller.ticketModel!.id
                              : -1
                          ..isLoadingData.value = false;
                      });
                      return Obx(() => controller.isLoadingData.value
                          ? Expanded(child: LOADING_WIDGET())
                          : const ActionPageBodyWidget());
                    }),
                  ],
                ),
              ),
            ],
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavigatorBarWidget(route: ACTION_PAGE_ROUTE),
          )
        ],
      ),
    );
  }
}
