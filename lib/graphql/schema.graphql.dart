import 'package:json_annotation/json_annotation.dart';
part 'schema.graphql.g.dart';

@JsonSerializable()
class InputBooleanComparisonExp extends JsonSerializable {
  InputBooleanComparisonExp(
      {this.eq,
      this.gt,
      this.gte,
      this.$in,
      this.isNull,
      this.lt,
      this.lte,
      this.neq,
      this.nin});

  @override
  factory InputBooleanComparisonExp.fromJson(Map<String, dynamic> json) =>
      _$InputBooleanComparisonExpFromJson(json);

  @JsonKey(name: '_eq')
  final bool? eq;

  @JsonKey(name: '_gt')
  final bool? gt;

  @JsonKey(name: '_gte')
  final bool? gte;

  @JsonKey(name: '_in')
  final List<bool>? $in;

  @JsonKey(name: '_is_null')
  final bool? isNull;

  @JsonKey(name: '_lt')
  final bool? lt;

  @JsonKey(name: '_lte')
  final bool? lte;

  @JsonKey(name: '_neq')
  final bool? neq;

  @JsonKey(name: '_nin')
  final List<bool>? nin;

  @override
  Map<String, dynamic> toJson() => _$InputBooleanComparisonExpToJson(this);
}

@JsonSerializable()
class InputcategoryAggregateOrderBy extends JsonSerializable {
  InputcategoryAggregateOrderBy(
      {this.avg,
      this.count,
      this.max,
      this.min,
      this.stddev,
      this.stddevPop,
      this.stddevSamp,
      this.sum,
      this.varPop,
      this.varSamp,
      this.variance});

  @override
  factory InputcategoryAggregateOrderBy.fromJson(Map<String, dynamic> json) =>
      _$InputcategoryAggregateOrderByFromJson(json);

  final InputcategoryAvgOrderBy? avg;

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? count;

  final InputcategoryMaxOrderBy? max;

  final InputcategoryMinOrderBy? min;

  final InputcategoryStddevOrderBy? stddev;

  @JsonKey(name: 'stddev_pop')
  final InputcategoryStddevPopOrderBy? stddevPop;

  @JsonKey(name: 'stddev_samp')
  final InputcategoryStddevSampOrderBy? stddevSamp;

  final InputcategorySumOrderBy? sum;

  @JsonKey(name: 'var_pop')
  final InputcategoryVarPopOrderBy? varPop;

  @JsonKey(name: 'var_samp')
  final InputcategoryVarSampOrderBy? varSamp;

  final InputcategoryVarianceOrderBy? variance;

  @override
  Map<String, dynamic> toJson() => _$InputcategoryAggregateOrderByToJson(this);
}

@JsonSerializable()
class InputcategoryArrRelInsertInput extends JsonSerializable {
  InputcategoryArrRelInsertInput({required this.data, this.onConflict});

  @override
  factory InputcategoryArrRelInsertInput.fromJson(Map<String, dynamic> json) =>
      _$InputcategoryArrRelInsertInputFromJson(json);

  final List<InputcategoryInsertInput> data;

  @JsonKey(name: 'on_conflict')
  final InputcategoryOnConflict? onConflict;

  @override
  Map<String, dynamic> toJson() => _$InputcategoryArrRelInsertInputToJson(this);
}

@JsonSerializable()
class InputcategoryAvgOrderBy extends JsonSerializable {
  InputcategoryAvgOrderBy({this.categoryId});

  @override
  factory InputcategoryAvgOrderBy.fromJson(Map<String, dynamic> json) =>
      _$InputcategoryAvgOrderByFromJson(json);

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? categoryId;

  @override
  Map<String, dynamic> toJson() => _$InputcategoryAvgOrderByToJson(this);
}

@JsonSerializable()
class InputcategoryBoolExp extends JsonSerializable {
  InputcategoryBoolExp(
      {this.and,
      this.not,
      this.or,
      this.categoryId,
      this.description,
      this.isActive,
      this.name});

  @override
  factory InputcategoryBoolExp.fromJson(Map<String, dynamic> json) =>
      _$InputcategoryBoolExpFromJson(json);

