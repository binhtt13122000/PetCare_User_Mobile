import 'package:json_annotation/json_annotation.dart';

import 'package:petapp_mobile/models/center_service_model/center_service_model.dart';

part 'center_services_transaction_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CenterServicesTransactionDetailModel {
  final int? id;
  final int price;
  final String? description;
  final int quantity;
  final int totalPrice;
  final int? serviceId;
  final int? petId;
  final DateTime? registerTime;
  final int? petComboId;
  final String? petComboName;
  @JsonKey(name: 'orderId')
  final int? centerServicesTransactionId;
  @JsonKey(name: 'service')
  final CenterServiceModel? centerServiceModel;

  CenterServicesTransactionDetailModel({
    this.id,
    required this.price,
    this.description,
    required this.quantity,
    required this.totalPrice,
    this.serviceId,
    this.petId,
    this.registerTime,
    this.petComboId,
    this.petComboName,
    this.centerServicesTransactionId,
    this.centerServiceModel,
  });

  factory CenterServicesTransactionDetailModel.fromJson(
          Map<String, dynamic> json) =>
      _$CenterServicesTransactionDetailModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CenterServicesTransactionDetailModelToJson(this);
}
