class ChatModel {
  bool isOwnerChat;
  bool isLastChat;
  String chatContent;
  DateTime chatTime;
  
  ChatModel({
    required this.isOwnerChat,
    required this.isLastChat,
    required this.chatContent,
    required this.chatTime,
  });
}
