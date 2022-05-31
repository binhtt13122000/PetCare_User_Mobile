import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/chat_room_model/chat_room_model.dart';
import 'package:petapp_mobile/models/customer_model/customer_model.dart';
import 'package:petapp_mobile/models/message_model.dart/message_model.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';
import 'package:petapp_mobile/services/chat_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChattingDetailPageController extends GetxController {
  List<File> mediaList = [];
  ChatRoomModel? chatRoomModel;
  late PostModel postModel;
  RxString chatTextValue = ''.obs;
  RxBool isShowCreateRequest = false.obs;
  RxBool isUseOwnerAddress = false.obs;
  AccountModel accountModel = Get.find<AuthController>().accountModel;
  late io.Socket socket;
  ScrollController scrollController = ScrollController();
  late CustomerModel anotherChatRoomMember;
  RxBool showPost = true.obs;
  RxBool isDisplayCalender = false.obs;
  RxString transactionTimeText = ''.obs;
  DateTime? transactionTime;
  RxString transactionLocation = ''.obs;
  RxString description = ''.obs;
  DateTime? tmpTransactionTime;
  final List<MessageModel> messageModelList = [];
  final RxBool isLoadingChat = false.obs;
  final RxBool isLoadingMoreChat = false.obs;
  final limitMessageRange = 10;
  double currentMaxScrollPosition = -1;
  final RxBool isShowBuyerRequest = false.obs;
  bool isJoinedRoom = false;
  TextEditingController transactionLocationTextEditingController =
      TextEditingController();
  TextEditingController descriptionTextEditingController =
      TextEditingController();
  @override
  void onInit() async {
    socket = io.io(
        'http://$API_SERVER_PATH',
        io.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build());
    socket.on('joinedRoom', (data) => print(data));
    socket.on('leftRoom', (data) => print(data));
    socket.on('chatToClient', (data) async {
      MessageModel messageModel = MessageModel.fromJson(data);
      messageModelList.add(messageModel);
      sortListMessage();
      update();
      chatRoomModel =
          await ChatServices.fetchChatRoomById(chatRoomId: messageModel.room!);
      if (!isJoinedRoom) {
        socket.emit('joinRoom', messageModel.room);
        isJoinedRoom = true;
      }
      if (!isShowCreateRequest.value &&
          accountModel.customerModel.id == chatRoomModel!.buyerId) {
        //!location
        transactionLocationTextEditingController.text =
            chatRoomModel!.transactionPlace ?? '';
        transactionLocation.value = chatRoomModel!.transactionPlace ?? '';
        //!time
        transactionTime = chatRoomModel!.transactionTime;
        tmpTransactionTime = transactionTime;
        if (transactionTime != null) {
          transactionTimeText.value = FORMAT_DATE_TIME(
              dateTime: transactionTime!, pattern: DATE_PATTERN_2);
        }
        //!description
        descriptionTextEditingController.text =
            chatRoomModel!.description ?? '';
        description.value = chatRoomModel!.description ?? '';
      } else {
        transactionLocationTextEditingController.text =
            chatRoomModel!.transactionPlace ?? '';
        transactionLocation.value = chatRoomModel!.transactionPlace ?? '';
        //!time
        transactionTime = chatRoomModel!.transactionTime;
        tmpTransactionTime = transactionTime;
        if (transactionTime != null) {
          transactionTimeText.value = FORMAT_DATE_TIME(
              dateTime: transactionTime!, pattern: DATE_PATTERN_2);
        }
        //!descriptio
        descriptionTextEditingController.text =
            chatRoomModel!.description ?? '';
        description.value = chatRoomModel!.description ?? '';
      }
      update();
    });
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
              scrollController.position.minScrollExtent &&
          isLoadingMoreChat.value == false &&
          chatRoomModel != null) {
        isLoadingMoreChat.value = true;
        messageModelList.addAll(
          await ChatServices.fetchMessageListByChatRoomId(
            chatRoomId: chatRoomModel!.id,
            limit: limitMessageRange,
            skip: messageModelList.length,
          ),
        );
        sortListMessage();
        update();
      }
    });
    super.onInit();
  }

  sortListMessage() {
    messageModelList.sort((a, b) => a.createdTime.compareTo(b.createdTime));
  }
}
