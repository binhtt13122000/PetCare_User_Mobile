import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/guest_page_controllers/landing_page_controller.dart';
import 'package:petapp_mobile/services/other_services/policy_services.dart';
import 'package:petapp_mobile/views/guest/landing_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/guest/landing_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class GuestLandingPage extends GetView<GuestLandingPageController> {
  const GuestLandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: WHITE_COLOR,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                GuestLandingTopWidget(),
                GuestLandingBodyWidget(),
              ],
            ),
            Obx(
              () => Visibility(
                visible: controller.isShowPolicy.value,
                child: InkWell(
                  onTap: () => controller.isShowPolicy.value = false,
                  child: Container(
                    alignment: Alignment.center,
                    color: DARK_GREY_TRANSPARENT,
                    child: GetBuilder<GuestLandingPageController>(builder: (_) {
                      WidgetsBinding.instance!.addPostFrameCallback((_) async {
                        controller
                          ..policy = await PolicyServices.fetchPolicy()
                          ..isLoadingData.value = false;
                      });
                      return Obx(
                        () => Container(
                          height: 500,
                          width: 300,
                          decoration: BoxDecoration(
                            color: WHITE_COLOR,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: controller.isLoadingData.value
                              ? LOADING_WIDGET()
                              : SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      CUSTOM_TEXT('PRIVACY POLICY',
                                          fontWeight: FontWeight.w700,
                                          padding:
                                              const EdgeInsets.only(top: 20),
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
