import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/create_ticket_page_controller.dart';
import 'package:petapp_mobile/models/center_service_model/center_service_model.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class CreateTicketServicesDetailWidget
    extends GetView<CreateTicketPageController> {
  const CreateTicketServicesDetailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      late CenterServiceModel centerServiceModel;
      String timeText = '';

      if (controller.isShowCenterServices.value) {
        centerServiceModel = controller.selectCenterServiceModel;
        int hours = centerServiceModel.estimatedTime ~/ 60;
        int minutes = centerServiceModel.estimatedTime % 60;

        if (hours > 0 && minutes > 0) {
          timeText = '$hours hours $minutes minutes';
        } else if (hours > 0) {
          timeText = '$hours hours';
        } else {
          timeText = '$minutes minutes';
        }
      }
      return controller.isShowCenterServices.value
          ? InkWell(
              onTap: () => controller.isShowCenterServices.value = false,
              child: Container(
                color: DARK_GREY_TRANSPARENT,
                alignment: Alignment.center,
                child: Container(
                  height: 200,
                  width: 320,
                  decoration: BoxDecoration(
                    color: WHITE_COLOR,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            CUSTOM_TEXT(centerServiceModel.name,
                                color: PRIMARY_COLOR,
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                CUSTOM_TEXT('Service type:   '),
                                CUSTOM_TEXT(centerServiceModel.type),
                              ],
                            ),
                            Row(
                              children: [
                                CUSTOM_TEXT('Estimate time:  '),
                                CUSTOM_TEXT(timeText),
                              ],
                            ),
                            centerServiceModel.centerServiceFeeModelList!
                                        .isNotEmpty &&
                                    centerServiceModel
                                            .centerServiceFeeModelList![0]
                                            .max ==
                                        null
                                ? Row(
                                    children: [
                                      CUSTOM_TEXT('Service price:   '),
                                      Expanded(
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          alignment: Alignment.centerLeft,
                                          child: CUSTOM_TEXT(FORMAT_MONEY(
                                                  price: centerServiceModel
                                                      .centerServiceFeeModelList![
                                                          0]
                                                      .price) +
                                              ' ' +
                                              centerServiceModel.unit),
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      CUSTOM_TEXT('Service unit:     '),
                                      Expanded(
                                        child: FittedBox(
                                          alignment: Alignment.centerLeft,
                                          fit: BoxFit.scaleDown,
                                          child: CUSTOM_TEXT(
                                              centerServiceModel.unit),
                                        ),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      controller.isViewDescription.value
                          ? Html(data: centerServiceModel.description ?? 'N/A')
                          : const SizedBox.shrink(),
                      InkWell(
                        onTap: () => controller.isViewDescription.value =
                            !controller.isViewDescription.value,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  controller.isViewDescription.value
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
                                  controller.isViewDescription.value
                                      ? Icons.keyboard_double_arrow_up_outlined
                                      : Icons
                                          .keyboard_double_arrow_down_outlined,
                                  size: 18,
                                  color: PRIMARY_COLOR,
                                )
                              ],
                            ),
                            Container(
                              height: 1,
                              width: 150,
                              color: PRIMARY_COLOR,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            )
          : const SizedBox.shrink();
    });
  }
}
