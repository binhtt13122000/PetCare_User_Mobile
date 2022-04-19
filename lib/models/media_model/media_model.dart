import 'package:json_annotation/json_annotation.dart';

part 'media_model.g.dart';

@JsonSerializable()
class MediaModel {
  final int id;
  final String url;
  final String? type;

  MediaModel({
    required this.id,
    required this.url,
    this.type,
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) =>
      _$MediaModelFromJson(json);

  Map<String, dynamic> toJson() => _$MediaModelToJson(this);
}
