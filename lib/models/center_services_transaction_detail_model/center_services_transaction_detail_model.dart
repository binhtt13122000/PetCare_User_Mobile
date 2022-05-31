import 'package:json_annotation/json_annotation.dart';
import 'package:petapp_mobile/models/service_model/service_model.dart';

part 'center_services_transaction_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CenterServicesTransactionDetailModel {
  final int id;
  final int price;
  final String? description;
  @JsonKey(name: 'service')
  final ServiceModel? serviceModel;

  CenterServicesTransactionDetailModel({
    required this.id,
    required this.price,
    required this.description,
    this.serviceModel,
  });

  factory CenterServicesTransactionDetailModel.fromJson(
          Map<String, dynamic> json) =>
      _$CenterServicesTransactionDetailModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CenterServicesTransactionDetailModelToJson(this);
}
