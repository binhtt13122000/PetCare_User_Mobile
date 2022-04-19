import 'package:json_annotation/json_annotation.dart';
import 'package:petapp_mobile/models/media_model/media_model.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';

part 'post_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PostModel {
  final int id;
  final String? title;
  final DateTime? createTime;
  final DateTime? effectiveTime;
  final int? price;
  final int? deposit;
  final String? description;
  final String? status;
  final String? type;
  @JsonKey(name: 'pet')
  final PetModel? petModel;
  @JsonKey(name: 'media')
  final List<MediaModel>? mediaModels;
  @JsonKey(name: 'mediaByPostheathcheckid')
  final List<MediaModel>? mediaHealthCheckModels;

  PostModel(
      {required this.id,
      required this.title,
      required this.createTime,
      required this.effectiveTime,
      required this.price,
      required this.deposit,
      required this.description,
      required this.status,
      required this.type,
      this.petModel,
      required this.mediaModels,
      required this.mediaHealthCheckModels});

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
