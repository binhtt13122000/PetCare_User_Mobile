import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/controllers/personal_information_page_controller.dart';
import 'package:petapp_mobile/controllers/sign_in_page_controller.dart';
import 'package:petapp_mobile/views/customer/personal_infomation_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/personal_infomation_page/widgets/top_widget.dart';

class PersonalInformationPage
    extends GetView<PersonalInfomationPageController> {
  const PersonalInformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignInPageController signInPageController =
        Get.find<SignInPageController>();
    controller.accountModel = signInPageController.accountModel!;
    controller.selectedGender =
        signInPageController.accountModel!.customerModel.gender.obs;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 251, 255),
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: SingleChildScrollView(
          child: Column(
            children: const [
              PersonalInformationTopWidget(),
              PersonalInformationBodyWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
