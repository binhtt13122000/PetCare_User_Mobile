import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/buy_services_combo_page_controller.dart';
import 'package:petapp_mobile/models/services_combo_detail_model/services_combo_detail_model.dart';
import 'package:petapp_mobile/services/transaction_services/services_combo_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class BuyServicesComboListComboWidget
    extends GetView<BuyServicesComboPageController> {
  const BuyServicesComboListComboWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
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
        if (controller.isLoadingPetServicesComboDetail &&
            controller.selectPetServicesComboIndex.value != -1) {
          controller.isWaitLoadingPetServicesComboDetail.value = true;
          WidgetsBinding.instance!.addPostFrameCallback((_) async {
            controller
              ..petServicesComboModel =
                  await ServicesComboModelServices.fetchServicesComboById(
                      jwt: controller.accountModel.jwtToken,
                      id: controller
                          .petServicesComboModelList[
                              controller.selectPetServicesComboIndex.value]
                          .id)
              ..totalPrice.value = controller.petServicesComboModel.price
              ..isWaitLoadingPetServicesComboDetail.value = false
              ..isLoadingPetServicesComboDetail = false;
          });
        }
        return Obx(
          () => controller.isWaitLoadingPetServicesComboDetail.value
              ? LOADING_WIDGET(size: 60)
              : controller.selectPetServicesComboIndex.value != -1
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CUSTOM_TEXT('Type'),
                                    CUSTOM_TEXT(
                                        controller.petServicesComboModel.type),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CUSTOM_TEXT('Price'),
                                    CUSTOM_TEXT(FORMAT_MONEY(
                                        price: controller
                                            .petServicesComboModel.price)),
                                  ],
                                ),
                              ),
                              Obx(
                                () => Column(
                                  children: [
                                    Visibility(
                                      visible: controller
                                          .isViewServicesComboDescriptionWidget
                                          .value,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 3),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            //CUSTOM_TEXT('Description'),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Html(
                                                    data: controller
                                                            .petServicesComboModel
                                                            .description ??
                                                        'N/A'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => controller
                                              .isViewServicesComboDescriptionWidget
                                              .value =
                                          !controller
                                              .isViewServicesComboDescriptionWidget
                                              .value,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                controller
                                                        .isViewServicesComboDescriptionWidget
                                                        .value
                                                    ? 'Hide description'
                                                    : 'View description',
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                  color: PRIMARY_COLOR,
                                                  letterSpacing: 2,
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              Icon(
                                                controller
                                                        .isViewServicesComboDescriptionWidget
                                                        .value
                                                    ? Icons
                                                        .keyboard_double_arrow_up_outlined
                                                    : Icons
                                                        .keyboard_double_arrow_down_outlined,
                                                size: 18,
                                                color: PRIMARY_COLOR,
                                              )
                                            ],
                                          ),
                                          Container(
                                            height: 1,
                                            width: 160,
                                            color: PRIMARY_COLOR,
                                            margin: const EdgeInsets.only(
                                                top: 2, left: 15, right: 15),
                                          ),
                                        ],
                                      ),
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
                          margin: const EdgeInsets.only(top: 10),
                        ),
                        Container(
                          height: 10,
                          color: SUPPER_LIGHT_BLUE,
                        ),
                        servicesListItemWidget(),
                      ],
                    )
                  : const SizedBox.shrink(),
        );
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CUSTOM_TEXT(
                    petServicesComboDetailModel.centerServiceModel.name,
                    textOverflow: TextOverflow.clip,
                  ),
                ),
                CUSTOM_TEXT(
                  petServicesComboDetailModel.nextEvent.toString() + ' days',
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  Widget servicesComboItemList() {
    List<DropdownMenuItem<int>> petServicesComboModelListDropDownItem = [];

    if (controller.petServicesComboModelList.isNotEmpty) {
      int index = 0;
      do {
        if (controller.petServicesComboModelList[index].type != 'BREED') {
          petServicesComboModelListDropDownItem.add(
            DropdownMenuItem(
              value: index,
              child: Text(
                controller.petServicesComboModelList[index].name,
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 78, 98, 124),
                  fontSize: 16,
                ),
              ),
            ),
          );
        }
        index++;
      } while (index < controller.petServicesComboModelList.length);
    }

    return Obx(
      () => DropdownButton<int>(
        value: controller.selectPetServicesComboIndex.value,
        items: [
          ...[
            DropdownMenuItem(
              value: -1,
              child: Text(
                '- Select pet services combo -',
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w500,
                  color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
                  fontSize: 16,
                ),
              ),
            )
          ],
          ...petServicesComboModelListDropDownItem
        ],
        onChanged: (int? value) => controller
          ..selectPetServicesComboIndex.value = value!
          ..isLoadingPetServicesComboDetail = true
          ..isLoadingPet = false
          ..update(),
      ),
    );
  }

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
}
