import 'package:json_annotation/json_annotation.dart';
import 'package:petapp_mobile/models/customer_model/customer_model.dart';

part 'account_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AccountModel {
  final int id;
  final String? email;
  final String phoneNumber;
  final int roleId;
  @JsonKey(ignore: true)
  late CustomerModel customerModel;
  @JsonKey(ignore: true)
  late String jwtToken;
  @JsonKey(ignore: true)
  late String refreshToken;

  AccountModel({
    required this.id,
    this.email,
    required this.phoneNumber,
    required this.roleId,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountModelToJson(this);
}
