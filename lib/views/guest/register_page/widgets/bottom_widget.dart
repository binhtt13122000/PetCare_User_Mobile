import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/controllers/guest_page_controllers/register_page_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/services/other_services/auth_services.dart';

class RegisterPageBottomWidget extends GetView<RegisterPageController> {
  const RegisterPageBottomWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
            height: 1,
            color: LIGHT_GREY_COLOR.withAlpha(30),
            margin: const EdgeInsets.only(bottom: 10),
          ),
          Obx(
            () => Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: InkWell(
                onTap: () async {
                  if (controller.firstName.value.isNotEmpty &&
                      controller.lastName.value.isNotEmpty &&
                      controller.phoneNumber.isNotEmpty) {
                    controller.isLoadingRegister.value = true;
                    AccountModel? accountModel = await AuthService.register(
                      email: controller.email.value,
                      firstName: controller.firstName.value,
                      lastName: controller.lastName.value,
                      phoneNumber: controller.selectedAreaCode +
                          controller.phoneNumber.value,
                      address: controller.address.value,
                      gender: controller.gender.value,
                      avatarFilePath: controller.avatarFilePath.value,
                      accessToken: controller.accessToken,
                      deviceToken: controller.userDeviceToken,
                      registerTime: DateTime.now(),
                    );
                    if (accountModel != null) {
                      Get.lazyPut<AuthController>(
                          () => AuthController(accountModel: accountModel),
                          fenix: true);
                      Get.offAllNamed(HOME_PAGE_ROUTE);
                      controller.isLoadingRegister.value = false;
                    } else {
                      controller.isLoadingRegister.value = false;
                    }
                  }
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: controller.firstName.value.isNotEmpty &&
                            controller.lastName.value.isNotEmpty
                        ? PRIMARY_COLOR.withOpacity(0.9)
                        : PRIMARY_COLOR.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: controller.firstName.value.isNotEmpty &&
                              controller.lastName.value.isNotEmpty
                          ? PRIMARY_COLOR
                          : Colors.transparent,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'REGISTER',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w700,
                      color: WHITE_COLOR,
                      fontSize: 15,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'By clicking register, you agree to ',
                style: GoogleFonts.quicksand(
                  color: const Color.fromARGB(255, 109, 119, 143),
                  fontSize: 10,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w600,
                ),
                children: const [
                  TextSpan(
                    text: 'the Terms \nof Service',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: PRIMARY_COLOR,
                    ),
                  ),
                  TextSpan(
                    text: ' and ',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 109, 119, 143),
                    ),
                  ),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: PRIMARY_COLOR,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}
