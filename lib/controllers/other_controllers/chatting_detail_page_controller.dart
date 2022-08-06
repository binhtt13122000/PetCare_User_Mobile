import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/controllers/other_controllers/auth_controller.dart';
import 'package:petapp_mobile/models/account_model/account_model.dart';
import 'package:petapp_mobile/models/chat_room_model/chat_room_model.dart';
import 'package:petapp_mobile/models/customer_model/customer_model.dart';
import 'package:petapp_mobile/models/message_model/message_model.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';
import 'package:petapp_mobile/services/other_services/chat_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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
  RxBool isShowCalendar = false.obs;
  RxString transactionTimeText = ''.obs;
  RxString tmpTransactionTimeText = ''.obs;
  DateTime? transactionTime;
  RxString transactionLocation = ''.obs;
  RxString description = ''.obs;
  DateTime? tmpTransactionTime;
  RxList<MessageModel> messageModelList = <MessageModel>[].obs;
  final RxBool isLoadingChat = false.obs;
  bool isLoadingMoreChat = false;
  final limitMessageRange = 15;
  final RxBool isShowBuyerRequest = false.obs;
  bool isJoinedRoom = false;
  RxBool isShowLoadingPet = false.obs;
  List<PetModel> pets = [];
  RxInt selectedPetIndex = (-1).obs;
  RxBool isShowPetDropdownList = false.obs;
  late PetModel femalePet;
  RxBool isShowSuccessNotificationPopup = false.obs;
  RxBool isShowFailedNotificationPopup = false.obs;
  RxBool isWaitLoadingData = false.obs;
  String? chatRoomId;
  String? sellerId;
  String? postId;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

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
    socket.on('joinedRoom', (data) {});
    socket.on('leftRoom', (data) {});
    socket.on('chatToClient', (data) async {
      MessageModel messageModel = MessageModel.fromJson(data);
      messageModelList.add(messageModel);
      sortListMessage();
      update();
      chatRoomModel = await ChatServices.fetchChatRoomById(
        chatRoomId: messageModel.room!,
        jwt: accountModel.jwtToken,
      );
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
        //!description
        descriptionTextEditingController.text =
            chatRoomModel!.description ?? '';
        description.value = chatRoomModel!.description ?? '';
      }
      update();
    });
    // scrollController.addListener(() async {
    //   if (scrollController.position.pixels ==
    //           scrollController.position.minScrollExtent &&
    //       isLoadingMoreChat.value == false &&
    //       chatRoomModel != null) {
    //     isLoadingMoreChat.value = true;
    //     messageModelList.addAll(
    //       await ChatServices.fetchMessageListByChatRoomId(
    //         chatRoomId: chatRoomModel!.id,
    //         limit: limitMessageRange,
    //         skip: messageModelList.length,
    //       ),
    //     );
    //     sortListMessage();
    //     update();
    //   }
    // });
    super.onInit();
  }

  sortListMessage() {
    messageModelList.sort((a, b) => a.createdTime.compareTo(b.createdTime));
  }
}
