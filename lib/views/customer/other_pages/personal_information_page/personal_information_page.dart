import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/other_controllers/personal_information_page_controller.dart';
import 'package:petapp_mobile/controllers/other_controllers/profile_page_controller.dart';
import 'package:petapp_mobile/services/other_services/customer_services.dart';
import 'package:petapp_mobile/views/customer/other_pages/personal_information_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/other_pages/personal_information_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/other_pages/personal_information_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/confirm_popup_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:petapp_mobile/views/widgets/notification_popup_widget.dart';

class PersonalInformationPage
    extends GetView<PersonalInformationPageController> {
  const PersonalInformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: [
          GetBuilder<PersonalInformationPageController>(
            builder: (_) => Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Column(
                children: [
                  const PersonalInformationTopWidget(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: const [
                          PersonalInformationBodyWidget(),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    color: LIGHT_GREY_COLOR.withAlpha(30),
                  ),
                  const PersonalInformationBottomWidget(),
                ],
              ),
            ),
          ),
          Obx(
            () => controller.isShowConfirmPopup.value
                ? ConfirmPopupWidget(
                    onTapBackground: () {
                      controller.isShowConfirmPopup.value = false;
                    },
                    title: 'Update profile',
                    content: 'Are you sure to update your profile?',
                    onTapSubmit: () async {
                      controller
                        ..isShowConfirmPopup.value = false
                        ..isLoadingUpdateProfile.value = true;

                      controller.customerModel =
                          await CustomerService.updateProfile(
                        jwt: controller.accountModel.jwtToken,
                        id: controller.accountModel.customerModel.id,
                        email: controller.email.value,
                        firstName: controller.firstName.value,
                        lastName: controller.lastName.value,
                        address: controller.address.value,
                        gender: controller.selectedGender.value,
                        avatarFilePath: controller.avatarFilePath.value,
                        bankBranch: controller.bankBranch.value,
                        bankCode: controller.bankCode.value,
                        bankName: controller.bankName.value,
                      );

                      // if (customerModel != null) {
                      //   Get.find<AuthController>().accountModel.customerModel =
                      //       customerModel;
                      //   controller
                      //     ..accountModel.customerModel = customerModel
                      //     ..update();
                      // }

                      controller
                        ..isLoadingUpdateProfile.value = false
                        ..isShowNotificationPopup.value = true;
                    })
                : const SizedBox.shrink(),
          ),
          Obx(
            () => controller.isShowNotificationPopup.value
                ? NotificationPopupWidget(
                    onTapBackground: () {},
                    onTapOk: () {
                      if (controller.customerModel != null) {
                        Get
                          ..back()
                          ..find<ProfilePageController>().update();
                      } else {
                        controller.isShowNotificationPopup.value = false;
                      }
                    },
                    content: controller.customerModel != null
                        ? 'Update your profile successfully.'
                        : 'Update your profile failed.',
                    isSuccessNotification: controller.customerModel != null,
                  )
                : const SizedBox.shrink(),
          ),
          Obx(
            () => controller.isLoadingUpdateProfile.value
                ? Container(
                    color: DARK_GREY_TRANSPARENT, child: LOADING_WIDGET())
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
