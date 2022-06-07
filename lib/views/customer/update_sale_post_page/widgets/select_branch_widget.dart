import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/update_sale_post_page_controller.dart';
import 'package:petapp_mobile/services/branch_services.dart';

class SelectBranchWidget extends GetView<UpdateSalePostPageController> {
  const SelectBranchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Row(
                  children: [
                    Text(
                      'Select branch',
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 78, 98, 124),
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '*',
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w800,
                        color: const Color.fromARGB(255, 241, 99, 88),
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                GetBuilder<UpdateSalePostPageController>(
                  builder: (_) {
                    controller.isLoadingBranch.value = true;
                    WidgetsBinding.instance!.addPostFrameCallback((_) async {
                      controller.branchList =
                          await BranchServices.fetchListBranch();
                      controller.selectedBranchId.value =
                          controller.branchList[0].id;
                      controller.isLoadingBranch.value = false;
                    });

                    return Obx(
                      () => controller.isLoadingBranch.value
                          ? const SpinKitSpinningLines(
                              color: PRIMARY_COLOR,
                              size: 50,
                            )
                          : DropdownButton<int>(
                              value: controller.selectedBranchId.value,
                              items: controller.branchList
                                  .map((e) => DropdownMenuItem(
                                      value: e.id,
                                      child: Text(
                                        e.name,
                                        style: GoogleFonts.quicksand(
                                          fontWeight: FontWeight.w500,
                                          color: const Color.fromARGB(
                                              255, 78, 98, 124),
                                          fontSize: 16,
                                        ),
                                      )))
                                  .toList(),
                              onChanged: (int? value) {
                                controller.selectedBranchId.value = value!;
                              },
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            margin: const EdgeInsets.only(top: 10),
            color: LIGHT_GREY_COLOR.withOpacity(0.1),
          ),
          Container(
            height: 8,
            color: const Color.fromARGB(255, 247, 248, 250),
          ),
        ],
      ),
    );
  }
}
