import 'package:json_annotation/json_annotation.dart';
import 'package:petapp_mobile/models/media_model/media_model.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';

part 'post_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PostModel {
  final int id;
  final DateTime? createTime;
  final int provisionalTotal;
  final String? description;
  final String? status;
  final String? type;
  int? staffId;
  String? reasonCancel;
  DateTime? approveTime;
  DateTime? cancelTime;
  final int sellerReceive;
  @JsonKey(name: 'pet')
  final PetModel? petModel;
  @JsonKey(name: 'media')
  final List<MediaModel>? mediaModels;

  PostModel({
    required this.id,
    required this.createTime,
    required this.provisionalTotal,
    required this.description,
    required this.status,
    required this.type,
    this.petModel,
    required this.mediaModels,
    required this.sellerReceive,
    this.staffId,
    this.reasonCancel,
    this.approveTime,
    this.cancelTime,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
