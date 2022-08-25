import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/controllers/other_controllers/profile_page_controller.dart';
import 'package:petapp_mobile/models/order_model/order_model.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';
import 'package:petapp_mobile/services/other_services/customer_services.dart';
import 'package:petapp_mobile/services/other_services/policy_services.dart';
import 'package:petapp_mobile/services/pet_services/pet_services.dart';
import 'package:petapp_mobile/services/post_services/post_services.dart';
import 'package:petapp_mobile/services/transaction_services/order_services.dart';
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
                controller.accountModel.customerModel.id,
                jwt: controller.accountModel.jwtToken,
              );

              Get.find<AuthController>().accountModel.customerModel =
                  controller.accountModel.customerModel;
              List<PostModel> postModelList =
                  await PostService.fetchPostListByCustomerId(
                title: '',
                customerId: controller.accountModel.customerModel.id,
                limit: 99,
                jwt: controller.accountModel.jwtToken,
                page: 1,
              );
              List<PetModel> petModelList =
                  await PetService.fetchPetListByCustomerId(
                controller.accountModel.customerModel.id,
                jwt: controller.accountModel.jwtToken,
              );
              List<OrderModel> orderModelList = await OrderServices
                  .fetchListCenterServicesTransactionByCustomerId(
                jwt: controller.accountModel.jwtToken,
                page: 1,
                limit: 99,
                customerId: controller.accountModel.customerModel.id,
              );
              controller
                ..postQuantity = postModelList.length
                ..petQuantity = petModelList.length
                ..orderQuantity = orderModelList.length
                ..isLoadingData.value = false;
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
          Obx(
            () => Visibility(
              visible: controller.isShowPolicy.value,
              child: InkWell(
                onTap: () => controller.isShowPolicy.value = false,
                child: Container(
                  alignment: Alignment.center,
                  color: DARK_GREY_TRANSPARENT,
                  child: GetBuilder<ProfilePageController>(builder: (_) {
                    WidgetsBinding.instance!.addPostFrameCallback((_) async {
                      controller
                        ..policy = await PolicyServices.fetchPolicy()
                        ..isLoadingPolicy.value = false;
                    });
                    return Obx(
                      () => Container(
                        height: 500,
                        width: 300,
                        decoration: BoxDecoration(
                          color: WHITE_COLOR,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: controller.isLoadingPolicy.value
                            ? LOADING_WIDGET()
                            : SingleChildScrollView(
                                child: Column(
                                  children: [
                                    CUSTOM_TEXT('PRIVACY POLICY',
                                        fontWeight: FontWeight.w700,
                                        padding: const EdgeInsets.only(top: 20),
                                        color: PRIMARY_COLOR),
                                    Html(data: controller.policy),
                                  ],
                                ),
                              ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
