import 'package:json_annotation/json_annotation.dart';

part 'chat_room_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ChatRoomModel {
  @JsonKey(name: '_id')
  final String id;
  final int sellerId;
  final int buyerId;
  final int postId;
  DateTime newestMessageTime;
  String newestMessage;
  bool isSellerMessage;
  final DateTime createdTime;
  String status;
  DateTime? transactionTime;
  String? transactionPlace;
  String? description;
  int? transactionId;
  DateTime? sellerLastViewTime;
  DateTime? buyerLastViewTime;
  final String type;

  ChatRoomModel({
    required this.id,
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
    this.sellerLastViewTime,
    this.buyerLastViewTime,
    required this.type,
  });

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomModelToJson(this);
}
