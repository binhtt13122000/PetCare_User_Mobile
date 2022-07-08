import 'package:json_annotation/json_annotation.dart';
import 'package:petapp_mobile/models/breeding_transaction_model/breeding_transaction_model.dart';

import 'package:petapp_mobile/models/center_service_model/center_service_model.dart';
import 'package:petapp_mobile/models/pet_combo_model/pet_combo_model.dart';

part 'order_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderDetailModel {
  final int? id;
  final int? orderId;
  final int? serviceId;
  final String? description;
  final int price;
  final int quantity;
  final int totalPrice;
  final int? petComboId;
  final int? petId;
  final int? breedTransactionId;
  final DateTime? registerTime;
  final String? petComboName;
  @JsonKey(name: 'service')
  final CenterServiceModel? centerServiceModel;
  @JsonKey(name: 'petCombo')
  final PetComboModel? petComboModel;
  @JsonKey(name: 'breedingTransaction')
  final BreedingTransactionModel? breedingTransactionModel;

  OrderDetailModel({
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
    this.orderId,
    this.centerServiceModel,
    this.breedTransactionId,
    this.petComboModel,
    this.breedingTransactionModel,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailModelToJson(this);
}
