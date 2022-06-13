import 'package:json_annotation/json_annotation.dart';
import 'package:petapp_mobile/models/services_combo_detail_model/services_combo_detail_model.dart';

part 'services_combo_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ServicesComboModel {
  final int id;
  final String name;
  final String? description;
  final String type;
  final bool isActive;
  final int price;
  @JsonKey(name: 'comboServices')
  final List<ServicesComboDetailModel>? petServicesComboDetailModelList;

  ServicesComboModel({
    required this.id,
    required this.name,
    this.description,
    required this.type,
    required this.isActive,
    required this.price,
    this.petServicesComboDetailModelList,
  });

  factory ServicesComboModel.fromJson(Map<String, dynamic> json) =>
      _$ServicesComboModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServicesComboModelToJson(this);
}
