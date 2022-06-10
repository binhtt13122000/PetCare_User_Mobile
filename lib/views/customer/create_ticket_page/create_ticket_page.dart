import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/ticket_page_controller.dart';
import 'package:petapp_mobile/services/branch_services.dart';
import 'package:petapp_mobile/services/center_services_services.dart';
import 'package:petapp_mobile/views/customer/create_ticket_page/widgets/add_services_widget.dart';
import 'package:petapp_mobile/views/customer/create_ticket_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/create_ticket_page/widgets/calendar_widget.dart';
import 'package:petapp_mobile/views/customer/create_ticket_page/widgets/pick_time_widget.dart';
import 'package:petapp_mobile/views/customer/create_ticket_page/widgets/popup_widget.dart';
import 'package:petapp_mobile/views/customer/create_ticket_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class CreateTicketPage extends GetView<CreateTicketPageController> {
  const CreateTicketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.isLoadingData.value = true;

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      controller
        ..centerServicesModelList =
            await CenterServicesServices.fetchCenterServicesList()
        ..branchModelList = await BranchServices.fetchBranchList()
        ..selectBranchId.value = controller.branchModelList[0].id
        ..isLoadingData.value = false;
    });

    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: [
          Column(
            children: [
              const CreateTicketTopWidget(),
              Obx(
                () => controller.isLoadingData.value
                    ? Expanded(child: LOADING_WIDGET())
                    : const CreateTicketBodyWidget(),
              ),
            ],
          ),
          const PickTimeWidget(),
          const AddServicesWidget(),
          Obx(
            () => Visibility(
              visible: controller.isWaitingSendTicket.value,
              child: Container(
                color: DARK_GREY_TRANSPARENT,
                child: LOADING_WIDGET(),
              ),
            ),
          ),
          const CreateTicketPopupWidget(),
          const CreateTicketCalendarWidget(),
        ],
      ),
    );
  }
}