  @JsonKey(name: '_and')
  final List<InputcategoryBoolExp?>? and;

  @JsonKey(name: '_not')
  final InputcategoryBoolExp? not;

  @JsonKey(name: '_or')
  final List<InputcategoryBoolExp?>? or;

  final InputIntComparisonExp? categoryId;

  final InputStringComparisonExp? description;

  final InputBooleanComparisonExp? isActive;

  final InputStringComparisonExp? name;

  @override
  Map<String, dynamic> toJson() => _$InputcategoryBoolExpToJson(this);
}

@JsonSerializable()
class InputcategoryIncInput extends JsonSerializable {
  InputcategoryIncInput({this.categoryId});

  @override
  factory InputcategoryIncInput.fromJson(Map<String, dynamic> json) =>
      _$InputcategoryIncInputFromJson(json);

  final int? categoryId;

  @override
  Map<String, dynamic> toJson() => _$InputcategoryIncInputToJson(this);
}

@JsonSerializable()
class InputcategoryInsertInput extends JsonSerializable {
  InputcategoryInsertInput(
      {this.categoryId, this.description, this.isActive, this.name});

  @override
  factory InputcategoryInsertInput.fromJson(Map<String, dynamic> json) =>
      _$InputcategoryInsertInputFromJson(json);

  final int? categoryId;

  final String? description;

  final bool? isActive;

  final String? name;

  @override
  Map<String, dynamic> toJson() => _$InputcategoryInsertInputToJson(this);
}

@JsonSerializable()
class InputcategoryMaxOrderBy extends JsonSerializable {
  InputcategoryMaxOrderBy({this.categoryId, this.description, this.name});

  @override
  factory InputcategoryMaxOrderBy.fromJson(Map<String, dynamic> json) =>
      _$InputcategoryMaxOrderByFromJson(json);

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? categoryId;

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? description;

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? name;

  @override
  Map<String, dynamic> toJson() => _$InputcategoryMaxOrderByToJson(this);
}

@JsonSerializable()
class InputcategoryMinOrderBy extends JsonSerializable {
  InputcategoryMinOrderBy({this.categoryId, this.description, this.name});

  @override
  factory InputcategoryMinOrderBy.fromJson(Map<String, dynamic> json) =>
      _$InputcategoryMinOrderByFromJson(json);

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? categoryId;

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? description;

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? name;

  @override
  Map<String, dynamic> toJson() => _$InputcategoryMinOrderByToJson(this);
}

@JsonSerializable()
class InputcategoryObjRelInsertInput extends JsonSerializable {
  InputcategoryObjRelInsertInput({required this.data, this.onConflict});

  @override
  factory InputcategoryObjRelInsertInput.fromJson(Map<String, dynamic> json) =>
      _$InputcategoryObjRelInsertInputFromJson(json);

  final InputcategoryInsertInput data;

  @JsonKey(name: 'on_conflict')
  final InputcategoryOnConflict? onConflict;

  @override
  Map<String, dynamic> toJson() => _$InputcategoryObjRelInsertInputToJson(this);
}

@JsonSerializable()
class InputcategoryOnConflict extends JsonSerializable {
  InputcategoryOnConflict(
      {required this.constraint, required this.updateColumns, this.where});

  @override
  factory InputcategoryOnConflict.fromJson(Map<String, dynamic> json) =>
      _$InputcategoryOnConflictFromJson(json);

  @JsonKey(unknownEnumValue: EnumcategoryConstraint.$unknown)
  final EnumcategoryConstraint constraint;

  @JsonKey(
      name: 'update_columns',
      unknownEnumValue: EnumcategoryUpdateColumn.$unknown)
  final List<EnumcategoryUpdateColumn> updateColumns;

  final InputcategoryBoolExp? where;

  @override
  Map<String, dynamic> toJson() => _$InputcategoryOnConflictToJson(this);
}

@JsonSerializable()
class InputcategoryOrderBy extends JsonSerializable {
  InputcategoryOrderBy(
      {this.categoryId, this.description, this.isActive, this.name});

  @override
  factory InputcategoryOrderBy.fromJson(Map<String, dynamic> json) =>
      _$InputcategoryOrderByFromJson(json);

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? categoryId;

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? description;

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? isActive;

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? name;

