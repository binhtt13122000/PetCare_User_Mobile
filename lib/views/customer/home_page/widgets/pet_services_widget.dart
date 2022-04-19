import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/home_page_controller.dart';
import 'package:petapp_mobile/models/services_model/services_model.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class ListPetServiceWidget extends GetView<HomePageController> {
  const ListPetServiceWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 15,
          bottom: 20,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            spacing: 18,
            children: controller.services
                .asMap()
                .entries
                .map(
                  (e) => serviceItemWidget(
                    service: e.value,
                    onTap: () =>
                        controller.selectedServiceIndex.value = e.value.id,
                  ),
                )
                .toList(),
          ),
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
                                color: LIGHT_GREY_COLOR.withOpacity(0.07),
                                borderRadius: BorderRadius.circular(17),
                                boxShadow: [
                                  BoxShadow(
                                    color: DARK_GREY_COLOR.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: const Offset(5, 5),
                                  )
                                ],
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
                                : const Color.fromARGB(255, 245, 235, 255),
                            // gradient: const LinearGradient(colors: [
                            //   Color.fromARGB(255, 123, 41, 255),
                            //   Color.fromARGB(255, 90, 253, 253),
                            // ]),
                            borderRadius: BorderRadius.circular(15),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: controller.selectedServiceIndex.value ==
                            //             service.id
                            //         ? PRIMARY_COLOR
                            //         : WHITE_COLOR,
                            //     blurRadius: 3.5,
                            //   )
                            // ],
                            border: Border.all(
                              color: const Color.fromARGB(255, 248, 244, 244),
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Image.asset(
                              service.imageUrl,
                              height: 30,
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
                          color: DARK_GREY_COLOR.withOpacity(0.55),
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
