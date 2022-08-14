import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/ticket_detail_page_controller.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';
import 'package:petapp_mobile/models/service_ticket_model/service_ticket_model.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class TicketDetailsServicesDetailsWidget
    extends GetView<TicketDetailPageController> {
  const TicketDetailsServicesDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: WHITE_COLOR,
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        children: controller.ticketModel.serviceTicketWithPetModelMap.entries
            .map((element) => petServicesWidget(
                petModel: element.key, serviceTicketModelList: element.value))
            .toList(),
      ),
    );
  }

  Widget showPostButtonWidget({required int petId}) => Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 52,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 43,
                ),
                InkWell(
                  onTap: () {
                    controller.selectShowMorePetList.contains(petId)
                        ? controller.selectShowMorePetList.remove(petId)
                        : controller.selectShowMorePetList.add(petId);
                  },
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      color: WHITE_COLOR,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: PRIMARY_COLOR),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      controller.selectShowMorePetList.contains(petId)
                          ? Icons.arrow_drop_down
                          : Icons.arrow_drop_up,
                      color: PRIMARY_COLOR,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget petServicesWidget(
          {required PetModel petModel,
          required List<ServiceTicketModel> serviceTicketModelList}) =>
      Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              petItemWidget(
                petModel: petModel,
              ),
              Obx(
                () => Visibility(
                  visible:
                      controller.selectShowMorePetList.contains(petModel.id),
                  child: Column(
                    children: [
                      Column(
                        children: serviceTicketModelList
                            .asMap()
                            .entries
                            .map(
                              (element) => Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 55,
                                  ),
                                  Column(
                                    children: [
                                      customSeparatorColumn(
                                          size: element.key ==
                                                  serviceTicketModelList
                                                          .length -
                                                      1
                                              ? 3
                                              : 7,
                                          color: PRIMARY_COLOR),
                                      Container(
                                        height: 4,
                                        width: 1,
                                        color: PRIMARY_COLOR,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const SizedBox(
                                        height: 22.5,
                                      ),
                                      customSeparatorRow(
                                          size: 3, color: PRIMARY_COLOR),
                                    ],
                                  ),
                                  SizedBox(
                                      width: 260,
                                      child: centerServicesItemWidget(
                                        serviceTicketModel: element.value,
                                      )),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          showPostButtonWidget(petId: petModel.id),
        ],
      );

  Widget centerServicesItemWidget(
      {required ServiceTicketModel serviceTicketModel}) {
    String timeText = '';
    int hours = serviceTicketModel.centerServiceModel!.estimatedTime ~/ 60;
    int minutes = serviceTicketModel.centerServiceModel!.estimatedTime % 60;

    if (hours > 0 && minutes > 0) {
      timeText = '$hours hours $minutes minutes';
    } else if (hours > 0) {
      timeText = '$hours hours';
    } else {
      timeText = '$minutes minutes';
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 7),
          child: Container(
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: PRIMARY_COLOR,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CUSTOM_TEXT(
                            serviceTicketModel.centerServiceModel!.name +
                                (timeText.length > 10 ||
                                        serviceTicketModel.centerServiceModel!
                                                .name.length >
                                            20
                                    ? ''
                                    : ' ($timeText)'),
                            color: WHITE_COLOR,
                            textAlign: TextAlign.center,
                          ),
                          Visibility(
                            visible: timeText.length > 10 ||
                                serviceTicketModel
                                        .centerServiceModel!.name.length >
                                    20,
                            child: CUSTOM_TEXT(
                              '($timeText)',
                              color: WHITE_COLOR,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
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
  }

  Widget petItemWidget({required PetModel petModel}) => Obx(
        () => Padding(
          padding: EdgeInsets.only(
              left: controller.selectShowMorePetList.contains(petModel.id)
                  ? 20
                  : 35),
          child: Container(
            height: 50,
            width: 300,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(11),
                ),
                border: Border.all(color: PRIMARY_COLOR),
                color: PRIMARY_LIGHT_COLOR.withOpacity(0.5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(9.8),
                  child: Image.network(
                    petModel.avatar,
                    height: 50,
                    width: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (_, object, stackTrace) => Image.asset(
                      IMAGE_PATH + NO_IMAGE_PNG,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: CUSTOM_TEXT(
                      petModel.name +
                          ' (' +
                          // petModel.breedModel!.name +
                          // ' - ' +
                          petModel.breedModel!.speciesModel!.name +
                          ')',
                      textAlign: TextAlign.center,
                      color: PRIMARY_COLOR,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget customSeparatorColumn({
    required double size,
    required Color color,
  }) {
    List<Widget> separatorColumn = [];
    do {
      separatorColumn.addAll([
        Container(
          height: 4,
          width: 1,
          color: color,
        ),
        Container(
          height: 2,
          color: WHITE_COLOR,
        ),
      ]);
      size--;
    } while (size > 0);
    return Column(
      children: [
        ...[
          Container(
            height: 2,
            color: WHITE_COLOR,
          ),
        ],
        ...separatorColumn
      ],
    );
  }

  Widget customSeparatorRow({
    required double size,
    required Color color,
  }) {
    List<Widget> separatorColumn = [];
    do {
      separatorColumn.addAll([
        Container(
          height: 1,
          width: 4,
          color: color,
        ),
        Container(
          width: 2,
          color: WHITE_COLOR,
        ),
      ]);
      size--;
    } while (size > 0);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: separatorColumn,
    );
  }
}
