import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/home_page_controller.dart';
import 'package:petapp_mobile/models/services_model/services_model.dart';

class PetServiceWidget extends GetView<HomePageController> {
  const PetServiceWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 15,
          top: 10,
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
          () => Column(
            children: [
              Container(
                height: 40,
                width: 65,
                decoration: BoxDecoration(
                  color: controller.selectedServiceIndex.value == service.id
                      ? PRIMARY_COLOR
                      : PRIMARY_COLOR.withOpacity(0.155),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: controller.selectedServiceIndex.value == service.id
                          ? PRIMARY_COLOR.withOpacity(0.7)
                          : WHITE_COLOR,
                      offset: const Offset(3, 3),
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: Center(
                  child: Image.asset(
                    service.imageUrl,
                    height: 30,
                  ),
                ),
              ),
              Text(
                service.name,
                style: GoogleFonts.quicksand(
                  color: controller.selectedServiceIndex.value == service.id
                      ? PRIMARY_COLOR
                      : PRIMARY_COLOR.withOpacity(0.6),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                ),
              )
            ],
          ),
        ),
      );
}
