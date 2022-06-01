import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/create_post_page_controller.dart';
import 'package:petapp_mobile/services/transaction_fees_services.dart';
import 'package:petapp_mobile/views/customer/create_post_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/create_post_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/create_post_page/widgets/description_widget.dart';
import 'package:petapp_mobile/views/customer/create_post_page/widgets/loading_widget.dart';
import 'package:petapp_mobile/views/customer/create_post_page/widgets/media_picker_widget.dart';
import 'package:petapp_mobile/views/customer/create_post_page/widgets/pet_filter_widget.dart';
import 'package:petapp_mobile/views/customer/create_post_page/widgets/popup_widget.dart';
import 'package:petapp_mobile/views/customer/create_post_page/widgets/sale_transaction_fees.dart';
import 'package:petapp_mobile/views/customer/create_post_page/widgets/select_pet_widget.dart';
import 'package:petapp_mobile/views/customer/create_post_page/widgets/select_branch_widget.dart';
import 'package:petapp_mobile/views/customer/create_post_page/widgets/top_widget.dart';

class CreatePostPage extends GetView<CreatePostPageController> {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.isShowMainLoading.value = true;
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      controller.listPurchaseTransactionFees =
          await TransactionFeesServices.fetchTransactionFreesList(
              transactionType: controller.selectedPostType.value);
      controller.isShowMainLoading.value = false;
    });

    return Obx(
      () => controller.isShowMainLoading.value
          ? Container(
              color: const Color.fromARGB(106, 198, 188, 201),
              alignment: Alignment.center,
              child: const SpinKitSpinningLines(
                color: PRIMARY_COLOR,
                size: 150,
              ),
            )
          : Scaffold(
              backgroundColor: WHITE_COLOR,
              body: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CreatePostTopWidget(),
                      Expanded(
                        child: Scrollbar(
                          controller: controller.mainScrollController,
                          isAlwaysShown: true,
                          child: SingleChildScrollView(
                            controller: controller.mainScrollController,
                            child: Column(
                              children: const [
                                //VideoApp(),
                                CreatePostBodyWidget(),
                                SelectPetWidget(),
                                PetFilterWidget(),
                                MediaPickerWidget(),
                                SelectBranchWidget(),
                                DescriptionWidget(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const CreatePostBottomWidget(),
                    ],
                  ),
                  const CreatePostLoadingWidget(),
                  const CreatePostPopupWidget(),
                  const SaleTransactionFeesWidget(),
                ],
              ),
            ),
    );
  }
}
