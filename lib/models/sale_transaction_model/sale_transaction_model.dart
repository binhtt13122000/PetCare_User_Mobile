import 'package:json_annotation/json_annotation.dart';

import 'package:petapp_mobile/models/customer_model/customer_model.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';

part 'sale_transaction_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleTransactionModel {
  final DateTime createdTime;
  final String? description;
  final int id;
  final DateTime meetingTime;
  final String? paymentMethod;
  final int petId;
  final String placeMeeting;
  final int postId;
  final String? review;
  final String? reasonCancel;
  final int sellerId;
  final int sellerReceive;
  final int? star;
  final String status;
  final int transactionFee;
  final DateTime? transactionTime;
  final int transactionTotal;
  final int buyerId;
  final int? point;
  final DateTime? cancelTime;
  @JsonKey(name: 'post')
  final PostModel? postModel;
  @JsonKey(name: 'pet')
  final PetModel? petModel;
  @JsonKey(name: 'buyer')
  final CustomerModel buyerCustomerModel;
  @JsonKey(name: 'seller')
  final CustomerModel sellerCustomerModel;
  SaleTransactionModel(
      {required this.createdTime,
      this.description,
      required this.id,
      required this.meetingTime,
      this.paymentMethod,
      required this.petId,
      required this.placeMeeting,
      required this.postId,
      this.review,
      this.reasonCancel,
      required this.sellerId,
      required this.sellerReceive,
      this.star,
      required this.status,
      required this.transactionFee,
      this.transactionTime,
      required this.transactionTotal,
      required this.postModel,
      required this.petModel,
      required this.buyerCustomerModel,
      required this.sellerCustomerModel,
      required this.buyerId,
      this.point,
      this.cancelTime});

  factory SaleTransactionModel.fromJson(Map<String, dynamic> json) =>
      _$SaleTransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SaleTransactionModelToJson(this);
}
