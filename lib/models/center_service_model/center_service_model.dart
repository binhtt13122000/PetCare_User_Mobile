import 'package:json_annotation/json_annotation.dart';
import 'package:petapp_mobile/models/center_service_fee_model/center_service_fee_model.dart';

part 'center_service_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CenterServiceModel {
  final int id;
  final String name;
  final String? description;
  final String? healthCheckTemplate;
  final bool status;
  final String unit;
  final int estimatedTime;
  @JsonKey(name: 'serviceFees')
  List<CenterServiceFeeModel>? centerServiceFeeModelList;
  @JsonKey(ignore: true)
  late String estimatedTimeText;

  CenterServiceModel({
    required this.id,
    required this.name,
    this.description,
    this.healthCheckTemplate,
    required this.status,
    required this.unit,
    required this.estimatedTime,
    this.centerServiceFeeModelList,
  }) {
    int hours = estimatedTime ~/ 60;
    int minutes = estimatedTime % 60;

    if (hours > 0 && minutes > 0) {
      estimatedTimeText = '$hours hours : $minutes minutes';
    } else if (hours > 0) {
      estimatedTimeText = '$hours hours';
    } else {
      estimatedTimeText = '$minutes minutes';
    }
  }

  factory CenterServiceModel.fromJson(Map<String, dynamic> json) =>
      _$CenterServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$CenterServiceModelToJson(this);
}
