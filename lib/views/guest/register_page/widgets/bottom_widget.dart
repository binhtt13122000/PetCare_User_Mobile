import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/register_page_controller.dart';
import 'package:petapp_mobile/controllers/sign_in_page_controller.dart';
import 'package:petapp_mobile/services/account_services.dart';

class RegisterPageBottomWidget extends GetView<RegisterPageController> {
  const RegisterPageBottomWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: InkWell(
              onTap: () async {
                controller.isLoadingRegister.value = true;
                controller.accountModel = await AccountService.register(
                  email: controller.email.value,
                  firstName: controller.firstName.value,
                  lastName: controller.lastName.value,
                  phoneNumber: controller.selectedAreaCode +
                      controller.phoneNumber.value,
                  adrress: controller.address.value,
                  gender: controller.gender.value,
                  avatarFilePath: controller.avatarfilePath.value,
                  accessToken: controller.accessToken,
                  deviceToken: controller.userDeviceToken,
                );
                if (controller.accountModel != null) {
                  Get.put(SignInPageController())
                    ..accountModel = controller.accountModel
                    ..auth = controller.auth
                    ..userDeviceToken = controller.userDeviceToken;
                  Get.toNamed(HOME_PAGE_ROUNTER);
                  controller.isLoadingRegister.value = false;
                } else {
                  controller.isLoadingRegister.value = false;
                }
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    color: PRIMARY_COLOR.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: PRIMARY_COLOR)),
                alignment: Alignment.center,
                child: Text(
                  'Register',
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
