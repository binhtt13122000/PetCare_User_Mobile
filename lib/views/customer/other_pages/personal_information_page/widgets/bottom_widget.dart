import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/controllers/other_controllers/personal_information_page_controller.dart';
import 'package:petapp_mobile/models/customer_model/customer_model.dart';
import 'package:petapp_mobile/services/other_services/customer_services.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PersonalInformationBottomWidget
    extends GetView<PersonalInformationPageController> {
  const PersonalInformationBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return saveWidget();
  }

  Widget saveWidget() => InkWell(
        onTap: () async {
          controller.isLoadingUpdateProfile.value = true;
          CustomerModel? customerModel = await CustomerService.updateProfile(
            jwt: controller.accountModel.jwtToken,
            id: controller.accountModel.customerModel.id,
            email: controller.email.value,
            firstName: controller.firstName.value,
            lastName: controller.lastName.value,
            address: controller.address.value,
            gender: controller.selectedGender.value,
            avatarFilePath: controller.avatarFilePath.value,
            avatarFile: controller.avatarFile,
          );

          if (customerModel != null) {
            Get.find<AuthController>().accountModel.customerModel =
                customerModel;
            controller
              ..accountModel.customerModel = customerModel
              ..update();
          }

          controller.isLoadingUpdateProfile.value = false;
        },
        child: Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Container(
            height: 45,
            decoration: BoxDecoration(
                color: PRIMARY_COLOR.withOpacity(0.9),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: DARK_GREY_COLOR.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(2, 2),
                  ),
                ],
                border: Border.all(color: PRIMARY_COLOR)),
            alignment: Alignment.center,
            child: CUSTOM_TEXT(
              'SAVE',
              fontWeight: FontWeight.w700,
              color: WHITE_COLOR,
              letterSpacing: 2,
            ),
          ),
        ),
      );
}
