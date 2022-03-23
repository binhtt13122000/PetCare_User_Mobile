import 'package:json_annotation/json_annotation.dart';

part 'media_model.g.dart';

@JsonSerializable()
class MediaModel {
  final int id;
  final String url;

  MediaModel({
    required this.id,
    required this.url,
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) =>
      _$MediaModelFromJson(json);

  Map<String, dynamic> toJson() => _$MediaModelToJson(this);
}