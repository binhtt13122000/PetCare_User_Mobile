import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/main_page_controllers/action_page_controller.dart';
import 'package:petapp_mobile/models/ticket_model/ticket_model.dart';
import 'package:petapp_mobile/services/transaction_services/ticket_services.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ActionPageBodyWidget extends GetView<ActionPageController> {
  const ActionPageBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ActionPageController>(builder: (_) {
      controller.isLoadingData.value = true;

      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        TicketModel? ticketModel = await TicketServices.fetchTicketByCustomerId(
            jwt: controller.accountModel.jwtToken,
            customerId: controller.accountModel.customerModel.id);
        controller
          ..ticketModel = ticketModel
          ..ticketId.value = ticketModel != null ? ticketModel.id : -1
          ..isLoadingData.value = false;
      });
      return Obx(
        () => controller.isLoadingData.value
            ? Expanded(child: LOADING_WIDGET())
            : Expanded(
                child: SmartRefresher(
                  controller: RefreshController(),
                  onRefresh: () => controller.update(),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          imageCardWidget(),
                          const SizedBox(
                            height: 20,
                          ),
                          buttonWidget(
                            name: 'Pet Management',
                            onTap: () => Get.toNamed(PET_MANAGEMENT_PAGE_ROUTE),
                            iconData: Icons.pets,
                          ),
                          buttonWidget(
                            name: 'Post Management',
                            onTap: () =>
                                Get.toNamed(POST_MANAGEMENT_PAGE_ROUTE),
                            iconData: Icons.photo_album_sharp,
                          ),
                          Obx(
                            () => buttonWidget(
                              name: controller.ticketId.value != -1
                                  ? 'View Current Ticket'
                                  : 'Booking Ticket',
                              onTap: () => Get.toNamed(controller
                                          .ticketId.value !=
                                      -1
                                  ? '$TICKET_DETAIL_PAGE_ROUTE/${controller.ticketId.value}'
                                  : CREATE_TICKET_PAGE_ROUTE),
                              iconData: Icons.airplane_ticket,
                            ),
                          ),
                          buttonWidget(
                            name: 'Transaction History',
                            onTap: () => Get.toNamed(TRANSACTION_PAGE_ROUTE),
                            iconData: Icons.history,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      );
    });
  }

  Widget petComboBanner() {
    ActionPageController actionPageController =
        Get.find<ActionPageController>();
    return SizedBox(
      height: 330,
      width: 350,
      child: PageView(
        controller: actionPageController.pageController,
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Image.asset(
              IMAGE_PATH + actionPageController.imagePathList[0],
              height: 330,
              width: 350,
              fit: BoxFit.cover,
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Image.asset(
              IMAGE_PATH + actionPageController.imagePathList[1],
              height: 330,
              width: 350,
              fit: BoxFit.cover,
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Image.asset(
              IMAGE_PATH + actionPageController.imagePathList[2],
              height: 330,
              width: 350,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget imageCardWidget() => Obx(
        () => InkWell(
          onTap: () => Get.toNamed(BUY_SERVICES_COMBO_PAGE_ROUTE),
          child: Stack(
            children: [
              // Center(
              //   child: ClipRRect(
              //     borderRadius: const BorderRadius.all(Radius.circular(10)),
              //     child: Image.asset(
              //       IMAGE_PATH +
              //           controller
              //               .imagePathList[controller.selectedImageIndex.value],
              //       height: 330,
              //       width: 350,
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
              petComboBanner(),
              Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(top: 270),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 5,
                      width: controller.selectedImageIndex.value == 0 ? 30 : 15,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: controller.selectedImageIndex.value == 0
                            ? PRIMARY_COLOR
                            : const Color.fromARGB(255, 234, 217, 235),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                    Container(
                      height: 5,
                      width: controller.selectedImageIndex.value == 1 ? 30 : 15,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: controller.selectedImageIndex.value == 1
                            ? PRIMARY_COLOR
                            : const Color.fromARGB(255, 234, 217, 235),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                    Container(
                      height: 5,
                      width: controller.selectedImageIndex.value == 2 ? 30 : 15,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: controller.selectedImageIndex.value == 2
                            ? PRIMARY_COLOR
                            : const Color.fromARGB(255, 234, 217, 235),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );

  Widget buttonWidget(
          {required String name,
          required Function() onTap,
          required IconData iconData}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: InkWell(
          onTap: () {
            //  controller.cancelTimer();
            onTap.call();
          },
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
                Container(
                  width: 70,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: Icon(
                    iconData,
                    color: DARK_GREY_TEXT_COLOR,
                    size: 22,
                  ),
                ),
                Expanded(
                  child: CUSTOM_TEXT(
                    name,
                    letterSpacing: 2,
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
