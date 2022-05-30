import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/sale_post_detail_page_controller.dart';

class PurchasePostDetailImageListWidget
    extends GetView<SalePostDetailPageController> {
  const PurchasePostDetailImageListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();

    return Column(
      children: [
        Row(
          children: [
            previousButtonWidget(scrollController: _scrollController),
            imageListWidget(scrollController: _scrollController),
            nextButtonWidget(scrollController: _scrollController),
          ],
        ),
        Container(
          height: 1,
          color: LIGHT_GREY_COLOR.withOpacity(0.1),
        ),
        Container(
          height: 8,
          color: const Color.fromARGB(255, 247, 248, 250),
        )
      ],
    );
  }

  Widget previousButtonWidget({required ScrollController scrollController}) =>
      Padding(
        padding: const EdgeInsets.only(left: 12),
        child: InkWell(
          onTap: () {
            controller.selectedPetImageIndex.value == 0
                ? controller.selectedPetImageIndex.value =
                    controller.postModel.mediaModels!.length - 1
                : controller.selectedPetImageIndex.value--;

            scrollController.animateTo(
              controller.selectedPetImageIndex.value ==
                      controller.postModel.mediaModels!.length - 1
                  ? scrollController.position.maxScrollExtent
                  : scrollController.position.pixels - 50,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          },
          child: Container(
            height: 35,
            width: 25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: LIGHT_GREY_COLOR.withOpacity(0.05),
            ),
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Color.fromARGB(255, 122, 160, 201),
              size: 20,
            ),
          ),
        ),
      );

  Widget imageListWidget({required ScrollController scrollController}) {
    return GetBuilder<SalePostDetailPageController>(
      builder: (_) => Expanded(
        flex: controller.postModel.mediaModels!.length > 2 ? 1 : 0,
        child: RawScrollbar(
          thumbColor: const Color.fromARGB(255, 187, 209, 233),
          radius: const Radius.circular(10),
          isAlwaysShown: true,
          thickness: 3,
          controller: scrollController,
          child: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: controller.postModel.mediaModels!
                  .asMap()
                  .entries
                  .map(
                    (e) => Obx(
                      () => InkWell(
                        onTap: () =>
                            controller.selectedPetImageIndex.value = e.key,
                        child: Container(
                          height: 85,
                          width: 78,
                          margin: const EdgeInsets.only(
                            left: 12,
                            top: 5,
                            bottom: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(e.value.url),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                              // color: const Color.fromARGB(
                              //     255, 244, 55, 159),
                              color: e.key ==
                                      controller.selectedPetImageIndex.value
                                  ? PRIMARY_COLOR
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget nextButtonWidget({required ScrollController scrollController}) =>
      Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: InkWell(
          onTap: () {
            controller.selectedPetImageIndex.value ==
                    controller.postModel.mediaModels!.length - 1
                ? controller.selectedPetImageIndex.value = 0
                : controller.selectedPetImageIndex.value++;

            scrollController.animateTo(
              controller.selectedPetImageIndex.value == 0
                  ? scrollController.position.minScrollExtent
                  : 50 * (controller.selectedPetImageIndex.value + 1),
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          },
          child: Container(
            height: 35,
            width: 25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: LIGHT_GREY_COLOR.withOpacity(0.05),
            ),
            child: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color.fromARGB(255, 122, 160, 201),
              size: 20,
            ),
          ),
        ),
      );
}