  @override
  Map<String, dynamic> toJson() => _$InputcategoryOrderByToJson(this);
}

@JsonSerializable()
class InputcategoryPkColumnsInput extends JsonSerializable {
  InputcategoryPkColumnsInput({required this.categoryId});

  @override
  factory InputcategoryPkColumnsInput.fromJson(Map<String, dynamic> json) =>
      _$InputcategoryPkColumnsInputFromJson(json);

  final int categoryId;

  @override
  Map<String, dynamic> toJson() => _$InputcategoryPkColumnsInputToJson(this);
}

@JsonSerializable()
class InputcategorySetInput extends JsonSerializable {
  InputcategorySetInput(
      {this.categoryId, this.description, this.isActive, this.name});

  @override
  factory InputcategorySetInput.fromJson(Map<String, dynamic> json) =>
      _$InputcategorySetInputFromJson(json);

  final int? categoryId;

  final String? description;

  final bool? isActive;

  final String? name;

  @override
  Map<String, dynamic> toJson() => _$InputcategorySetInputToJson(this);
}

@JsonSerializable()
class InputcategoryStddevOrderBy extends JsonSerializable {
  InputcategoryStddevOrderBy({this.categoryId});

  @override
  factory InputcategoryStddevOrderBy.fromJson(Map<String, dynamic> json) =>
      _$InputcategoryStddevOrderByFromJson(json);

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? categoryId;

  @override
  Map<String, dynamic> toJson() => _$InputcategoryStddevOrderByToJson(this);
}

@JsonSerializable()
class InputcategoryStddevPopOrderBy extends JsonSerializable {
  InputcategoryStddevPopOrderBy({this.categoryId});

  @override
  factory InputcategoryStddevPopOrderBy.fromJson(Map<String, dynamic> json) =>
      _$InputcategoryStddevPopOrderByFromJson(json);

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? categoryId;

  @override
  Map<String, dynamic> toJson() => _$InputcategoryStddevPopOrderByToJson(this);
}

@JsonSerializable()
class InputcategoryStddevSampOrderBy extends JsonSerializable {
  InputcategoryStddevSampOrderBy({this.categoryId});

  @override
  factory InputcategoryStddevSampOrderBy.fromJson(Map<String, dynamic> json) =>
      _$InputcategoryStddevSampOrderByFromJson(json);

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? categoryId;

  @override
  Map<String, dynamic> toJson() => _$InputcategoryStddevSampOrderByToJson(this);
}

@JsonSerializable()
class InputcategorySumOrderBy extends JsonSerializable {
  InputcategorySumOrderBy({this.categoryId});

  @override
  factory InputcategorySumOrderBy.fromJson(Map<String, dynamic> json) =>
      _$InputcategorySumOrderByFromJson(json);

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? categoryId;

  @override
  Map<String, dynamic> toJson() => _$InputcategorySumOrderByToJson(this);
}

@JsonSerializable()
class InputcategoryVarPopOrderBy extends JsonSerializable {
  InputcategoryVarPopOrderBy({this.categoryId});

  @override
  factory InputcategoryVarPopOrderBy.fromJson(Map<String, dynamic> json) =>
      _$InputcategoryVarPopOrderByFromJson(json);

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? categoryId;

  @override
  Map<String, dynamic> toJson() => _$InputcategoryVarPopOrderByToJson(this);
}

@JsonSerializable()
class InputcategoryVarSampOrderBy extends JsonSerializable {
  InputcategoryVarSampOrderBy({this.categoryId});

  @override
  factory InputcategoryVarSampOrderBy.fromJson(Map<String, dynamic> json) =>
      _$InputcategoryVarSampOrderByFromJson(json);

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? categoryId;

  @override
  Map<String, dynamic> toJson() => _$InputcategoryVarSampOrderByToJson(this);
}

@JsonSerializable()
class InputcategoryVarianceOrderBy extends JsonSerializable {
  InputcategoryVarianceOrderBy({this.categoryId});

  @override
  factory InputcategoryVarianceOrderBy.fromJson(Map<String, dynamic> json) =>
      _$InputcategoryVarianceOrderByFromJson(json);

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? categoryId;

