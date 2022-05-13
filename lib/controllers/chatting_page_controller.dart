import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/models/chat_model/chat_model.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';

class ChattingPageController extends GetxController {
  RxString chatTextValue = ''.obs;
  late PostModel postModel;
  RxString requestStatus = 'NOT_SEND'.obs;
  RxBool showPost = true.obs;
  RxBool isDisplayCalender = false.obs;
  RxString transactionTimeText = ''.obs;
  DateTime? transactionTime;
  RxString transactionLocation = ''.obs;
  RxString description = ''.obs;
  DateTime? tmpTransactionTime;
  RxBool isShowCreateRequest = false.obs;
  ScrollController scrollController = ScrollController();
  RxBool isUseOwnerAddress = false.obs;

  List<ChatModel> chatModelsList = [
    ChatModel(
      isOwnerChat: true,
      isLastChat: true,
      chatContent: 'Hello shop.',
      chatTime: DateTime.now(),
    ),
    ChatModel(
      isOwnerChat: false,
      isLastChat: false,
      chatContent: 'Hi, nice to meet you!',
      chatTime: DateTime.now(),
    ),
    ChatModel(
      isOwnerChat: false,
      isLastChat: true,
      chatContent: 'What are you looking for?',
      chatTime: DateTime.now(),
    ),
    ChatModel(
      isOwnerChat: true,
      isLastChat: true,
      chatContent: 'How about British Shorthair cat?',
      chatTime: DateTime.now(),
    ),
    ChatModel(
      isOwnerChat: false,
      isLastChat: true,
      chatContent:
          'The British Shorthair is the pedigreed version of the traditional British domestic cat, with a distinctively stocky body, dense coat, and broad face.',
      chatTime: DateTime.now(),
    ),
  ];
}
