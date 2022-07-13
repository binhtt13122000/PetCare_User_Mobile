import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/buy_services_combo_page_controller.dart';
import 'package:petapp_mobile/services/other_services/branch_services.dart';
import 'package:petapp_mobile/services/pet_services/pet_services.dart';
import 'package:petapp_mobile/services/pet_services/species_services.dart';
import 'package:petapp_mobile/services/transaction_services/services_combo_services.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/buy_services_combo_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/buy_services_combo_page/widgets/list_combo_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/buy_services_combo_page/widgets/select_branch_widget.dart';
import 'package:petapp_mobile/views/customer/transaction_pages/buy_services_combo_page/widgets/select_pet_widget.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BuyServicesComboBodyWidget
    extends GetView<BuyServicesComboPageController> {
  const BuyServicesComboBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: Container(
          color: SUPPER_LIGHT_BLUE,
          child: GetBuilder<BuyServicesComboPageController>(builder: (_) {
            controller.isWaitLoadingData.value = true;
            WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
              controller
                ..speciesModelList = await SpeciesService.fetchSpeciesList()
                ..branchModelList = await BranchServices.fetchBranchList()
                ..petServicesComboModelList =
                    await ServicesComboModelServices.fetchServicesComboList()
                ..totalPrice.value =
                    controller.petServicesComboModelList[0].price
                ..isWaitLoadingData.value = false;
            });
            return Obx(
              () => controller.isWaitLoadingData.value
                  ? LOADING_WIDGET()
                  : Column(
                      children: [
                        Expanded(
                          child: SmartRefresher(
                            controller: RefreshController(),
                            onRefresh: () => controller.update(),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  GetBuilder<BuyServicesComboPageController>(
                                      builder: (_) {
                                    if (controller.isLoadingPet) {
                                      controller.isWaitLoadingPet.value = true;
                                      WidgetsBinding.instance!
                                          .addPostFrameCallback(
                                              (timeStamp) async {
                                        controller.petModelList =
                                            await PetService
                                                .fetchPetListByCustomerId(
                                          controller
                                              .accountModel.customerModel.id,
                                        );
                                        if (controller
                                            .petModelList.isNotEmpty) {
                                          int index = 0;
                                          do {
                                            if (controller.initSelectedPetId ==
                                                controller
                                                    .petModelList[index].id) {
                                              controller.selectedPetIndex
                                                  .value = index;
                                              break;
                                            } else if (controller
                                                    .petModelList.length ==
                                                index) {
                                              controller
                                                  .selectedPetIndex.value = -1;
                                              break;
                                            }
                                            index++;
                                          } while (index <
                                              controller.petModelList.length);
                                        }
                                        controller
                                          ..isLoadingPet = false
                                          ..isWaitLoadingPet.value = false;
                                      });
                                    }
                                    return Column(
                                      children: [
                                        Obx(() => controller
                                                .isWaitLoadingPet.value
                                            ? Container(
                                                color: WHITE_COLOR,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5),
                                                child: LOADING_WIDGET(size: 60))
                                            : const BuyServicesComboSelectPetWidget()),
                                      ],
                                    );
                                  }),
                                  Container(
                                    height: 1,
                                    color: LIGHT_GREY_COLOR.withAlpha(30),
                                  ),
                                  Container(
                                    height: 10,
                                    color: SUPPER_LIGHT_BLUE,
                                  ),
                                  //const BuyServicesComboSelectSpeciesWidget(),
                                  const BuyServicesComboListComboWidget(),
                                  Container(
                                    height: 1,
                                    color: LIGHT_GREY_COLOR.withAlpha(30),
                                  ),
                                  Container(
                                    height: 10,
                                    color: SUPPER_LIGHT_BLUE,
                                  ),
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
                                    color: WHITE_COLOR,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    child: Container(
                                      height: 1,
                                      color: LIGHT_GREY_COLOR.withAlpha(30),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                    ),
                                  ),
                                  const BuyPetServicesComboSelectBranchWidget(),
                                  Container(
                                    height: 1,
                                    color: LIGHT_GREY_COLOR.withAlpha(30),
                                  ),
                                  Container(
                                    height: 30,
                                    color: SUPPER_LIGHT_BLUE,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const BuyServicesComboBottomWidget(),
                      ],
                    ),
            );
          }),
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
          padding: const EdgeInsets.only(left: 20),
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
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
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