  @override
  Map<String, dynamic> toJson() => _$InputcategoryVarianceOrderByToJson(this);
}

@JsonSerializable()
class InputIntComparisonExp extends JsonSerializable {
  InputIntComparisonExp(
      {this.eq,
      this.gt,
      this.gte,
      this.$in,
      this.isNull,
      this.lt,
      this.lte,
      this.neq,
      this.nin});

  @override
  factory InputIntComparisonExp.fromJson(Map<String, dynamic> json) =>
      _$InputIntComparisonExpFromJson(json);

  @JsonKey(name: '_eq')
  final int? eq;

  @JsonKey(name: '_gt')
  final int? gt;

  @JsonKey(name: '_gte')
  final int? gte;

  @JsonKey(name: '_in')
  final List<int>? $in;

  @JsonKey(name: '_is_null')
  final bool? isNull;

  @JsonKey(name: '_lt')
  final int? lt;

  @JsonKey(name: '_lte')
  final int? lte;

  @JsonKey(name: '_neq')
  final int? neq;

  @JsonKey(name: '_nin')
  final List<int>? nin;

  @override
  Map<String, dynamic> toJson() => _$InputIntComparisonExpToJson(this);
}

@JsonSerializable()
class InputspiciesAggregateOrderBy extends JsonSerializable {
  InputspiciesAggregateOrderBy(
      {this.avg,
      this.count,
      this.max,
      this.min,
      this.stddev,
      this.stddevPop,
      this.stddevSamp,
      this.sum,
      this.varPop,
      this.varSamp,
      this.variance});

  @override
  factory InputspiciesAggregateOrderBy.fromJson(Map<String, dynamic> json) =>
      _$InputspiciesAggregateOrderByFromJson(json);

  final InputspiciesAvgOrderBy? avg;

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? count;

  final InputspiciesMaxOrderBy? max;

  final InputspiciesMinOrderBy? min;

  final InputspiciesStddevOrderBy? stddev;

  @JsonKey(name: 'stddev_pop')
  final InputspiciesStddevPopOrderBy? stddevPop;

  @JsonKey(name: 'stddev_samp')
  final InputspiciesStddevSampOrderBy? stddevSamp;

  final InputspiciesSumOrderBy? sum;

  @JsonKey(name: 'var_pop')
  final InputspiciesVarPopOrderBy? varPop;

  @JsonKey(name: 'var_samp')
  final InputspiciesVarSampOrderBy? varSamp;

  final InputspiciesVarianceOrderBy? variance;

  @override
  Map<String, dynamic> toJson() => _$InputspiciesAggregateOrderByToJson(this);
}

@JsonSerializable()
class InputspiciesArrRelInsertInput extends JsonSerializable {
  InputspiciesArrRelInsertInput({required this.data, this.onConflict});

  @override
  factory InputspiciesArrRelInsertInput.fromJson(Map<String, dynamic> json) =>
      _$InputspiciesArrRelInsertInputFromJson(json);

  final List<InputspiciesInsertInput> data;

  @JsonKey(name: 'on_conflict')
  final InputspiciesOnConflict? onConflict;

  @override
  Map<String, dynamic> toJson() => _$InputspiciesArrRelInsertInputToJson(this);
}

@JsonSerializable()
class InputspiciesAvgOrderBy extends JsonSerializable {
  InputspiciesAvgOrderBy({this.spiciesId});

  @override
  factory InputspiciesAvgOrderBy.fromJson(Map<String, dynamic> json) =>
      _$InputspiciesAvgOrderByFromJson(json);

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? spiciesId;

  @override
  Map<String, dynamic> toJson() => _$InputspiciesAvgOrderByToJson(this);
}

@JsonSerializable()
class InputspiciesBoolExp extends JsonSerializable {
  InputspiciesBoolExp(
      {this.and,
      this.not,
      this.or,
      this.description,
      this.isActive,
      this.isBreeding,
      this.name,
      this.spiciesId});

  @override
  factory InputspiciesBoolExp.fromJson(Map<String, dynamic> json) =>
      _$InputspiciesBoolExpFromJson(json);

