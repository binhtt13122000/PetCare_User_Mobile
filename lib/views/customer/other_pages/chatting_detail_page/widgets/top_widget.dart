import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/other_controllers/chatting_detail_page_controller.dart';
import 'package:petapp_mobile/controllers/main_page_controllers/chatting_list_page_controller.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/post_detail_page_controller.dart';
import 'package:petapp_mobile/utilities/utilities.dart';

class ChattingDetailTopWidget extends GetView<ChattingDetailPageController> {
  const ChattingDetailTopWidget({Key? key}) : super(key: key);

  Widget showPostButtonWidget() => Positioned(
        top: 65,
        right: 20,
        child: Obx(
          () => InkWell(
            onTap: () {
              controller.showPost.value = !controller.showPost.value;
            },
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: WHITE_COLOR,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: PRIMARY_COLOR),
              ),
              alignment: Alignment.center,
              child: Icon(
                controller.showPost.value
                    ? Icons.arrow_drop_down
                    : Icons.arrow_drop_up,
                color: PRIMARY_COLOR,
                size: 24,
              ),
            ),
          ),
        ),
      );

  Widget postGeneralInfo() => InkWell(
        onTap: () =>
            Get.toNamed('$POST_DETAIL_PAGE_ROUTE/${controller.postModel.id}'),
        child: Container(
          color: WHITE_COLOR,
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: const Color.fromARGB(255, 76, 85, 117),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            controller.postModel.mediaModels![0].url,
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (_, object, stackTrace) =>
                                Image.asset(
                              IMAGE_PATH + NO_IMAGE_PNG,
                              fit: BoxFit.cover,
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'Pet: ${controller.postModel.petModel!.breedModel!.name} - ${controller.postModel.petModel!.breedModel!.speciesModel!.name}',
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: GoogleFonts.quicksand(
                          color: PRIMARY_COLOR,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Price: ${FORMAT_MONEY(price: controller.postModel.provisionalTotal)}',
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: GoogleFonts.quicksand(
                          color: PRIMARY_COLOR,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: GetBuilder<ChattingDetailPageController>(
                    builder: (_) => chatRoomStatusWidget()),
              ),
              Container(
                height: 1,
                margin: const EdgeInsets.only(top: 5, bottom: 15),
                color: const Color.fromARGB(255, 151, 163, 179),
              ),
            ],
          ),
        ),
      );

  Widget chatRoomStatusWidget() {
    //*Check exist room
    if (controller.chatRoomModel != null) {
      //*Check customer role is buyer or not
      if (controller.accountModel.customerModel.id ==
          controller.chatRoomModel!.buyerId) {
        switch (controller.chatRoomModel!.status) {
          case 'CREATED':
            return controller.chatRoomModel!.transactionId == null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      endChatWidget(),
                      createTransactionRequestButtonWidget(),
                    ],
                  )
                : viewTransactionDetailWidget();
          case 'REQUESTED':
            return viewRequestDetailWidget();
          case 'CLOSED':
            return controller.chatRoomModel!.transactionId != null
                ? viewTransactionDetailWidget()
                : const SizedBox.shrink();
          default:
            return const SizedBox.shrink();
        }
      } else {
        switch (controller.chatRoomModel!.status) {
          case 'CREATED':
            return controller.chatRoomModel!.transactionId == null
                ? const SizedBox.shrink()
                : viewTransactionDetailWidget();
          case 'REQUESTED':
            return viewBuyerTransactionRequestWidget();
          case 'CLOSED':
            return controller.chatRoomModel!.transactionId != null
                ? viewTransactionDetailWidget()
                : const SizedBox.shrink();
          default:
            return const SizedBox.shrink();
        }
      }
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget viewRequestDetailWidget() => InkWell(
        onTap: () => controller.isShowCreateRequest.value = true,
        child: Container(
          height: 35,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 248, 183),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: const Color.fromARGB(255, 255, 243, 139),
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: DARK_GREY_COLOR.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Waiting for seller accept your request - View request detail',
              textAlign: TextAlign.start,
              overflow: TextOverflow.clip,
              style: GoogleFonts.quicksand(
                color: const Color.fromARGB(255, 76, 85, 117),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );

  Widget createTransactionRequestButtonWidget() => InkWell(
        onTap: () => controller.isShowCreateRequest.value = true,
        child: Container(
          height: 35,
          width: 230,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 60, 202, 190),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: const Color.fromARGB(255, 35, 170, 159),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: DARK_GREY_COLOR.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Create transaction request',
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: GoogleFonts.quicksand(
                  color: WHITE_COLOR,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3),
                child: SvgPicture.asset(
                  ICON_PATH + ADD_SVG,
                  height: 16,
                  color: WHITE_COLOR,
                ),
              ),
            ],
          ),
        ),
      );

  Widget viewTransactionDetailWidget() => InkWell(
        onTap: () => Get.toNamed(controller.chatRoomModel!.type == 'SALE'
            ? '$SALE_TRANSACTION_DETAIL_PAGE_ROUTE/${controller.chatRoomModel!.transactionId}'
            : '$BREEDING_TRANSACTION_DETAIL_PAGE_ROUTE/${controller.chatRoomModel!.transactionId}'),
        child: Container(
          height: 35,
          margin: const EdgeInsets.symmetric(horizontal: 25),
          padding: EdgeInsets.symmetric(
              horizontal: controller.accountModel.customerModel.id ==
                      controller.chatRoomModel!.buyerId
                  ? 10
                  : 0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 60, 202, 190),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: const Color.fromARGB(255, 151, 161, 197),
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: DARK_GREY_COLOR.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'View transaction detail',
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: GoogleFonts.quicksand(
                    color: WHITE_COLOR,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1),
              ),
            ],
          ),
        ),
      );

  Widget viewBuyerTransactionRequestWidget() => InkWell(
        onTap: () => controller.isShowBuyerRequest.value = true,
        child: Container(
          height: 35,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 248, 183),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: const Color.fromARGB(255, 255, 243, 139),
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: DARK_GREY_COLOR.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'A buyer transaction request need to approved - View request detail',
              textAlign: TextAlign.start,
              overflow: TextOverflow.clip,
              style: GoogleFonts.quicksand(
                color: const Color.fromARGB(255, 76, 85, 117),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );

  Widget paymentButtonWidget() => InkWell(
        onTap: () {
          // Get.put(PaymentPageController()).postModel = controller.postModel;
          // Get.toNamed(PAYMENT_PAGE_ROUTE);
        },
        child: Container(
          height: 35,
          width: 150,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 55, 134, 224),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: const Color.fromARGB(255, 39, 94, 156),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: DARK_GREY_COLOR.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Payment',
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: GoogleFonts.quicksand(
                  color: WHITE_COLOR,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3),
                child: SvgPicture.asset(
                  ICON_PATH + ADD_SVG,
                  height: 16,
                  color: WHITE_COLOR,
                ),
              ),
            ],
          ),
        ),
      );

  Widget denyRequestWidget() => InkWell(
        onTap: () => Get.back(),
        child: Container(
          height: 35,
          width: 100,
          decoration: BoxDecoration(
            color: WHITE_COLOR,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: const Color.fromARGB(255, 228, 134, 151),
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: DARK_GREY_COLOR.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Denice',
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: GoogleFonts.quicksand(
                  color: const Color.fromARGB(255, 226, 66, 93),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: SvgPicture.asset(
                  ICON_PATH + CLOSE_SVG,
                  height: 12,
                  color: const Color.fromARGB(255, 226, 66, 93),
                ),
              ),
            ],
          ),
        ),
      );

  Widget endChatWidget() => InkWell(
        onTap: () => Get.back(),
        child: Container(
          height: 35,
          width: 100,
          decoration: BoxDecoration(
            color: WHITE_COLOR,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: const Color.fromARGB(255, 228, 134, 151),
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: DARK_GREY_COLOR.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'End chat',
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: GoogleFonts.quicksand(
                  color: const Color.fromARGB(255, 226, 66, 93),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: SvgPicture.asset(
                  ICON_PATH + CLOSE_SVG,
                  height: 12,
                  color: const Color.fromARGB(255, 226, 66, 93),
                ),
              ),
            ],
          ),
        ),
      );

  Widget topTitleWidget() => Container(
        padding:
            const EdgeInsets.only(top: 30, left: 12, right: 12, bottom: 10),
        color: PRIMARY_COLOR,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                controller.chatRoomModel != null
                    ? controller.socket
                        .emit('leaveRoom', controller.chatRoomModel!.id)
                    : null;
                Get
                  ..back()
                  ..put(ChattingListPageController()).update()
                  ..put(PostDetailPageController()).update();
              },
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: WHITE_COLOR,
                  size: 24,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Stack(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      minRadius: 14,
                      maxRadius: 14,
                      backgroundImage: NetworkImage(
                          controller.anotherChatRoomMember.avatar!),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.bottomLeft,
                    child: CircleAvatar(
                      minRadius: 15,
                      maxRadius: 15,
                      backgroundColor: const Color.fromARGB(255, 250, 251, 255),
                      child: CircleAvatar(
                        minRadius: 14,
                        maxRadius: 14,
                        backgroundImage: NetworkImage(
                            controller.accountModel.customerModel.avatar!),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  '[${controller.postModel.type}] Room #${controller.postModel.id}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                    color: WHITE_COLOR,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => Get.back(),
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.call,
                  color: WHITE_COLOR,
                  size: 25,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: InkWell(
                onTap: () => Get.back(),
                child: SvgPicture.asset(
                  ICON_PATH + ELLIPSIS_SVG,
                  height: 18,
                  color: WHITE_COLOR,
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            topTitleWidget(),
            Container(
              height: 1,
              margin: const EdgeInsets.only(bottom: 5),
              color: const Color.fromARGB(255, 151, 163, 179),
            ),
            Obx(
              () => controller.showPost.value
                  ? postGeneralInfo()
                  : const SizedBox(
                      height: 20,
                    ),
            ),
          ],
        ),
        showPostButtonWidget(),
      ],
    );
  }
}
