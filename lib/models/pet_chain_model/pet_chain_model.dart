import 'package:json_annotation/json_annotation.dart';
import 'package:petapp_mobile/models/pet_chain_value_model/pet_chain_value_model.dart';

part 'pet_chain_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PetChainModel {
  final String key;
  @JsonKey(name: 'value')
  final List<PetChainValueModel> valueModelList;

  PetChainModel({
    required this.key,
    required this.valueModelList,
  });

  factory PetChainModel.fromJson(Map<String, dynamic> json) =>
      _$PetChainModelFromJson(json);

  Map<String, dynamic> toJson() => _$PetChainModelToJson(this);
}
