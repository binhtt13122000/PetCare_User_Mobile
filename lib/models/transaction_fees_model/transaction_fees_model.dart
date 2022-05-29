import 'package:json_annotation/json_annotation.dart';

part 'transaction_fees_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TransactionFeesModel {
  final int id;
  final int min;
  final int max;
  final int price;
  final String type;

  TransactionFeesModel({
    required this.id,
    required this.min,
    required this.max,
    required this.price,
    required this.type,
  });

  factory TransactionFeesModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionFeesModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionFeesModelToJson(this);
}
