import 'package:json_annotation/json_annotation.dart';

import 'package:petapp_mobile/models/center_service_model/center_service_model.dart';

part 'pet_combo_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PetComboDetailModel {
  final int id;
  final DateTime workingTime;
  final bool isCompleted;
  final int serviceId;
  final int petComboId;
  final DateTime? realTime;
  final int? priority;
  final int? start;
  final String? review;
  @JsonKey(name: 'service')
  final CenterServiceModel centerServiceModel;
  PetComboDetailModel({
    required this.id,
    required this.workingTime,
    required this.isCompleted,
    required this.serviceId,
    required this.petComboId,
    this.realTime,
    this.priority,
    this.start,
    this.review,
    required this.centerServiceModel,
  });

  factory PetComboDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PetComboDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$PetComboDetailModelToJson(this);
}