  @JsonKey(name: '_and')
  final List<InputspiciesBoolExp?>? and;

  @JsonKey(name: '_not')
  final InputspiciesBoolExp? not;

  @JsonKey(name: '_or')
  final List<InputspiciesBoolExp?>? or;

  final InputStringComparisonExp? description;

  final InputBooleanComparisonExp? isActive;

  final InputBooleanComparisonExp? isBreeding;

  final InputStringComparisonExp? name;

  final InputIntComparisonExp? spiciesId;

  @override
  Map<String, dynamic> toJson() => _$InputspiciesBoolExpToJson(this);
}

@JsonSerializable()
class InputspiciesIncInput extends JsonSerializable {
  InputspiciesIncInput({this.spiciesId});

  @override
  factory InputspiciesIncInput.fromJson(Map<String, dynamic> json) =>
      _$InputspiciesIncInputFromJson(json);

  final int? spiciesId;

  @override
  Map<String, dynamic> toJson() => _$InputspiciesIncInputToJson(this);
}

@JsonSerializable()
class InputspiciesInsertInput extends JsonSerializable {
  InputspiciesInsertInput(
      {this.description,
      this.isActive,
      this.isBreeding,
      this.name,
      this.spiciesId});

  @override
  factory InputspiciesInsertInput.fromJson(Map<String, dynamic> json) =>
      _$InputspiciesInsertInputFromJson(json);

  final String? description;

  final bool? isActive;

  final bool? isBreeding;

  final String? name;

  final int? spiciesId;

  @override
  Map<String, dynamic> toJson() => _$InputspiciesInsertInputToJson(this);
}

@JsonSerializable()
class InputspiciesMaxOrderBy extends JsonSerializable {
  InputspiciesMaxOrderBy({this.description, this.name, this.spiciesId});

  @override
  factory InputspiciesMaxOrderBy.fromJson(Map<String, dynamic> json) =>
      _$InputspiciesMaxOrderByFromJson(json);

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? description;

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? name;

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? spiciesId;

  @override
  Map<String, dynamic> toJson() => _$InputspiciesMaxOrderByToJson(this);
}

@JsonSerializable()
class InputspiciesMinOrderBy extends JsonSerializable {
  InputspiciesMinOrderBy({this.description, this.name, this.spiciesId});

  @override
  factory InputspiciesMinOrderBy.fromJson(Map<String, dynamic> json) =>
      _$InputspiciesMinOrderByFromJson(json);

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? description;

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? name;

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? spiciesId;

  @override
  Map<String, dynamic> toJson() => _$InputspiciesMinOrderByToJson(this);
}

@JsonSerializable()
class InputspiciesObjRelInsertInput extends JsonSerializable {
  InputspiciesObjRelInsertInput({required this.data, this.onConflict});

  @override
  factory InputspiciesObjRelInsertInput.fromJson(Map<String, dynamic> json) =>
      _$InputspiciesObjRelInsertInputFromJson(json);

  final InputspiciesInsertInput data;

  @JsonKey(name: 'on_conflict')
  final InputspiciesOnConflict? onConflict;

  @override
  Map<String, dynamic> toJson() => _$InputspiciesObjRelInsertInputToJson(this);
}

@JsonSerializable()
class InputspiciesOnConflict extends JsonSerializable {
  InputspiciesOnConflict(
      {required this.constraint, required this.updateColumns, this.where});

  @override
  factory InputspiciesOnConflict.fromJson(Map<String, dynamic> json) =>
      _$InputspiciesOnConflictFromJson(json);

  @JsonKey(unknownEnumValue: EnumspiciesConstraint.$unknown)
  final EnumspiciesConstraint constraint;

  @JsonKey(
      name: 'update_columns',
      unknownEnumValue: EnumspiciesUpdateColumn.$unknown)
  final List<EnumspiciesUpdateColumn> updateColumns;

  final InputspiciesBoolExp? where;

  @override
  Map<String, dynamic> toJson() => _$InputspiciesOnConflictToJson(this);
}

@JsonSerializable()
class InputspiciesOrderBy extends JsonSerializable {
  InputspiciesOrderBy(
      {this.description,
      this.isActive,
      this.isBreeding,
      this.name,
      this.spiciesId});

