import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/other_controllers/profile_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class ProfilePageTopWidget extends GetView<ProfilePageController> {
  const ProfilePageTopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GetBuilder<ProfilePageController>(
        builder: (_) => Column(
          children: [
            topNavigationBarWidget(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                avatarWidget(),
                Expanded(child: generalInfoWidget()),
              ],
            ),
            viewProfileButton(),
          ],
        ),
      );

  Widget phoneNumberWidget() => Obx(
        () => Row(
          children: [
            InkWell(
              onTap: () => controller.isShowTabProfile.value = true,
              child: Row(
                children: [
                  Text(
                    controller.isShowPhoneNumber.value
                        ? controller.accountModel.phoneNumber
                        : controller.accountModel.hiddenPhoneNumber,
                    style: GoogleFonts.quicksand(
                      color: const Color.fromARGB(255, 64, 69, 87),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Color.fromARGB(255, 110, 115, 128),
                      size: 23,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: InkWell(
                onTap: () => controller.isShowPhoneNumber.value =
                    !controller.isShowPhoneNumber.value,
                child: Icon(
                  controller.isShowPhoneNumber.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: controller.isShowPhoneNumber.value
                      ? GREEN_COLOR.withOpacity(0.7)
                      : RED_COLOR.withOpacity(0.7),
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      );

  Widget topIconWidget() => Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () => Get.toNamed(NOTIFICATION_PAGE_ROUTE),
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: WHITE_COLOR,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: DARK_GREY_COLOR.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(2, 2),
                  )
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 5,
                    left: 5,
                    child: SvgPicture.asset(
                      ICON_PATH + BELL_SVG,
                      color: const Color.fromARGB(255, 110, 117, 131),
                      height: 25,
                    ),
                  ),
                  Positioned(
                    top: 3,
                    right: 3,
                    child: CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 240, 121, 100),
                      radius: 7,
                      child: Text(
                        '4',
                        style: GoogleFonts.itim(
                          fontSize: 12,
                          color: WHITE_COLOR,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  Widget topNavigationBarWidget() => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  phoneNumberWidget(),
                  // topIconWidget(),
                  const Spacer()
                ],
              ),
            ),
            Container(
              height: 1,
              color: DARK_GREY_COLOR.withOpacity(0.1),
            ),
          ],
        ),
      );

  Widget viewProfileButton() => Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              child: InkWell(
                onTap: () => Get.toNamed(PERSONAl_INFORMATION_PAGE_ROUTE),
                child: Container(
                  height: 35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 192, 195, 207),
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    'View your personal information',
                    style: GoogleFonts.quicksand(
                      color: const Color.fromARGB(255, 64, 69, 87),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12, top: 12, bottom: 12),
            child: InkWell(
              onTap: () => Get.toNamed(PERSONAl_INFORMATION_PAGE_ROUTE),
              child: Container(
                height: 35,
                width: 120,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 192, 195, 207),
                  ),
                  borderRadius: BorderRadius.circular(3),
                  color: const Color.fromARGB(255, 243, 243, 243),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Edit profile',
                      style: GoogleFonts.quicksand(
                        color: const Color.fromARGB(255, 64, 69, 87),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SvgPicture.asset(
                      ICON_PATH + EDITING_SVG,
                      height: 16,
                      color: const Color.fromARGB(255, 64, 69, 87),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );

  Widget generalInfoWidget() => Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              generalInfoItemWidget(
                keyText: controller.postQuantity.toString(),
                valueText: 'Posts',
                onTap: () => Get.toNamed(POST_MANAGEMENT_PAGE_ROUTE),
              ),
              generalInfoItemWidget(
                keyText: controller.petQuantity.toString(),
                valueText: 'Pets',
                onTap: () => Get.toNamed(PET_MANAGEMENT_PAGE_ROUTE),
              ),
              generalInfoItemWidget(
                keyText: controller.orderQuantity.toString(),
                valueText: 'Orders',
                onTap: () => Get.toNamed(TRANSACTION_PAGE_ROUTE),
              ),
            ],
          ),
        ],
      );

  Widget ratingBarWidget({required double star, required String valueText}) =>
      Column(
        children: [
          SizedBox(
            width: 100,
            child: RatingBar.builder(
              initialRating: star,
              itemCount: 5,
              itemSize: 20,
              allowHalfRating: false,
              unratedColor: Colors.amber.withOpacity(0.2),
              ignoreGestures: true,
              itemBuilder: (context, index) => const Icon(
                Icons.star_rate_rounded,
                color: Color.fromARGB(255, 255, 211, 78),
              ),
              onRatingUpdate: (_) {},
            ),
          ),
          Text(
            valueText,
            style: GoogleFonts.quicksand(
              color: const Color.fromARGB(255, 64, 69, 87),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );

  Widget generalInfoItemWidget(
          {required String keyText,
          required String valueText,
          required Function() onTap}) =>
      Expanded(
        child: InkWell(
          onTap: onTap,
          child: Column(
            children: [
              Text(
                keyText,
                style: GoogleFonts.quicksand(
                  color: const Color.fromARGB(255, 64, 69, 87),
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                valueText,
                style: GoogleFonts.quicksand(
                  color: const Color.fromARGB(255, 64, 69, 87),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );

  Widget avatarWidget() => Container(
        width: 130,
        padding: const EdgeInsets.only(left: 12),
        child: Column(
          children: [
            Stack(
              children: [
                GRADIENT_WIDGET(
                  child: const CircleAvatar(
                    maxRadius: 32,
                    minRadius: 32,
                  ),
                ),
                CircleAvatar(
                  maxRadius: 32,
                  minRadius: 32,
                  backgroundColor: Colors.transparent,
                  child: controller.accountModel.customerModel.avatar == null ||
                          controller.accountModel.customerModel.avatar!.isEmpty
                      ? CircleAvatar(
                          backgroundColor: PRIMARY_COLOR.withOpacity(0.7),
                          maxRadius: 29,
                          minRadius: 29,
                          child: Text(
                            controller
                                .accountModel.customerModel.avatarCharacter,
                            style: GoogleFonts.quicksand(
                              color: WHITE_COLOR,
                              fontSize: 23,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : CircleAvatar(
                          maxRadius: 29,
                          minRadius: 29,
                          backgroundImage: NetworkImage(
                              controller.accountModel.customerModel.avatar!),
                        ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  controller.accountModel.customerModel.firstName +
                      ' ' +
                      controller.accountModel.customerModel.lastName,
                  style: GoogleFonts.quicksand(
                    color: const Color.fromARGB(255, 64, 69, 87),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
