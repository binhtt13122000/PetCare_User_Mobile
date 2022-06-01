import 'package:json_annotation/json_annotation.dart';

part 'promotion_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PromotionModel {
  final int id;
  final String name;
  final int promo;
  final DateTime startTime;
  final DateTime expireTime;
  final String? description;
  final String status;
  final int applyMoney;
  final int maxMoneyPromo;
  final int point;
  final int branchId;

  PromotionModel({
    required this.id,
    required this.name,
    required this.promo,
    required this.startTime,
    required this.expireTime,
    this.description,
    required this.status,
    required this.applyMoney,
    required this.maxMoneyPromo,
    required this.point,
    required this.branchId,
  });

  factory PromotionModel.fromJson(Map<String, dynamic> json) =>
      _$PromotionModelFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionModelToJson(this);
}
