import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/chatting_detail_page_controller.dart';
import 'package:petapp_mobile/graphql/graphql_config.dart';
import 'package:petapp_mobile/graphql/query_mutation/customer.dart';
import 'package:petapp_mobile/graphql/query_mutation/post.dart';
import 'package:petapp_mobile/models/customer_model/customer_model.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';
import 'package:petapp_mobile/services/chat_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/customer/chatting_detail_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/chatting_detail_page/widgets/bottom_widget.dart';
import 'package:petapp_mobile/views/customer/chatting_detail_page/widgets/buyer_request_widget.dart';
import 'package:petapp_mobile/views/customer/chatting_detail_page/widgets/create_request_widget.dart';
import 'package:petapp_mobile/views/customer/chatting_detail_page/widgets/top_widget.dart';

class ChattingDetailPage extends GetView<ChattingDetailPageController> {
  const ChattingDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.isLoadingChat.value = true;

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      if (Get.parameters['chatRoomId'] != null) {
        controller.chatRoomModel = await ChatServices.fetchChatRoomById(
            chatRoomId: Get.parameters['chatRoomId']!);
        //!location
        controller.transactionLocationTextEditingController.text =
            controller.chatRoomModel!.transactionPlace ?? '';
        controller.transactionLocation.value =
            controller.chatRoomModel!.transactionPlace ?? '';
        //!time
        controller.transactionTime = controller.chatRoomModel!.transactionTime;
        controller.tmpTransactionTime = controller.transactionTime;
        if (controller.transactionTime != null) {
          controller.transactionTimeText.value = FORMAT_DATE_TIME(
              dateTime: controller.transactionTime!, pattern: DATE_PATTERN_2);
        }
        //!description
        controller.descriptionTextEditingController.text =
            controller.chatRoomModel!.description ?? '';
        controller.description.value =
            controller.chatRoomModel!.description ?? '';
        controller.messageModelList
            .addAll(await ChatServices.fetchMessageListByChatRoomId(
          chatRoomId: Get.parameters['chatRoomId']!,
          limit: controller.limitMessageRange,
          skip: controller.messageModelList.length,
        ));
        controller.sortListMessage();

        QueryResult result_1 = await CLIENT_TO_QUERY().query(
          QueryOptions(document: gql(FETCH_CUSTOMER_BY_ID), variables: {
            // '_customerId': chatRoomModel.buyerId ==
            //         controller.accountModel.customerModel.id
            //     ? chatRoomModel.sellerId
            //     : chatRoomModel.buyerId
            '_customerId': controller.chatRoomModel!.buyerId ==
                    controller.accountModel.customerModel.id
                ? controller.chatRoomModel!.sellerId
                : controller.chatRoomModel!.buyerId,
          }),
        );

        QueryResult result_2 = await CLIENT_TO_QUERY().query(
          QueryOptions(
              document: gql(FETCH_PURCHASE_POST_BY_ID),
              variables: {'_postId': controller.chatRoomModel!.postId}),
        );
        if (result_1.data != null) {
          controller.anotherChatRoomMember =
              CustomerModel.fromJson(result_1.data!['customer'][0]);
        }
        if (result_2.data != null) {
          controller.postModel = PostModel.fromJson(result_2.data!['post'][0]);
        }

        if (result_1.data != null && result_2.data != null) {
          controller.socket.emit('joinRoom', controller.chatRoomModel!.id);
          controller.isLoadingChat.value = false;
        }
      } else {
        QueryResult result_1 = await CLIENT_TO_QUERY().query(
          QueryOptions(document: gql(FETCH_CUSTOMER_BY_ID), variables: {
            '_customerId': Get.parameters['sellerId'],
          }),
        );
        QueryResult result_2 = await CLIENT_TO_QUERY().query(
          QueryOptions(
              document: gql(FETCH_PURCHASE_POST_BY_ID),
              variables: {'_postId': Get.parameters['postId']}),
        );

        if (result_1.data != null) {
          controller.anotherChatRoomMember =
              CustomerModel.fromJson(result_1.data!['customer'][0]);
        }
        if (result_2.data != null) {
          controller.postModel = PostModel.fromJson(result_2.data!['post'][0]);
        }

        if (result_1.data != null && result_2.data != null) {
          controller.isLoadingChat.value = false;
        }
      }
    });

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 251, 255),
      body: Obx(
        () => !controller.isLoadingChat.value
            ? Stack(
                children: [
                  Column(
                    children: const [
                      ChattingDetailTopWidget(),
                      ChattingDetailBodyWidget(),
                      ChattingDetailBottomWidget(),
                    ],
                  ),
                  const CreateRequestWidget(),
                  const BuyerRequestWidget(),
                ],
              )
            : Container(
                color: const Color.fromARGB(106, 198, 188, 201),
                alignment: Alignment.center,
                child: const SpinKitSpinningLines(
                  color: PRIMARY_COLOR,
                  size: 150,
                ),
              ),
      ),
    );
  }
}
