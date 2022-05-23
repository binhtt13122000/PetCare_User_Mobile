import 'package:json_annotation/json_annotation.dart';

part 'chat_room_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ChatRoomModel {
  @JsonKey(name: '_id')
  final String id;
  final int sellerId;
  final int buyerId;
  final int postId;
  final DateTime newestMessageTime;
  final String newestMessage;
  final bool isSellerMessage;
  final DateTime createdTime;
  final String status;
  final DateTime? transactionTime;
  final String? transactionPlace;
  final String? description;
  final String? transactionId;
  final String? transactionType;

  ChatRoomModel(
      {required this.id,
      required this.sellerId,
      required this.buyerId,
      required this.postId,
      required this.newestMessageTime,
      required this.newestMessage,
      required this.isSellerMessage,
      required this.createdTime,
      required this.status,
      this.transactionTime,
      this.transactionPlace,
      this.description,
      this.transactionId,
      this.transactionType});

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomModelToJson(this);
}
