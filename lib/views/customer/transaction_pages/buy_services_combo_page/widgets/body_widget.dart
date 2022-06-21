import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/buy_services_combo_page_controller.dart';
import 'package:petapp_mobile/services/pet_services/pet_services.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/buy_services_combo_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/buy_services_combo_page/widgets/list_combo_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/buy_services_combo_page/widgets/select_branch_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/buy_services_combo_page/widgets/select_pet_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/buy_services_combo_page/widgets/select_species_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class BuyServicesComboBodyWidget
    extends GetView<BuyServicesComboPageController> {
  const BuyServicesComboBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          color: SUPPER_LIGHT_BLUE,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      GetBuilder<BuyServicesComboPageController>(builder: (_) {
                        String? petId = Get.parameters['petId'];
                        petId != null
                            ? controller.selectedPetId.value = int.parse(petId)
                            : null;
                        if (controller.isLoadingPet) {
                          controller.isWaitLoadingPet.value = true;
                          WidgetsBinding.instance!
                              .addPostFrameCallback((timeStamp) async {
                            controller
                              // ..petModelList =
                              //     await PetService.fetchPetListToCreatePost(
                              //         customerId: controller
                              //             .accountModel.customerModel.id,
                              //         speciesId: controller
                              //                 .isShowPetFilter.value
                              //             ? controller.selectedSpeciesId.value
                              //             : null)
                              ..petModelList =
                                  await PetService.fetchPetListByCustomerId(
                                controller.accountModel.customerModel.id,
                              )
                              ..selectedPetId.value =
                                  controller.selectedPetId.value == -1 &&
                                          controller.petModelList.isNotEmpty
                                      ? controller.petModelList[0].id
                                      : controller.selectedPetId.value
                              ..isWaitLoadingPet.value = false
                              ..selectedPetGender.value = controller
                                  .petModelList
                                  .firstWhere((element) =>
                                      element.id ==
                                      controller.selectedPetId.value)
                                  .gender
                              ..isLoadingPet = false;
                          });
                        }
                        return Column(
                          children: [
                            Obx(() => controller.isWaitLoadingPet.value
                                ? Container(
                                    color: WHITE_COLOR,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: LOADING_WIDGET(size: 60))
                                : const BuyServicesComboSelectPetWidget()),
                          ],
                        );
                      }),
                      const BuyServicesComboSelectSpeciesWidget(),
                      const BuyServicesComboListComboWidget(),
                      const BuyPetServicesComboSelectBranchWidget(),
                      Container(
                        color: WHITE_COLOR,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 12),
                        child: Row(
                          children: [
                            registerDateTitleWidget(),
                            bookingDateWidget(),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        color: LIGHT_GREY_COLOR.withAlpha(30),
                      ),
                    ],
                  ),
                ),
              ),
              const BuyServicesComboBottomWidget(),
            ],
          ),
        ),
      );

  Widget registerDateTitleWidget() => Row(
        children: [
          CUSTOM_TEXT('Register date'),
          CUSTOM_TEXT(
            '*',
            color: RED_COLOR,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ],
      );

  Widget bookingDateWidget() => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 30),
          child: InkWell(
            onTap: () => controller.isDisplayCalender.value = true,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 167, 181, 201),
                  width: 1.2,
                ),
                borderRadius: BorderRadius.circular(5),
                color: WHITE_COLOR,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Obx(
                        () => CUSTOM_TEXT(
                          controller.registerDateText.value.isNotEmpty
                              ? controller.registerDateText.value
                              : 'dd/MM/yyyy',
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.calendar_month_rounded,
                      color: PRIMARY_COLOR,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
