import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/personal_information_page_controller.dart';
import 'package:petapp_mobile/views/customer/personal_infomation_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/personal_infomation_page/widgets/top_widget.dart';

class PersonalInformationPage
    extends GetView<PersonalInfomationPageController> {
  const PersonalInformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 251, 255),
      body: Stack(
        children: [
          GetBuilder<PersonalInfomationPageController>(
            builder: (_) => Padding(
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
          ),
          Obx(
            () => controller.isLoadingUpdateProfile.value
                ? Container(
                    color: const Color.fromARGB(75, 249, 236, 253),
                    child: const SpinKitSpinningLines(
                      color: PRIMARY_COLOR,
                      size: 150,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
