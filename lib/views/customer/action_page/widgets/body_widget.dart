import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/action_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class ActionPageBodyWidget extends GetView<ActionPageController> {
  const ActionPageBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image.asset(IMAGE_PATH + BACKGROUND_ONE_PNG),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: const EdgeInsets.only(top: 270),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 5,
                        width: 30,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: PRIMARY_COLOR,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                      Container(
                        height: 5,
                        width: 15,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 234, 217, 235),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                      Container(
                        height: 5,
                        width: 15,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 234, 217, 235),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 55, top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buttonWidget(
                      name: 'Pet Management',
                      onTap: () => Get.toNamed(PET_MANAGEMENT_PAGE_ROUTE),
                    ),
                    buttonWidget(
                      name: 'Post Management',
                      onTap: () => Get.toNamed(POST_MANAGEMENT_PAGE_ROUTE),
                    ),
                    Obx(
                      () => buttonWidget(
                        name: controller.ticketId.value != -1
                            ? 'View Current Ticket'
                            : 'Create Ticket',
                        onTap: () => Get.toNamed(controller.ticketId.value != -1
                            ? '$TICKET_DETAIL_PAGE_ROUTE/${controller.ticketId.value}'
                            : CREATE_TICKET_PAGE_ROUTE),
                      ),
                    ),
                    buttonWidget(
                      name: 'Transaction History',
                      onTap: () => Get.toNamed(TRANSACTION_PAGE_ROUTE),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonWidget({required String name, required Function() onTap}) =>
      InkWell(
        onTap: onTap,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: LIGHT_GREY_COLOR.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: LIGHT_GREY_COLOR.withOpacity(0.1),
                blurRadius: 3,
                offset: const Offset(3, 3),
              ),
            ],
            color: WHITE_COLOR,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CUSTOM_TEXT(name, letterSpacing: 2),
            ],
          ),
        ),
      );
}
