import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MessageModel {
  final bool isSellerMessage;
  final String content;
  final String type;
  final DateTime createdTime;
  final String? room;
  final int? buyerId;
  final int? postId;
  final int? sellerId;

  MessageModel({
    required this.isSellerMessage,
    required this.content,
    required this.type,
    required this.createdTime,
    this.room,
    this.buyerId,
    this.postId,
    this.sellerId,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
