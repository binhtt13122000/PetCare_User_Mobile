import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/home_controller.dart';
import 'package:petapp_mobile/models/services/services.dart';

class PetService extends GetView<HomeController> {
  const PetService({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Wrap(
            spacing: 28,
            children: controller.services
                .asMap()
                .entries
                .map(
                  (e) => ServiceItem(
                    service: e.value,
                    onTap: () =>
                        controller.selectedServiceIndex.value = e.value.id,
                  ),
                )
                .toList(),
          ),
        ),
      );
}

class ServiceItem extends GetView<HomeController> {
  const ServiceItem({
    Key? key,
    required this.service,
    required this.onTap,
  }) : super(key: key);

  final Service service;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Obx(
          () => Column(
            children: [
              Container(
                height: 48,
                width: 49,
                decoration: BoxDecoration(
                  color: controller.selectedServiceIndex.value == service.id
                      ? PRIMARY_COLOR
                      : PRIMARY_LIGHT_COLOR,
                  borderRadius: BorderRadius.circular(15),
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
                style: GoogleFonts.itim(
                  color: controller.selectedServiceIndex.value == service.id
                      ? PRIMARY_COLOR
                      : PRIMARY_MEDIUM_COLOR,
                  fontSize: 15,
                  height: 1.5,
                ),
              )
            ],
          ),
        ),
      );
}
