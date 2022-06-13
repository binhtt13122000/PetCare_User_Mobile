import 'package:json_annotation/json_annotation.dart';
import 'package:petapp_mobile/models/center_service_model/center_service_model.dart';

part 'services_combo_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ServicesComboDetailModel {
  final int id;

  final int priority;
  final int nextEvent;
  final bool isActive;
  final int comboId;
  final int serviceId;
  @JsonKey(name: 'service')
  final CenterServiceModel centerServiceModel;

  ServicesComboDetailModel({
    required this.id,
    required this.priority,
    required this.nextEvent,
    required this.isActive,
    required this.comboId,
    required this.serviceId,
    required this.centerServiceModel,
  });

  factory ServicesComboDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ServicesComboDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServicesComboDetailModelToJson(this);
}
