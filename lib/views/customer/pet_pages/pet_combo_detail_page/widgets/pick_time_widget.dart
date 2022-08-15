import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_combo_detail_page_controller.dart';
import 'package:petapp_mobile/models/ticket_time_model/ticket_time_model.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class PetComboPickTimeWidget extends GetView<PetComboDetailPageController> {
  const PetComboPickTimeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Obx(
        () => controller.isShowPickTimeWidget.value
            ? InkWell(
                onTap: () => controller.isShowPickTimeWidget.value = false,
                child: Container(
                  color: DARK_GREY_TRANSPARENT,
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: () {
                        if (controller.ticketTimeModelList.length >= 8) {
                          return 290.toDouble();
                        } else {
                          return (43 * controller.ticketTimeModelList.length)
                              .toDouble();
                        }
                      }.call(),
                      width: 200,
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: LIGHT_GREY_COLOR.withOpacity(0.3),
                          ),
                          color: WHITE_COLOR),
                      child: Scrollbar(
                        radius: const Radius.circular(10),
                        child: SingleChildScrollView(
                          child: Column(
                              children: controller.ticketTimeModelList
                                  .asMap()
                                  .entries
                                  .map(
                                    (e) => timeItemWidget(
                                      index: e.key,
                                      ticketTimeModel: e.value,
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

  Widget timeItemWidget(
          {required int index, required TicketTimeModel ticketTimeModel}) =>
      InkWell(
        onTap: () => controller
          ..selectedTicketTimeIndex.value = index
          ..isShowPickTimeWidget.value = false,
        child: Container(
          decoration: BoxDecoration(
              color: controller.selectedTicketTimeIndex.value == index
                  ? PRIMARY_COLOR
                  : WHITE_COLOR),
          child: Column(
            children: [
              Visibility(
                visible: !(index == controller.ticketTimeModelList.length),
                child: Container(
                  height: 1,
                  color: LIGHT_GREY_COLOR.withOpacity(0.3),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CUSTOM_TEXT(
                        (ticketTimeModel.startTime ~/ 60 + 7).toString() +
                            ':' +
                            ((ticketTimeModel.startTime % 60) == 0
                                ? '00'
                                : '30') +
                            ((ticketTimeModel.startTime ~/ 60 + 7) <= 12
                                ? ' AM'
                                : ' PM'),
                        fontSize: 17,
                        textAlign: TextAlign.right,
                        color: controller.selectedTicketTimeIndex.value == index
                            ? WHITE_COLOR
                            : DARK_GREY_TEXT_COLOR),
                  ),
                  CUSTOM_TEXT(' - ',
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      fontSize: 17,
                      color: controller.selectedTicketTimeIndex.value == index
                          ? WHITE_COLOR
                          : DARK_GREY_TEXT_COLOR),
                  Expanded(
                    child: CUSTOM_TEXT(
                        (ticketTimeModel.endTime ~/ 60 + 7).toString() +
                            ':' +
                            ((ticketTimeModel.endTime % 60) == 0
                                ? '00'
                                : '30') +
                            ((ticketTimeModel.endTime ~/ 60 + 7) <= 12
                                ? ' AM'
                                : ' PM'),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        fontSize: 17,
                        textAlign: TextAlign.left,
                        color: controller.selectedTicketTimeIndex.value == index
                            ? WHITE_COLOR
                            : DARK_GREY_TEXT_COLOR),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
