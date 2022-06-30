import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/main_page_controllers/home_page_controller.dart';
import 'package:petapp_mobile/models/center_service_model/center_service_model.dart';
import 'package:petapp_mobile/services/transaction_services/center_services_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class HomeServicesListWidget extends GetView<HomePageController> {
  const HomeServicesListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          CUSTOM_TEXT(
            'Pet services list',
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
            fontSize: 18,
            padding: const EdgeInsets.only(bottom: 15),
          ),
          GetBuilder<HomePageController>(builder: (_) {
            controller.isWaitingLoadingServicesList.value = true;
            WidgetsBinding.instance!.addPostFrameCallback((_) async {
              controller
                ..servicesList =
                    await CenterServicesServices.fetchCenterServicesList()
                ..isWaitingLoadingServicesList.value = false;
            });
            return Obx(() => controller.isWaitingLoadingServicesList.value
                ? Expanded(child: LOADING_WIDGET())
                : Expanded(
                    child: SingleChildScrollView(
                        child: centerServicesItemListItemWidget())));
          }),
        ],
      ),
    );
  }

  Widget centerServicesItemListItemWidget() => Column(
        children: controller.servicesList
            .asMap()
            .entries
            .map((e) => centerServicesItemWidget(
                centerServiceModel: e.value, index: e.key))
            .toList(),
      );

  Widget centerServicesItemWidget(
          {required CenterServiceModel centerServiceModel,
          required int index}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              height: 1,
              color: LIGHT_GREY_COLOR.withAlpha(30),
              margin: const EdgeInsets.only(top: 5, bottom: 3),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              color: index.isEven
                  ? LIGHT_GREY_COLOR.withAlpha(10)
                  : LIGHT_GREY_COLOR.withAlpha(3),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CUSTOM_TEXT(
                        'Name',
                        color: DARK_GREY_TEXT_COLOR.withOpacity(0.95),
                        padding: const EdgeInsets.only(right: 15),
                      ),
                      Expanded(
                        child: CUSTOM_TEXT(
                          centerServiceModel.name,
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.95),
                          textAlign: TextAlign.end,
                          textOverflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CUSTOM_TEXT(
                        'Price',
                        padding: const EdgeInsets.only(right: 15),
                        color: DARK_GREY_TEXT_COLOR.withOpacity(0.95),
                      ),
                      Expanded(
                        child: CUSTOM_TEXT(
                          centerServiceModel.centerServiceFeeModelList !=
                                      null &&
                                  centerServiceModel
                                      .centerServiceFeeModelList!.isNotEmpty &&
                                  centerServiceModel
                                          .centerServiceFeeModelList![0].price >
                                      0
                              ? FORMAT_MONEY(
                                      price: centerServiceModel
                                          .centerServiceFeeModelList![0]
                                          .price) +
                                  ' / ' +
                                  (centerServiceModel.unit
                                          .replaceAll(' ', '')
                                          .isEmpty
                                      ? 'Slot'
                                      : centerServiceModel.unit)
                              : 'N/A',
                          textAlign: TextAlign.end,
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.95),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CUSTOM_TEXT(
                        'Estimate time',
                        color: DARK_GREY_TEXT_COLOR.withOpacity(0.95),
                        padding: const EdgeInsets.only(right: 15),
                      ),
                      Expanded(
                        child: CUSTOM_TEXT(
                          centerServiceModel.estimatedTimeText,
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.95),
                          textAlign: TextAlign.end,
                          textOverflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                  Obx(
                    () => Column(
                      children: [
                        Visibility(
                          visible: controller.selectedServicesList
                              .contains(centerServiceModel.name),
                          child: Column(
                            children: [
                              Html(data: centerServiceModel.description ?? ''),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            InkWell(
                              onTap: () => controller.selectedServicesList
                                      .contains(centerServiceModel.name)
                                  ? controller.selectedServicesList
                                      .remove(centerServiceModel.name)
                                  : controller.selectedServicesList
                                      .add(centerServiceModel.name),
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CUSTOM_TEXT(
                                      controller.selectedServicesList
                                              .contains(centerServiceModel.name)
                                          ? 'Hide details'
                                          : 'View details',
                                      color: PRIMARY_COLOR,
                                      fontSize: 13,
                                      letterSpacing: 2,
                                    ),
                                    const SizedBox(width: 5),
                                    Icon(
                                      controller.selectedServicesList
                                              .contains(centerServiceModel.name)
                                          ? Icons
                                              .keyboard_double_arrow_up_outlined
                                          : Icons
                                              .keyboard_double_arrow_down_outlined,
                                      size: 18,
                                      color: PRIMARY_COLOR,
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 1,
                                  width: 120,
                                  color: PRIMARY_COLOR,
                                  margin: const EdgeInsets.only(top: 2),
                                ),
                              ]),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: LIGHT_GREY_COLOR.withAlpha(30),
              margin: const EdgeInsets.only(top: 3, bottom: 5),
            ),
          ],
        ),
      );
}