  @override
  factory InputspiciesOrderBy.fromJson(Map<String, dynamic> json) =>
      _$InputspiciesOrderByFromJson(json);

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? description;

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? isActive;

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? isBreeding;

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? name;

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? spiciesId;

  @override
  Map<String, dynamic> toJson() => _$InputspiciesOrderByToJson(this);
}

@JsonSerializable()
class InputspiciesPkColumnsInput extends JsonSerializable {
  InputspiciesPkColumnsInput({required this.spiciesId});

  @override
  factory InputspiciesPkColumnsInput.fromJson(Map<String, dynamic> json) =>
      _$InputspiciesPkColumnsInputFromJson(json);

  final int spiciesId;

  @override
  Map<String, dynamic> toJson() => _$InputspiciesPkColumnsInputToJson(this);
}

@JsonSerializable()
class InputspiciesSetInput extends JsonSerializable {
  InputspiciesSetInput(
      {this.description,
      this.isActive,
      this.isBreeding,
      this.name,
      this.spiciesId});

  @override
  factory InputspiciesSetInput.fromJson(Map<String, dynamic> json) =>
      _$InputspiciesSetInputFromJson(json);

  final String? description;

  final bool? isActive;

  final bool? isBreeding;

  final String? name;

  final int? spiciesId;

  @override
  Map<String, dynamic> toJson() => _$InputspiciesSetInputToJson(this);
}

@JsonSerializable()
class InputspiciesStddevOrderBy extends JsonSerializable {
  InputspiciesStddevOrderBy({this.spiciesId});

  @override
  factory InputspiciesStddevOrderBy.fromJson(Map<String, dynamic> json) =>
      _$InputspiciesStddevOrderByFromJson(json);

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? spiciesId;

  @override
  Map<String, dynamic> toJson() => _$InputspiciesStddevOrderByToJson(this);
}

@JsonSerializable()
class InputspiciesStddevPopOrderBy extends JsonSerializable {
  InputspiciesStddevPopOrderBy({this.spiciesId});

  @override
  factory InputspiciesStddevPopOrderBy.fromJson(Map<String, dynamic> json) =>
      _$InputspiciesStddevPopOrderByFromJson(json);

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? spiciesId;

  @override
  Map<String, dynamic> toJson() => _$InputspiciesStddevPopOrderByToJson(this);
}

@JsonSerializable()
class InputspiciesStddevSampOrderBy extends JsonSerializable {
  InputspiciesStddevSampOrderBy({this.spiciesId});

  @override
  factory InputspiciesStddevSampOrderBy.fromJson(Map<String, dynamic> json) =>
      _$InputspiciesStddevSampOrderByFromJson(json);

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? spiciesId;

  @override
  Map<String, dynamic> toJson() => _$InputspiciesStddevSampOrderByToJson(this);
}

@JsonSerializable()
class InputspiciesSumOrderBy extends JsonSerializable {
  InputspiciesSumOrderBy({this.spiciesId});

  @override
  factory InputspiciesSumOrderBy.fromJson(Map<String, dynamic> json) =>
      _$InputspiciesSumOrderByFromJson(json);

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? spiciesId;

  @override
  Map<String, dynamic> toJson() => _$InputspiciesSumOrderByToJson(this);
}

@JsonSerializable()
class InputspiciesVarPopOrderBy extends JsonSerializable {
  InputspiciesVarPopOrderBy({this.spiciesId});

  @override
  factory InputspiciesVarPopOrderBy.fromJson(Map<String, dynamic> json) =>
      _$InputspiciesVarPopOrderByFromJson(json);

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? spiciesId;

  @override
  Map<String, dynamic> toJson() => _$InputspiciesVarPopOrderByToJson(this);
}

@JsonSerializable()
class InputspiciesVarSampOrderBy extends JsonSerializable {
  InputspiciesVarSampOrderBy({this.spiciesId});

  @override
  factory InputspiciesVarSampOrderBy.fromJson(Map<String, dynamic> json) =>
      _$InputspiciesVarSampOrderByFromJson(json);

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? spiciesId;

  @override
  Map<String, dynamic> toJson() => _$InputspiciesVarSampOrderByToJson(this);
}

