import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/create_ticket_page_controller.dart';
import 'package:petapp_mobile/models/center_service_model/center_service_model.dart';
import 'package:petapp_mobile/services/transaction_services/center_services_services.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class AddServicesWidget extends GetView<CreateTicketPageController> {
  const AddServicesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Obx(
        () => controller.isShowAddServices.value
            ? GetBuilder<CreateTicketPageController>(builder: (_) {
                int speciesId = controller
                    .pets[controller.selectPetIndex].breedModel!.speciesId!;
                double listHeight = 0;
                if (!controller.mapCenterServices.containsKey(speciesId)) {
                  controller.isLoadingServices.value = true;
                  WidgetsBinding.instance!.addPostFrameCallback((_) async {
                    List<CenterServiceModel> centerServicesModelList =
                        await CenterServicesServices.fetchCenterServicesList(
                      jwt: controller.accountModel.jwtToken,
                      speciesId: controller.pets[controller.selectPetIndex]
                          .breedModel!.speciesId,
                    );

                    listHeight = centerServicesModelList.length * 39;
                    if (listHeight > 500) {
                      listHeight = 500;
                    }
                    controller
                      ..mapCenterServices
                          .addAll({speciesId: centerServicesModelList})
                      ..isLoadingServices.value = false;
                  });
                } else {
                  listHeight =
                      controller.mapCenterServices[speciesId]!.length * 39;
                  if (listHeight > 500) {
                    listHeight = 500;
                  }
                }

                return Obx(
                  () => controller.isLoadingServices.value
                      ? Container(
                          color: DARK_GREY_TRANSPARENT,
                          child: LOADING_WIDGET(),
                        )
                      : InkWell(
                          onTap: () =>
                              controller.isShowAddServices.value = false,
                          child: Container(
                            color: DARK_GREY_TRANSPARENT,
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                height: listHeight,
                                width: 300,
                                margin: const EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: LIGHT_GREY_COLOR.withOpacity(0.3),
                                    ),
                                    color: WHITE_COLOR),
                                child: Scrollbar(
                                  radius: const Radius.circular(10),
                                  child: SingleChildScrollView(
                                    child: Column(
                                        children: controller
                                            .mapCenterServices[speciesId]!
                                            .asMap()
                                            .entries
                                            .map(
                                              (e) => e.value.type != 'BREED'
                                                  ? centerCervicesItemWidget(
                                                      centerServiceModel:
                                                          e.value,
                                                    )
                                                  : const SizedBox.shrink(),
                                            )
                                            .toList()),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                );
              })
            : const SizedBox.shrink(),
      );

  Widget centerCervicesItemWidget(
      {required CenterServiceModel centerServiceModel}) {
    int index = 0;
    for (var element in controller.centerServicesModelList) {
      if (element.id == centerServiceModel.id) {
        break;
      } else {
        index++;
      }
    }
    String timeText = '';
    int hours = centerServiceModel.estimatedTime ~/ 60;
    int minutes = centerServiceModel.estimatedTime % 60;

    if (hours > 0 && minutes > 0) {
      timeText = '$hours hours : $minutes minutes';
    } else if (hours > 0) {
      timeText = '$hours hours';
    } else {
      timeText = '$minutes minutes';
    }
    return InkWell(
      onTap: () {
        if (!controller.selectServicesMap[controller.selectPetIndex]!
            .contains(index)) {
          controller
            ..selectServicesMap[controller.selectPetIndex]!.add(index)
            ..countServices.value += 1
            //..selectCenterServicesIndexList.add(index)
            ..totalEstimateTime += centerServiceModel.estimatedTime
            ..isShowAddServices.value = false
            ..update();
        }
      },
      child: Container(
        width: 300,
        decoration: BoxDecoration(
            color: controller.selectServicesMap[controller.selectPetIndex]!
                    .contains(index)
                ? PRIMARY_COLOR
                : WHITE_COLOR),
        child: Column(
          children: [
            Visibility(
              visible: !(index == controller.centerServicesModelList.length ||
                  index == 0),
              child: Container(
                height: 1,
                color: LIGHT_GREY_COLOR.withOpacity(0.3),
              ),
            ),
            CUSTOM_TEXT(
              centerServiceModel.name,
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              fontSize: 17,
              color: controller.selectServicesMap[controller.selectPetIndex]!
                      .contains(index)
                  ? WHITE_COLOR
                  : DARK_GREY_TEXT_COLOR,
              textOverflow: TextOverflow.clip,
              textAlign: TextAlign.center,
            ),
            CUSTOM_TEXT(
              '($timeText)',
              fontSize: 15,
              padding: const EdgeInsets.only(bottom: 10),
              color: controller.selectServicesMap[controller.selectPetIndex]!
                      .contains(index)
                  ? WHITE_COLOR
                  : DARK_GREY_TEXT_COLOR.withOpacity(0.7),
              textOverflow: TextOverflow.clip,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
