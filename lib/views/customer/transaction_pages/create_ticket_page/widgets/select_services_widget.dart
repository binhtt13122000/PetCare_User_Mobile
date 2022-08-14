import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/create_ticket_page_controller.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class CreateTicketSelectPetWidget extends GetView<CreateTicketPageController> {
  const CreateTicketSelectPetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Column(
          children: controller.selectPetIndexList
              .map((element) => selectPetServicesWidget(petIndex: element))
              .toList(),
        ),
      );
    });
  }

  Widget showPostButtonWidget({required int petIndex}) => Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 52,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 38,
                ),
                InkWell(
                  onTap: () {
                    controller.selectShowMorePetList.contains(petIndex)
                        ? controller.selectShowMorePetList.remove(petIndex)
                        : controller.selectShowMorePetList.add(petIndex);
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
                      controller.selectShowMorePetList.contains(petIndex)
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

  Widget selectPetServicesWidget({required int petIndex}) => Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              petItemWidget(
                petIndex: petIndex,
              ),
              Obx(
                () => Visibility(
                  visible: controller.selectShowMorePetList.contains(petIndex),
                  child: Column(
                    children: [
                      Column(
                        children: controller.selectServicesMap[petIndex]!
                            .asMap()
                            .entries
                            .map(
                              (element) => Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Column(
                                    children: [
                                      customSeparatorColumn(
                                          size: element.key ==
                                                      controller
                                                              .selectServicesMap[
                                                                  petIndex]!
                                                              .length -
                                                          1 &&
                                                  controller.countServices >= 5
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
                                          index: element.value,
                                          petIndex: petIndex)),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                      Visibility(
                        visible: controller.countServices.value < 5,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 50,
                            ),
                            customSeparatorColumn(
                                size: 4, color: PRIMARY_COLOR),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 22.5,
                                ),
                                customSeparatorRow(
                                    size: 3, color: PRIMARY_COLOR),
                              ],
                            ),
                            addMoreServicesButton(petIndex: petIndex),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          showPostButtonWidget(petIndex: petIndex),
        ],
      );

  // Widget selectPetWidget({required int petIndex}) => Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: [
  //         const SizedBox(
  //           height: 15,
  //         ),
  //         petItemWidget(
  //           petIndex: petIndex,
  //         ),
  //         Row(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             const SizedBox(
  //               width: 50,
  //             ),
  //             Column(
  //               children: [
  //                 customSeparatorColumn(size: 7, color: PRIMARY_COLOR),
  //                 Container(
  //                   height: 4,
  //                   width: 1,
  //                   color: PRIMARY_COLOR,
  //                 ),
  //               ],
  //             ),
  //             Column(
  //               children: [
  //                 const SizedBox(
  //                   height: 22.5,
  //                 ),
  //                 customSeparatorRow(size: 3, color: PRIMARY_COLOR),
  //               ],
  //             ),
  //             SizedBox(width: 260, child: centerServicesItemWidget(index: 1)),
  //           ],
  //         ),
  //         Row(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             const SizedBox(
  //               width: 50,
  //             ),
  //             Column(
  //               children: [
  //                 customSeparatorColumn(size: 7, color: PRIMARY_COLOR),
  //                 Container(
  //                   height: 4,
  //                   width: 1,
  //                   color: PRIMARY_COLOR,
  //                 ),
  //               ],
  //             ),
  //             Column(
  //               children: [
  //                 const SizedBox(
  //                   height: 22.5,
  //                 ),
  //                 customSeparatorRow(size: 3, color: PRIMARY_COLOR),
  //               ],
  //             ),
  //             SizedBox(
  //               width: 260,
  //               child: centerServicesItemWidget(index: 3),
  //             ),
  //           ],
  //         ),
  //         Row(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             const SizedBox(
  //               width: 50,
  //             ),
  //             customSeparatorColumn(size: 4, color: PRIMARY_COLOR),
  //             Column(
  //               children: [
  //                 const SizedBox(
  //                   height: 22.5,
  //                 ),
  //                 customSeparatorRow(size: 3, color: PRIMARY_COLOR),
  //               ],
  //             ),
  //             addMoreServicesButton(petIndex: petIndex),
  //           ],
  //         ),
  //       ],
  //     );

  Widget centerServicesItemWidget({required int index, required int petIndex}) {
    String timeText = '';
    int hours = controller.centerServicesModelList[index].estimatedTime ~/ 60;
    int minutes = controller.centerServicesModelList[index].estimatedTime % 60;

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
                            controller.centerServicesModelList[index].name +
                                (timeText.length > 10 ||
                                        controller
                                                .centerServicesModelList[index]
                                                .name
                                                .length >
                                            20
                                    ? ''
                                    : ' ($timeText)'),
                            color: WHITE_COLOR,
                            textAlign: TextAlign.center,
                          ),
                          Visibility(
                            visible: timeText.length > 10 ||
                                controller.centerServicesModelList[index].name
                                        .length >
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
                Visibility(
                  visible: controller.centerServicesModelList[index].name !=
                      'Check Before Breeding',
                  child: InkWell(
                    onTap: () {
                      controller
                        ..selectServicesMap[petIndex]!.remove(index)
                        //..selectCenterServicesIndexList.remove(index)
                        ..totalEstimateTime -= controller
                            .centerServicesModelList[index].estimatedTime
                        ..countServices.value -= 1;
                      if (controller.countServices.value == 0) {
                        controller.selectedTicketTimeIndex.value = -1;
                      }
                      controller.update();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      color: WHITE_COLOR.withOpacity(0.7),
                      height: 40,
                      child: SvgPicture.asset(
                        ICON_PATH + CLOSE_SVG,
                        color: RED_COLOR,
                        height: 10,
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

  Widget addMoreServicesButton({required int petIndex}) => Padding(
        padding: const EdgeInsets.only(
          top: 7,
        ),
        child: SizedBox(
          width: 260,
          // height: 50,
          child: InkWell(
            onTap: () => controller
              ..isShowAddServices.value = true
              ..selectPetIndex = petIndex,
            child: DottedBorder(
              color: PRIMARY_COLOR.withOpacity(0.7),
              strokeWidth: 1,
              radius: const Radius.circular(5),
              borderType: BorderType.RRect,
              dashPattern: const [5, 5],
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                margin: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: PRIMARY_COLOR.withOpacity(0.05),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CUSTOM_TEXT(
                      'Add Services',
                      color: PRIMARY_COLOR,
                      letterSpacing: 1,
                    ),
                    // const SizedBox(width: 10),
                    // SvgPicture.asset(
                    //   ICON_PATH + ADD_SVG,
                    //   height: 18,
                    //   color: PRIMARY_COLOR,
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  Widget petItemWidget({required int petIndex}) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.only(
            left:
                controller.selectShowMorePetList.contains(petIndex) ? 20 : 28),
        child: Container(
          height: 50,
          width: 300,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              border: Border.all(color: PRIMARY_COLOR),
              color: PRIMARY_LIGHT_COLOR.withOpacity(0.5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(9.8),
                child: Image.network(
                  controller.pets[petIndex].avatar,
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
                    controller.pets[petIndex].name +
                        ' (' +
                        // controller.pets[petIndex].breedModel!.name +
                        // ' - ' +
                        controller
                            .pets[petIndex].breedModel!.speciesModel!.name +
                        ')',
                    textAlign: TextAlign.center,
                    color: PRIMARY_COLOR,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  for (var element in controller.selectServicesMap[petIndex]!) {
                    controller.totalEstimateTime -= controller
                        .centerServicesModelList[element].estimatedTime;
                  }
                  controller
                    ..countServices -=
                        controller.selectServicesMap[petIndex]!.length
                    ..selectPetIndexList.remove(petIndex)
                    ..selectServicesMap.remove(petIndex)
                    ..selectShowMorePetList.remove(petIndex);

                  if (controller.countServices.value == 0) {
                    controller.selectedTicketTimeIndex.value = -1;
                  }
                  controller.update();
                },
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.horizontal(right: Radius.circular(9)),
                  child: Container(
                    width: 23,
                    alignment: Alignment.center,
                    color: RED_COLOR.withOpacity(0.8),
                    child: SvgPicture.asset(
                      ICON_PATH + CLOSE_SVG,
                      color: WHITE_COLOR,
                      height: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
