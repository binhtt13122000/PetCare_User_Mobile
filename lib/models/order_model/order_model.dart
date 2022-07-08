import 'package:json_annotation/json_annotation.dart';

import 'package:petapp_mobile/models/branch_model/branch_model.dart';
import 'package:petapp_mobile/models/order_detail_model/order_detail_model.dart';
import 'package:petapp_mobile/models/promotion_model.dart/promotion_model.dart';

part 'order_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderModel {
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
  final List<OrderDetailModel>? orderDetailModelList;
  @JsonKey(name: 'promotion')
  final PromotionModel? promotionModel;

  OrderModel({
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
    this.orderDetailModelList,
    required this.branchId,
    this.promotionId,
    required this.customerId,
    required this.registerTime,
    this.promotionModel,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
