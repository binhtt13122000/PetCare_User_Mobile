import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/main_page_controllers/home_page_controller.dart';
import 'package:petapp_mobile/models/services_model/services_model.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeTitleWidget extends GetView<HomePageController> {
  const HomeTitleWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(
          bottom: 20,
        ),
        child: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          children: controller.services
              .asMap()
              .entries
              .map(
                (e) => serviceItemWidget(
                    service: e.value,
                    onTap: () async {
                      if (e.value.name == 'Combo') {
                        Get.toNamed(BUY_SERVICES_COMBO_PAGE_ROUTE);
                      } else if (e.value.name == 'Scan QR') {
                        String url = await FlutterBarcodeScanner.scanBarcode(
                            "#FFA337f4", "Cancel", false, ScanMode.QR);
                        await launchUrl(Uri.parse(url),
                            mode: LaunchMode.externalApplication);
                      } else {
                        controller.selectedServiceIndex.value = e.value.id;
                      }
                    }),
              )
              .toList(),
        ),
      );

  Widget serviceItemWidget(
          {required ServiceModel service, Function()? onTap}) =>
      InkWell(
        onTap: onTap,
        child: Obx(
          () => SizedBox(
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      controller.selectedServiceIndex.value == service.id
                          ? Container(
                              height: 56,
                              width: 56,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [
                                  Color.fromARGB(255, 114, 35, 241),
                                  Color.fromARGB(255, 6, 231, 231),
                                ]),
                                borderRadius: BorderRadius.circular(17),
                              ),
                            )
                          : Container(
                              height: 52.5,
                              width: 52.5,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 204, 216, 235),
                                borderRadius: BorderRadius.circular(17),
                              ),
                            ),
                      Container(
                        height:
                            controller.selectedServiceIndex.value == service.id
                                ? 56
                                : 52.5,
                        width:
                            controller.selectedServiceIndex.value == service.id
                                ? 56
                                : 52.5,
                        alignment: Alignment.center,
                        child: Container(
                          height: controller.selectedServiceIndex.value ==
                                  service.id
                              ? 53
                              : 50,
                          width: controller.selectedServiceIndex.value ==
                                  service.id
                              ? 53
                              : 50,
                          decoration: BoxDecoration(
                            color: controller.selectedServiceIndex.value ==
                                    service.id
                                ? PRIMARY_COLOR.withOpacity(0.7)
                                : const Color.fromARGB(255, 255, 255, 255),

                            // gradient: const LinearGradient(colors: [
                            //   Color.fromARGB(255, 123, 41, 255),
                            //   Color.fromARGB(255, 90, 253, 253),
                            // ]),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: controller.selectedServiceIndex.value ==
                                        service.id
                                    ? Colors.transparent
                                    : PRIMARY_COLOR.withOpacity(0.7),
                                blurRadius: 2,
                              )
                            ],
                            border: Border.all(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Image.asset(
                              service.imageUrl,
                              height: 33,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                controller.selectedServiceIndex.value == service.id
                    ? GRADIENT_WIDGET(
                        child: Text(
                          service.name,
                          style: GoogleFonts.quicksand(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                          ),
                        ),
                        gradient: const LinearGradient(colors: [
                          Color.fromARGB(255, 123, 41, 255),
                          Color.fromARGB(255, 2, 185, 185),
                        ]),
                      )
                    : Text(
                        service.name,
                        style: GoogleFonts.quicksand(
                          color: const Color.fromARGB(255, 122, 133, 153),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                        ),
                      )
              ],
            ),
          ),
        ),
      );
}
