import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/other_controllers/profile_page_controller.dart';
import 'package:petapp_mobile/services/other_services/auth_services.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class ProfileTabWidget extends GetView<ProfilePageController> {
  const ProfileTabWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Obx(
        () => Visibility(
          visible: controller.isShowTabProfile.value,
          child: InkWell(
            onTap: () => controller.isShowTabProfile.value = false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 70, left: 12),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          width: 200,
                          height: 240,
                          decoration: BoxDecoration(
                            color: WHITE_COLOR,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: DARK_GREY_COLOR.withOpacity(0.5),
                                offset: const Offset(3, 3),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buttonWidget(content: 'Hi', onTap: () {}),
                              buttonWidget(content: 'Guy', onTap: () {}),
                              buttonWidget(content: 'Me Luci', onTap: () {}),
                              buttonWidget(
                                  content: 'Sign out',
                                  isImportant: true,
                                  onTap: () async {
                                    controller.isWaitingSignOut.value = true;
                                    await controller.setUserDeviceToken();
                                    await FirebaseAuth.instance.signOut();
                                    await AuthService.signOut(
                                        accountId: controller.accountModel.id,
                                        deviceToken:
                                            controller.userDeviceToken);
                                    Get.deleteAll();
                                    Get.offAllNamed(LANDING_PAGE_ROUTE);
                                  })
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Spacer(flex: 1),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget buttonWidget(
          {required content,
          bool isImportant = false,
          required Function() onTap}) =>
      InkWell(
        onTap: onTap,
        child: Container(
          width: 180,
          decoration: BoxDecoration(
            color: WHITE_COLOR,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: isImportant
                  ? RED_COLOR
                  : DARK_GREY_TEXT_COLOR.withOpacity(0.5),
            ),
          ),
          padding: const EdgeInsets.all(10),
          child: CUSTOM_TEXT(
            content,
            textAlign: TextAlign.center,
            letterSpacing: 1,
            fontSize: 14,
            color: isImportant ? RED_COLOR : DARK_GREY_TEXT_COLOR,
          ),
        ),
      );
}
