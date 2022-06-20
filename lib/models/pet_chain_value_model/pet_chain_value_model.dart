import 'package:json_annotation/json_annotation.dart';
import 'package:petapp_mobile/models/pet_chain_value_content_model/pet_chain_value_content_model.dart';

part 'pet_chain_value_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PetChainValueModel {
  final DateTime date;
  final String type;
  final String txId;
  @JsonKey(name: 'content')
  final PetChainValueContentModel petChainValueContentModel;

  PetChainValueModel({
    required this.date,
    required this.type,
    required this.txId,
    required this.petChainValueContentModel,
  });

  factory PetChainValueModel.fromJson(Map<String, dynamic> json) =>
      _$PetChainValueModelFromJson(json);

  Map<String, dynamic> toJson() => _$PetChainValueModelToJson(this);
}
