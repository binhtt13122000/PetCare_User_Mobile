import 'package:json_annotation/json_annotation.dart';
import 'package:petapp_mobile/models/service_model/service_model.dart';

part 'center_services_transaction_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CenterServicesTransactionDetailModel {
  final int id;
  final int price;
  final String? description;
  final int quantity;
  final int totalPrice;
  final int serviceId;

  @JsonKey(name: 'service')
  final ServiceModel serviceModel;

  CenterServicesTransactionDetailModel({
    required this.id,
    required this.price,
    this.description,
    required this.serviceModel,
    required this.quantity,
    required this.serviceId,
    required this.totalPrice,
  });

  factory CenterServicesTransactionDetailModel.fromJson(
          Map<String, dynamic> json) =>
      _$CenterServicesTransactionDetailModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CenterServicesTransactionDetailModelToJson(this);
}
