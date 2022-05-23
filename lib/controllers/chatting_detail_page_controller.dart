import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/controllers/sign_in_page_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/chat_room_model/chat_room_model.dart';
import 'package:petapp_mobile/models/customer_model/customer_model.dart';
import 'package:petapp_mobile/models/messasge_model.dart/message_model.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';
import 'package:petapp_mobile/services/chat_services.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class ChattingDetailPageController extends GetxController {
  List<File> mediaList = [];
  ChatRoomModel? chatRoomModel;
  late PostModel postModel;
  RxString chatTextValue = ''.obs;
  RxBool isShowCreateRequest = false.obs;
  RxBool isUseOwnerAddress = false.obs;
  AccountModel accountModel = Get.find<SignInPageController>().accountModel!;
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

  @override
  void onInit() async {
    socket = io.io(
        'http://$API_SERVER',
        io.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build());
    socket.on('joinedRoom', (data) => print(data));
    socket.on('leftRoom', (data) => print(data));
    socket.on('chatToClient', (data) {
      MessageModel messageModel = MessageModel.fromJson(data);
      messageModelList.add(messageModel);
      if (chatRoomModel == null) {
        updateChatRoom(chatRoomId: messageModel.room!);
        socket.emit('joinRoom', messageModel.room);
      }
      sortListMessage();
      update();
    });
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
              scrollController.position.minScrollExtent &&
          isLoadingMoreChat.value == false) {
        isLoadingMoreChat.value = true;
        messageModelList.addAll(await ChatServices.fetchMesageListByChatRoomId(
          chatRoomId: Get.parameters['chatRoomId']!,
          limit: limitMessageRange,
          skip: messageModelList.length,
        ));
        sortListMessage();
        update();
      }
    });
    super.onInit();
  }

  updateChatRoom({required String chatRoomId}) async {
    chatRoomModel =
        await ChatServices.fetchChatRoomById(chatRoomId: chatRoomId);
  }

  sortListMessage() {
    messageModelList.sort((a, b) => a.createdTime.compareTo(b.createdTime));
  }
}
