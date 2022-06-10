import 'package:json_annotation/json_annotation.dart';

import 'package:petapp_mobile/models/branch_model/branch_model.dart';
import 'package:petapp_mobile/models/center_services_transaction_detail_model/center_services_transaction_detail_model.dart';
import 'package:petapp_mobile/models/promotion_model.dart/promotion_model.dart';

part 'center_services_transaction_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CenterServicesTransactionModel {
  final int id;
  final String? description;
  final int orderTotal;
  final int? payment;
  final String? paymentMethod;
  final DateTime? paymentTime;
  final int? point;
  final String status;
  final int provisionalTotal;
  final int star;
  final String? review;
  final int branchId;
  final int? promotionId;
  final int customerId;
  final DateTime registerTime;
  @JsonKey(name: 'branch')
  final BranchModel? branchModel;
  @JsonKey(name: 'orderDetails')
  final List<CenterServicesTransactionDetailModel>?
      centerServicesTransactionDetailModelList;
  @JsonKey(name: 'promotion')
  final PromotionModel? promotionModel;

  CenterServicesTransactionModel({
    required this.id,
    this.description,
    required this.orderTotal,
    this.payment,
    this.paymentMethod,
    this.paymentTime,
    this.point,
    required this.status,
    required this.provisionalTotal,
    required this.star,
    this.review,
    required this.branchModel,
    this.centerServicesTransactionDetailModelList,
    required this.branchId,
    this.promotionId,
    required this.customerId,
    required this.registerTime,
    this.promotionModel,
  });

  factory CenterServicesTransactionModel.fromJson(Map<String, dynamic> json) =>
      _$CenterServicesTransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$CenterServicesTransactionModelToJson(this);
}
