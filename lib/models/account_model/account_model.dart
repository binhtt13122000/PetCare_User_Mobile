import 'package:json_annotation/json_annotation.dart';

part 'account_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AccountModel {
  final int id;
  final String? email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String? address;
  final DateTime registerTime;
  final bool isActive;
  final int roleId;
  final DateTime? dob;
  @JsonKey(ignore: true)
  late String jwtToken;

  AccountModel(
      {required this.id,
      this.email,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      this.address,
      required this.registerTime,
      required this.isActive,
      required this.roleId,
      this.dob});

  factory AccountModel.fromJson(Map<String, dynamic> json) =>
      _$AccountModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountModelToJson(this);
}
