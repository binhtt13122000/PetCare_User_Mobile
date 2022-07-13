import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/controllers/other_controllers/profile_page_controller.dart';
import 'package:petapp_mobile/services/other_services/customer_services.dart';
import 'package:petapp_mobile/views/customer/main_pages/profile_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/main_pages/profile_page/widgets/tab_widget.dart';
import 'package:petapp_mobile/views/customer/main_pages/profile_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/customer/other_pages/custom_bottom_navigation_bar/custom_bottom_navigator_bar.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProfilePage extends GetView<ProfilePageController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 251, 255),
      extendBody: true,
      body: Stack(
        children: [
          GetBuilder<ProfilePageController>(builder: (_) {
            controller.isLoadingData.value = true;
            WidgetsBinding.instance!.addPostFrameCallback((_) async {
              controller.accountModel.customerModel =
                  await CustomerService.fetchCustomerById(
                      controller.accountModel.customerModel.id);
              Get.find<AuthController>().accountModel.customerModel =
                  controller.accountModel.customerModel;
              controller.isLoadingData.value = false;
            });
            return Obx(
              () => controller.isLoadingData.value
                  ? LOADING_WIDGET()
                  : Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Column(
                        children: [
                          const ProfilePageTopWidget(),
                          Expanded(
                            child: SmartRefresher(
                              controller: RefreshController(),
                              onRefresh: () => controller.update(),
                              child: const SingleChildScrollView(
                                child: ProfilePageBodyWidget(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            );
          }),
          const Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavigatorBarWidget(route: PROFILE_PAGE_ROUTE),
          ),
          const ProfileTabWidget(),
          Obx(
            () => Visibility(
              visible: controller.isWaitingSignOut.value,
              child: Container(
                color: DARK_GREY_TRANSPARENT,
                child: LOADING_WIDGET(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
