import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/ticket_page_controller.dart';
import 'package:petapp_mobile/models/center_service_model/center_service_model.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class AddServicesWidget extends GetView<CreateTicketPageController> {
  const AddServicesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Obx(
        () => controller.isShowAddServices.value
            ? InkWell(
                onTap: () => controller.isShowAddServices.value = false,
                child: Container(
                  color: DARK_GREY_TRANSPARENT,
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: 500,
                      width: 300,
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: LIGHT_GREY_COLOR.withOpacity(0.3),
                          ),
                          color: WHITE_COLOR),
                      child: Scrollbar(
                        radius: const Radius.circular(10),
                        child: SingleChildScrollView(
                          child: Column(
                              children: controller.centerServicesModelList
                                  .asMap()
                                  .entries
                                  .map(
                                    (e) => centerCervicesItemWidget(
                                      index: e.key,
                                      centerServiceModel: e.value,
                                    ),
                                  )
                                  .toList()),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      );

  Widget centerCervicesItemWidget(
      {required int index, required CenterServiceModel centerServiceModel}) {
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
      onTap: () => controller
        ..selectCenterServicesIndexList.add(index)
        ..totalEstimateTime += centerServiceModel.estimatedTime
        ..isShowAddServices.value = false
        ..update(),
      child: Container(
        width: 300,
        decoration: const BoxDecoration(color: WHITE_COLOR),
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
              color: DARK_GREY_TEXT_COLOR,
              textOverflow: TextOverflow.clip,
              textAlign: TextAlign.center,
            ),
            CUSTOM_TEXT(
              '($timeText)',
              fontSize: 15,
              padding: const EdgeInsets.only(bottom: 10),
              color: DARK_GREY_TEXT_COLOR.withOpacity(0.7),
              textOverflow: TextOverflow.clip,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
