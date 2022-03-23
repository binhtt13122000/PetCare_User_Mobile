import 'package:json_annotation/json_annotation.dart';

import 'package:petapp_mobile/models/media_model/media_model.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';

part 'sale_transaction_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleTransactionModel {
  final int id;
  final String? description;
  final int buyerId;
  final int deposit;
  final int payForSeller;
  DateTime? payForSellerTime;
  DateTime? payFromBuyerTime;
  final String? reasonCancel;
  final int sellerId;
  final int totalPrice;
  final String status;
  final DateTime createTime;
  @JsonKey(name: 'media')
  final List<MediaModel> mediaModelsForBuyer;
  @JsonKey(name: 'mediaBySaletransactionsellercontractid')
  final List<MediaModel> mediaModelsForSeller;
  @JsonKey(name: 'post')
  final PostModel postModel;

  SaleTransactionModel({
    required this.id,
    this.description,
    required this.buyerId,
    required this.deposit,
    required this.payForSeller,
    this.payForSellerTime,
    this.payFromBuyerTime,
    this.reasonCancel,
    required this.sellerId,
    required this.totalPrice,
    required this.status,
    required this.mediaModelsForBuyer,
    required this.postModel,
    required this.createTime,
    required this.mediaModelsForSeller,
  });

  factory SaleTransactionModel.fromJson(Map<String, dynamic> json) =>
      _$SaleTransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SaleTransactionModelToJson(this);
}