@JsonSerializable()
class InputspiciesVarianceOrderBy extends JsonSerializable {
  InputspiciesVarianceOrderBy({this.spiciesId});

  @override
  factory InputspiciesVarianceOrderBy.fromJson(Map<String, dynamic> json) =>
      _$InputspiciesVarianceOrderByFromJson(json);

  @JsonKey(unknownEnumValue: EnumorderBy.$unknown)
  final EnumorderBy? spiciesId;

  @override
  Map<String, dynamic> toJson() => _$InputspiciesVarianceOrderByToJson(this);
}

@JsonSerializable()
class InputStringComparisonExp extends JsonSerializable {
  InputStringComparisonExp(
      {this.eq,
      this.gt,
      this.gte,
      this.ilike,
      this.$in,
      this.isNull,
      this.like,
      this.lt,
      this.lte,
      this.neq,
      this.nilike,
      this.nin,
      this.nlike,
      this.nsimilar,
      this.similar});

  @override
  factory InputStringComparisonExp.fromJson(Map<String, dynamic> json) =>
      _$InputStringComparisonExpFromJson(json);

  @JsonKey(name: '_eq')
  final String? eq;

  @JsonKey(name: '_gt')
  final String? gt;

  @JsonKey(name: '_gte')
  final String? gte;

  @JsonKey(name: '_ilike')
  final String? ilike;

  @JsonKey(name: '_in')
  final List<String>? $in;

  @JsonKey(name: '_is_null')
  final bool? isNull;

  @JsonKey(name: '_like')
  final String? like;

  @JsonKey(name: '_lt')
  final String? lt;

  @JsonKey(name: '_lte')
  final String? lte;

  @JsonKey(name: '_neq')
  final String? neq;

  @JsonKey(name: '_nilike')
  final String? nilike;

  @JsonKey(name: '_nin')
  final List<String>? nin;

  @JsonKey(name: '_nlike')
  final String? nlike;

  @JsonKey(name: '_nsimilar')
  final String? nsimilar;

  @JsonKey(name: '_similar')
  final String? similar;

  @override
  Map<String, dynamic> toJson() => _$InputStringComparisonExpToJson(this);
}

enum EnumcategoryConstraint {
  @JsonValue('PK_8a300c5ce0f70ed7945e877a537')
  pK8a300c5ce0f70ed7945e877a537,
  $unknown
}
enum EnumcategorySelectColumn {
  @JsonValue('categoryId')
  categoryId,
  @JsonValue('description')
  description,
  @JsonValue('isActive')
  isActive,
  @JsonValue('name')
  name,
  $unknown
}
enum EnumcategoryUpdateColumn {
  @JsonValue('categoryId')
  categoryId,
  @JsonValue('description')
  description,
  @JsonValue('isActive')
  isActive,
  @JsonValue('name')
  name,
  $unknown
}
enum EnumorderBy {
  @JsonValue('asc')
  asc,
  @JsonValue('asc_nulls_first')
  ascNullsFirst,
  @JsonValue('asc_nulls_last')
  ascNullsLast,
  @JsonValue('desc')
  desc,
  @JsonValue('desc_nulls_first')
  descNullsFirst,
  @JsonValue('desc_nulls_last')
  descNullsLast,
  $unknown
}
enum EnumspiciesConstraint {
  @JsonValue('PK_563a9682557cbbf04a2bb6eea6c')
  pK563a9682557cbbf04a2bb6eea6c,
  $unknown
}
enum EnumspiciesSelectColumn {
  @JsonValue('description')
  description,
  @JsonValue('isActive')
  isActive,
  @JsonValue('isBreeding')
  isBreeding,
  @JsonValue('name')
  name,
  @JsonValue('spiciesId')
  spiciesId,
  $unknown
}
enum EnumspiciesUpdateColumn {
  @JsonValue('description')
  description,
  @JsonValue('isActive')
  isActive,
  @JsonValue('isBreeding')
  isBreeding,
  @JsonValue('name')
  name,
  @JsonValue('spiciesId')
  spiciesId,
  $unknown
}
const POSSIBLE_TYPES_MAP = const {};
