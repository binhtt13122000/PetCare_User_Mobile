import 'package:json_annotation/json_annotation.dart';

part 'center_service_fee_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CenterServiceFeeModel {
  final int id;
  final int? mix;
  final int? max;
  final int price;

  CenterServiceFeeModel({
    required this.id,
    this.mix,
    this.max,
    required this.price,
  });

  factory CenterServiceFeeModel.fromJson(Map<String, dynamic> json) =>
      _$CenterServiceFeeModelFromJson(json);

  Map<String, dynamic> toJson() => _$CenterServiceFeeModelToJson(this);
}
