import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/buy_services_combo_page_controller.dart';
import 'package:petapp_mobile/models/services_combo_detail_model/services_combo_detail_model.dart';
import 'package:petapp_mobile/services/services_combo_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class BuyServicesComboListComboWidget
    extends GetView<BuyServicesComboPageController> {
  const BuyServicesComboListComboWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.only(top: 15),
            color: WHITE_COLOR,
            child: Column(
              children: [
                servicesComboItemListTitle(),
                servicesComboItemList(),
                petServicesComboDetail(),
              ],
            ),
          ),
        ],
      );

  Widget petServicesComboDetail() =>
      GetBuilder<BuyServicesComboPageController>(builder: (_) {
        if (controller.isLoadingPetServicesComboDetail) {
          controller.isWaitLoadingPetServicesComboDetail.value = true;
          WidgetsBinding.instance!.addPostFrameCallback((_) async {
            controller
              ..petServicesComboModel =
                  await ServicesComboModelServices.fetchServicesComboById(
                      id: controller
                          .petServicesComboModelList[
                              controller.selectPetServicesComboIndex.value]
                          .id)
              ..totalPrice.value = controller.petServicesComboModel.price
              ..isWaitLoadingPetServicesComboDetail.value = false
              ..isLoadingPetServicesComboDetail = false;
          });
        }
        return Obx(() => controller.isWaitLoadingPetServicesComboDetail.value
            ? LOADING_WIDGET(size: 60)
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CUSTOM_TEXT('Type'),
                              CUSTOM_TEXT(
                                  controller.petServicesComboModel.type),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CUSTOM_TEXT('Price'),
                              CUSTOM_TEXT(FORMAT_MONEY(
                                  price:
                                      controller.petServicesComboModel.price)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CUSTOM_TEXT('Description'),
                              CUSTOM_TEXT(controller
                                      .petServicesComboModel.description ??
                                  'N/A'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    color: LIGHT_GREY_COLOR.withAlpha(30),
                    margin: const EdgeInsets.only(top: 10),
                  ),
                  Container(
                    height: 10,
                    color: SUPPER_LIGHT_BLUE,
                  ),
                  servicesListItemWidget(),
                  Container(
                    height: 1,
                    color: LIGHT_GREY_COLOR.withAlpha(30),
                  ),
                ],
              ));
      });

  Widget servicesListItemWidget() => Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        color: WHITE_COLOR,
        child: Column(
          children: [
            CUSTOM_TEXT('Services list'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CUSTOM_TEXT('Name'),
                  CUSTOM_TEXT('Next event'),
                ],
              ),
            ),
            Container(
              height: 1,
              color: LIGHT_GREY_COLOR.withAlpha(30),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            ),
            Column(
              children: controller
                  .petServicesComboModel.petServicesComboDetailModelList!
                  .map(
                      (e) => servicesItemWidget(petServicesComboDetailModel: e))
                  .toList(),
            )
          ],
        ),
      );

  Widget servicesItemWidget(
          {required ServicesComboDetailModel petServicesComboDetailModel}) =>
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CUSTOM_TEXT(
                    petServicesComboDetailModel.centerServiceModel.name),
                CUSTOM_TEXT(
                    petServicesComboDetailModel.nextEvent.toString() + ' days'),
              ],
            ),
          ),
        ],
      );

  Widget servicesComboItemList() => Obx(
        () => DropdownButton<int>(
          value: controller.selectPetServicesComboIndex.value,
          items: controller.petServicesComboModelList
              .asMap()
              .entries
              .map((e) => DropdownMenuItem(
                  value: e.key,
                  child: Text(
                    e.value.name,
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 78, 98, 124),
                      fontSize: 16,
                    ),
                  )))
              .toList(),
          onChanged: (int? value) => controller
            ..selectPetServicesComboIndex.value = value!
            ..isLoadingPetServicesComboDetail = true
            ..update(),
        ),
      );

  Widget servicesComboItemListTitle() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CUSTOM_TEXT('Select pet services combo',
              padding: const EdgeInsets.only(left: 12)),
          CUSTOM_TEXT('*',
              color: RED_COLOR,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              padding: const EdgeInsets.only(right: 20)),
        ],
      );

  Widget servicesComboItem() => Container();
}
