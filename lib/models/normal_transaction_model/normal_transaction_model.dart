import 'package:json_annotation/json_annotation.dart';
import 'package:petapp_mobile/models/branch_model/branch_model.dart';
import 'package:petapp_mobile/models/normal_transaction_detail_model/normal_transaction_detail_model.dart';

part 'normal_transaction_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NormalTransactionModel {
  final int id;
  final String? description;
  final int orderTotal;
  final int? payment;
  final String? paymentMethod;
  final DateTime? paymentTime;
  final int? point;
  final String status;
  final int provisionalTotal;
  @JsonKey(name: 'branch')
  final BranchModel branchModel;
  @JsonKey(name: 'order_details')
  final List<NormalTransactionDetailModel>? normalTransactionDetailModelList;

  NormalTransactionModel({
    required this.id,
    required this.branchModel,
    required this.description,
    required this.orderTotal,
    required this.payment,
    required this.paymentMethod,
    required this.paymentTime,
    required this.point,
    required this.status,
    required this.provisionalTotal,
    required this.normalTransactionDetailModelList,
  });

  factory NormalTransactionModel.fromJson(Map<String, dynamic> json) =>
      _$NormalTransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$NormalTransactionModelToJson(this);
}
