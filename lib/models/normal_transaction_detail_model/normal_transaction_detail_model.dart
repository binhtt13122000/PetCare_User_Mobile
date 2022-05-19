import 'package:json_annotation/json_annotation.dart';
import 'package:petapp_mobile/models/service_model/service_model.dart';

part 'normal_transaction_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NormalTransactionDetailModel {
  final int id;
  final int price;
  final String? description;
  @JsonKey(name: 'service')
  final ServiceModel serviceModel;

  NormalTransactionDetailModel({
    required this.id,
    required this.price,
    required this.description,
    required this.serviceModel,
  });

  factory NormalTransactionDetailModel.fromJson(Map<String, dynamic> json) =>
      _$NormalTransactionDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$NormalTransactionDetailModelToJson(this);
}
