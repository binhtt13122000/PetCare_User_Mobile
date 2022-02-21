// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InputBooleanComparisonExp _$InputBooleanComparisonExpFromJson(
    Map<String, dynamic> json) {
  return InputBooleanComparisonExp(
    eq: json['_eq'] as bool?,
    gt: json['_gt'] as bool?,
    gte: json['_gte'] as bool?,
    $in: (json['_in'] as List<dynamic>?)?.map((e) => e as bool).toList(),
    isNull: json['_is_null'] as bool?,
    lt: json['_lt'] as bool?,
    lte: json['_lte'] as bool?,
    neq: json['_neq'] as bool?,
    nin: (json['_nin'] as List<dynamic>?)?.map((e) => e as bool).toList(),
  );
}

Map<String, dynamic> _$InputBooleanComparisonExpToJson(
        InputBooleanComparisonExp instance) =>
    <String, dynamic>{
      '_eq': instance.eq,
      '_gt': instance.gt,
      '_gte': instance.gte,
      '_in': instance.$in,
      '_is_null': instance.isNull,
      '_lt': instance.lt,
      '_lte': instance.lte,
      '_neq': instance.neq,
      '_nin': instance.nin,
    };

InputcategoryAggregateOrderBy _$InputcategoryAggregateOrderByFromJson(
    Map<String, dynamic> json) {
  return InputcategoryAggregateOrderBy(
    avg: json['avg'] == null
        ? null
        : InputcategoryAvgOrderBy.fromJson(json['avg'] as Map<String, dynamic>),
    count: _$enumDecodeNullable(_$EnumorderByEnumMap, json['count'],
        unknownValue: EnumorderBy.$unknown),
    max: json['max'] == null
        ? null
        : InputcategoryMaxOrderBy.fromJson(json['max'] as Map<String, dynamic>),
    min: json['min'] == null
        ? null
        : InputcategoryMinOrderBy.fromJson(json['min'] as Map<String, dynamic>),
    stddev: json['stddev'] == null
        ? null
        : InputcategoryStddevOrderBy.fromJson(
            json['stddev'] as Map<String, dynamic>),
    stddevPop: json['stddev_pop'] == null
        ? null
        : InputcategoryStddevPopOrderBy.fromJson(
            json['stddev_pop'] as Map<String, dynamic>),
    stddevSamp: json['stddev_samp'] == null
        ? null
        : InputcategoryStddevSampOrderBy.fromJson(
            json['stddev_samp'] as Map<String, dynamic>),
    sum: json['sum'] == null
        ? null
        : InputcategorySumOrderBy.fromJson(json['sum'] as Map<String, dynamic>),
    varPop: json['var_pop'] == null
        ? null
        : InputcategoryVarPopOrderBy.fromJson(
            json['var_pop'] as Map<String, dynamic>),
    varSamp: json['var_samp'] == null
        ? null
        : InputcategoryVarSampOrderBy.fromJson(
            json['var_samp'] as Map<String, dynamic>),
    variance: json['variance'] == null
        ? null
        : InputcategoryVarianceOrderBy.fromJson(
            json['variance'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$InputcategoryAggregateOrderByToJson(
        InputcategoryAggregateOrderBy instance) =>
    <String, dynamic>{
      'avg': instance.avg,
      'count': _$EnumorderByEnumMap[instance.count],
      'max': instance.max,
      'min': instance.min,
      'stddev': instance.stddev,
      'stddev_pop': instance.stddevPop,
      'stddev_samp': instance.stddevSamp,
      'sum': instance.sum,
      'var_pop': instance.varPop,
      'var_samp': instance.varSamp,
      'variance': instance.variance,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$EnumorderByEnumMap = {
  EnumorderBy.asc: 'asc',
  EnumorderBy.ascNullsFirst: 'asc_nulls_first',
  EnumorderBy.ascNullsLast: 'asc_nulls_last',
  EnumorderBy.desc: 'desc',
  EnumorderBy.descNullsFirst: 'desc_nulls_first',
  EnumorderBy.descNullsLast: 'desc_nulls_last',
  EnumorderBy.$unknown: r'$unknown',
};

InputcategoryArrRelInsertInput _$InputcategoryArrRelInsertInputFromJson(
    Map<String, dynamic> json) {
  return InputcategoryArrRelInsertInput(
    data: (json['data'] as List<dynamic>)
        .map(
            (e) => InputcategoryInsertInput.fromJson(e as Map<String, dynamic>))
        .toList(),
    onConflict: json['on_conflict'] == null
        ? null
        : InputcategoryOnConflict.fromJson(
            json['on_conflict'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$InputcategoryArrRelInsertInputToJson(
        InputcategoryArrRelInsertInput instance) =>
    <String, dynamic>{
      'data': instance.data,
      'on_conflict': instance.onConflict,
    };

InputcategoryAvgOrderBy _$InputcategoryAvgOrderByFromJson(
    Map<String, dynamic> json) {
  return InputcategoryAvgOrderBy(
    categoryId: _$enumDecodeNullable(_$EnumorderByEnumMap, json['categoryId'],
        unknownValue: EnumorderBy.$unknown),
  );
}

Map<String, dynamic> _$InputcategoryAvgOrderByToJson(
        InputcategoryAvgOrderBy instance) =>
    <String, dynamic>{
      'categoryId': _$EnumorderByEnumMap[instance.categoryId],
    };

InputcategoryBoolExp _$InputcategoryBoolExpFromJson(Map<String, dynamic> json) {
  return InputcategoryBoolExp(
    and: (json['_and'] as List<dynamic>?)
        ?.map((e) => e == null
            ? null
            : InputcategoryBoolExp.fromJson(e as Map<String, dynamic>))
        .toList(),
    not: json['_not'] == null
        ? null
        : InputcategoryBoolExp.fromJson(json['_not'] as Map<String, dynamic>),
    or: (json['_or'] as List<dynamic>?)
        ?.map((e) => e == null
            ? null
            : InputcategoryBoolExp.fromJson(e as Map<String, dynamic>))
        .toList(),
    categoryId: json['categoryId'] == null
        ? null
        : InputIntComparisonExp.fromJson(
            json['categoryId'] as Map<String, dynamic>),
    description: json['description'] == null
        ? null
        : InputStringComparisonExp.fromJson(
            json['description'] as Map<String, dynamic>),
    isActive: json['isActive'] == null
        ? null
        : InputBooleanComparisonExp.fromJson(
            json['isActive'] as Map<String, dynamic>),
    name: json['name'] == null
        ? null
        : InputStringComparisonExp.fromJson(
            json['name'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$InputcategoryBoolExpToJson(
        InputcategoryBoolExp instance) =>
    <String, dynamic>{
      '_and': instance.and,
      '_not': instance.not,
      '_or': instance.or,
      'categoryId': instance.categoryId,
      'description': instance.description,
      'isActive': instance.isActive,
      'name': instance.name,
    };

InputcategoryIncInput _$InputcategoryIncInputFromJson(
    Map<String, dynamic> json) {
  return InputcategoryIncInput(
    categoryId: json['categoryId'] as int?,
  );
}

Map<String, dynamic> _$InputcategoryIncInputToJson(
        InputcategoryIncInput instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
    };

InputcategoryInsertInput _$InputcategoryInsertInputFromJson(
    Map<String, dynamic> json) {
  return InputcategoryInsertInput(
    categoryId: json['categoryId'] as int?,
    description: json['description'] as String?,
    isActive: json['isActive'] as bool?,
    name: json['name'] as String?,
  );
}

Map<String, dynamic> _$InputcategoryInsertInputToJson(
        InputcategoryInsertInput instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'description': instance.description,
      'isActive': instance.isActive,
      'name': instance.name,
    };

InputcategoryMaxOrderBy _$InputcategoryMaxOrderByFromJson(
    Map<String, dynamic> json) {
  return InputcategoryMaxOrderBy(
    categoryId: _$enumDecodeNullable(_$EnumorderByEnumMap, json['categoryId'],
        unknownValue: EnumorderBy.$unknown),
    description: _$enumDecodeNullable(_$EnumorderByEnumMap, json['description'],
        unknownValue: EnumorderBy.$unknown),
    name: _$enumDecodeNullable(_$EnumorderByEnumMap, json['name'],
        unknownValue: EnumorderBy.$unknown),
  );
}

Map<String, dynamic> _$InputcategoryMaxOrderByToJson(
        InputcategoryMaxOrderBy instance) =>
    <String, dynamic>{
      'categoryId': _$EnumorderByEnumMap[instance.categoryId],
      'description': _$EnumorderByEnumMap[instance.description],
      'name': _$EnumorderByEnumMap[instance.name],
    };

InputcategoryMinOrderBy _$InputcategoryMinOrderByFromJson(
    Map<String, dynamic> json) {
  return InputcategoryMinOrderBy(
    categoryId: _$enumDecodeNullable(_$EnumorderByEnumMap, json['categoryId'],
        unknownValue: EnumorderBy.$unknown),
    description: _$enumDecodeNullable(_$EnumorderByEnumMap, json['description'],
        unknownValue: EnumorderBy.$unknown),
    name: _$enumDecodeNullable(_$EnumorderByEnumMap, json['name'],
        unknownValue: EnumorderBy.$unknown),
  );
}

Map<String, dynamic> _$InputcategoryMinOrderByToJson(
        InputcategoryMinOrderBy instance) =>
    <String, dynamic>{
      'categoryId': _$EnumorderByEnumMap[instance.categoryId],
      'description': _$EnumorderByEnumMap[instance.description],
      'name': _$EnumorderByEnumMap[instance.name],
    };

InputcategoryObjRelInsertInput _$InputcategoryObjRelInsertInputFromJson(
    Map<String, dynamic> json) {
  return InputcategoryObjRelInsertInput(
    data:
        InputcategoryInsertInput.fromJson(json['data'] as Map<String, dynamic>),
    onConflict: json['on_conflict'] == null
        ? null
        : InputcategoryOnConflict.fromJson(
            json['on_conflict'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$InputcategoryObjRelInsertInputToJson(
        InputcategoryObjRelInsertInput instance) =>
    <String, dynamic>{
      'data': instance.data,
      'on_conflict': instance.onConflict,
    };

InputcategoryOnConflict _$InputcategoryOnConflictFromJson(
    Map<String, dynamic> json) {
  return InputcategoryOnConflict(
    constraint: _$enumDecode(
        _$EnumcategoryConstraintEnumMap, json['constraint'],
        unknownValue: EnumcategoryConstraint.$unknown),
    updateColumns: (json['update_columns'] as List<dynamic>)
        .map((e) => _$enumDecode(_$EnumcategoryUpdateColumnEnumMap, e,
            unknownValue: EnumcategoryUpdateColumn.$unknown))
        .toList(),
    where: json['where'] == null
        ? null
        : InputcategoryBoolExp.fromJson(json['where'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$InputcategoryOnConflictToJson(
        InputcategoryOnConflict instance) =>
    <String, dynamic>{
      'constraint': _$EnumcategoryConstraintEnumMap[instance.constraint],
      'update_columns': instance.updateColumns
          .map((e) => _$EnumcategoryUpdateColumnEnumMap[e])
          .toList(),
      'where': instance.where,
    };

const _$EnumcategoryConstraintEnumMap = {
  EnumcategoryConstraint.pK8a300c5ce0f70ed7945e877a537:
      'PK_8a300c5ce0f70ed7945e877a537',
  EnumcategoryConstraint.$unknown: r'$unknown',
};

const _$EnumcategoryUpdateColumnEnumMap = {
  EnumcategoryUpdateColumn.categoryId: 'categoryId',
  EnumcategoryUpdateColumn.description: 'description',
  EnumcategoryUpdateColumn.isActive: 'isActive',
  EnumcategoryUpdateColumn.name: 'name',
  EnumcategoryUpdateColumn.$unknown: r'$unknown',
};

InputcategoryOrderBy _$InputcategoryOrderByFromJson(Map<String, dynamic> json) {
  return InputcategoryOrderBy(
    categoryId: _$enumDecodeNullable(_$EnumorderByEnumMap, json['categoryId'],
        unknownValue: EnumorderBy.$unknown),
    description: _$enumDecodeNullable(_$EnumorderByEnumMap, json['description'],
        unknownValue: EnumorderBy.$unknown),
    isActive: _$enumDecodeNullable(_$EnumorderByEnumMap, json['isActive'],
        unknownValue: EnumorderBy.$unknown),
    name: _$enumDecodeNullable(_$EnumorderByEnumMap, json['name'],
        unknownValue: EnumorderBy.$unknown),
  );
}

Map<String, dynamic> _$InputcategoryOrderByToJson(
        InputcategoryOrderBy instance) =>
    <String, dynamic>{
      'categoryId': _$EnumorderByEnumMap[instance.categoryId],
      'description': _$EnumorderByEnumMap[instance.description],
      'isActive': _$EnumorderByEnumMap[instance.isActive],
      'name': _$EnumorderByEnumMap[instance.name],
    };

InputcategoryPkColumnsInput _$InputcategoryPkColumnsInputFromJson(
    Map<String, dynamic> json) {
  return InputcategoryPkColumnsInput(
    categoryId: json['categoryId'] as int,
  );
}

Map<String, dynamic> _$InputcategoryPkColumnsInputToJson(
        InputcategoryPkColumnsInput instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
    };

InputcategorySetInput _$InputcategorySetInputFromJson(
    Map<String, dynamic> json) {
  return InputcategorySetInput(
    categoryId: json['categoryId'] as int?,
    description: json['description'] as String?,
    isActive: json['isActive'] as bool?,
    name: json['name'] as String?,
  );
}

Map<String, dynamic> _$InputcategorySetInputToJson(
        InputcategorySetInput instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'description': instance.description,
      'isActive': instance.isActive,
      'name': instance.name,
    };

InputcategoryStddevOrderBy _$InputcategoryStddevOrderByFromJson(
    Map<String, dynamic> json) {
  return InputcategoryStddevOrderBy(
    categoryId: _$enumDecodeNullable(_$EnumorderByEnumMap, json['categoryId'],
        unknownValue: EnumorderBy.$unknown),
  );
}

Map<String, dynamic> _$InputcategoryStddevOrderByToJson(
        InputcategoryStddevOrderBy instance) =>
    <String, dynamic>{
      'categoryId': _$EnumorderByEnumMap[instance.categoryId],
    };

InputcategoryStddevPopOrderBy _$InputcategoryStddevPopOrderByFromJson(
    Map<String, dynamic> json) {
  return InputcategoryStddevPopOrderBy(
    categoryId: _$enumDecodeNullable(_$EnumorderByEnumMap, json['categoryId'],
        unknownValue: EnumorderBy.$unknown),
  );
}

Map<String, dynamic> _$InputcategoryStddevPopOrderByToJson(
        InputcategoryStddevPopOrderBy instance) =>
    <String, dynamic>{
      'categoryId': _$EnumorderByEnumMap[instance.categoryId],
    };

InputcategoryStddevSampOrderBy _$InputcategoryStddevSampOrderByFromJson(
    Map<String, dynamic> json) {
  return InputcategoryStddevSampOrderBy(
    categoryId: _$enumDecodeNullable(_$EnumorderByEnumMap, json['categoryId'],
        unknownValue: EnumorderBy.$unknown),
  );
}

Map<String, dynamic> _$InputcategoryStddevSampOrderByToJson(
        InputcategoryStddevSampOrderBy instance) =>
    <String, dynamic>{
      'categoryId': _$EnumorderByEnumMap[instance.categoryId],
    };

InputcategorySumOrderBy _$InputcategorySumOrderByFromJson(
    Map<String, dynamic> json) {
  return InputcategorySumOrderBy(
    categoryId: _$enumDecodeNullable(_$EnumorderByEnumMap, json['categoryId'],
        unknownValue: EnumorderBy.$unknown),
  );
}

Map<String, dynamic> _$InputcategorySumOrderByToJson(
        InputcategorySumOrderBy instance) =>
    <String, dynamic>{
      'categoryId': _$EnumorderByEnumMap[instance.categoryId],
    };

InputcategoryVarPopOrderBy _$InputcategoryVarPopOrderByFromJson(
    Map<String, dynamic> json) {
  return InputcategoryVarPopOrderBy(
    categoryId: _$enumDecodeNullable(_$EnumorderByEnumMap, json['categoryId'],
        unknownValue: EnumorderBy.$unknown),
  );
}

Map<String, dynamic> _$InputcategoryVarPopOrderByToJson(
        InputcategoryVarPopOrderBy instance) =>
    <String, dynamic>{
      'categoryId': _$EnumorderByEnumMap[instance.categoryId],
    };

InputcategoryVarSampOrderBy _$InputcategoryVarSampOrderByFromJson(
    Map<String, dynamic> json) {
  return InputcategoryVarSampOrderBy(
    categoryId: _$enumDecodeNullable(_$EnumorderByEnumMap, json['categoryId'],
        unknownValue: EnumorderBy.$unknown),
  );
}

Map<String, dynamic> _$InputcategoryVarSampOrderByToJson(
        InputcategoryVarSampOrderBy instance) =>
    <String, dynamic>{
      'categoryId': _$EnumorderByEnumMap[instance.categoryId],
    };

InputcategoryVarianceOrderBy _$InputcategoryVarianceOrderByFromJson(
    Map<String, dynamic> json) {
  return InputcategoryVarianceOrderBy(
    categoryId: _$enumDecodeNullable(_$EnumorderByEnumMap, json['categoryId'],
        unknownValue: EnumorderBy.$unknown),
  );
}

Map<String, dynamic> _$InputcategoryVarianceOrderByToJson(
        InputcategoryVarianceOrderBy instance) =>
    <String, dynamic>{
      'categoryId': _$EnumorderByEnumMap[instance.categoryId],
    };

InputIntComparisonExp _$InputIntComparisonExpFromJson(
    Map<String, dynamic> json) {
  return InputIntComparisonExp(
    eq: json['_eq'] as int?,
    gt: json['_gt'] as int?,
    gte: json['_gte'] as int?,
    $in: (json['_in'] as List<dynamic>?)?.map((e) => e as int).toList(),
    isNull: json['_is_null'] as bool?,
    lt: json['_lt'] as int?,
    lte: json['_lte'] as int?,
    neq: json['_neq'] as int?,
    nin: (json['_nin'] as List<dynamic>?)?.map((e) => e as int).toList(),
  );
}

Map<String, dynamic> _$InputIntComparisonExpToJson(
        InputIntComparisonExp instance) =>
    <String, dynamic>{
      '_eq': instance.eq,
      '_gt': instance.gt,
      '_gte': instance.gte,
      '_in': instance.$in,
      '_is_null': instance.isNull,
      '_lt': instance.lt,
      '_lte': instance.lte,
      '_neq': instance.neq,
      '_nin': instance.nin,
    };

InputspiciesAggregateOrderBy _$InputspiciesAggregateOrderByFromJson(
    Map<String, dynamic> json) {
  return InputspiciesAggregateOrderBy(
    avg: json['avg'] == null
        ? null
        : InputspiciesAvgOrderBy.fromJson(json['avg'] as Map<String, dynamic>),
    count: _$enumDecodeNullable(_$EnumorderByEnumMap, json['count'],
        unknownValue: EnumorderBy.$unknown),
    max: json['max'] == null
        ? null
        : InputspiciesMaxOrderBy.fromJson(json['max'] as Map<String, dynamic>),
    min: json['min'] == null
        ? null
        : InputspiciesMinOrderBy.fromJson(json['min'] as Map<String, dynamic>),
    stddev: json['stddev'] == null
        ? null
        : InputspiciesStddevOrderBy.fromJson(
            json['stddev'] as Map<String, dynamic>),
    stddevPop: json['stddev_pop'] == null
        ? null
        : InputspiciesStddevPopOrderBy.fromJson(
            json['stddev_pop'] as Map<String, dynamic>),
    stddevSamp: json['stddev_samp'] == null
        ? null
        : InputspiciesStddevSampOrderBy.fromJson(
            json['stddev_samp'] as Map<String, dynamic>),
    sum: json['sum'] == null
        ? null
        : InputspiciesSumOrderBy.fromJson(json['sum'] as Map<String, dynamic>),
    varPop: json['var_pop'] == null
        ? null
        : InputspiciesVarPopOrderBy.fromJson(
            json['var_pop'] as Map<String, dynamic>),
    varSamp: json['var_samp'] == null
        ? null
        : InputspiciesVarSampOrderBy.fromJson(
            json['var_samp'] as Map<String, dynamic>),
    variance: json['variance'] == null
        ? null
        : InputspiciesVarianceOrderBy.fromJson(
            json['variance'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$InputspiciesAggregateOrderByToJson(
        InputspiciesAggregateOrderBy instance) =>
    <String, dynamic>{
      'avg': instance.avg,
      'count': _$EnumorderByEnumMap[instance.count],
      'max': instance.max,
      'min': instance.min,
      'stddev': instance.stddev,
      'stddev_pop': instance.stddevPop,
      'stddev_samp': instance.stddevSamp,
      'sum': instance.sum,
      'var_pop': instance.varPop,
      'var_samp': instance.varSamp,
      'variance': instance.variance,
    };

InputspiciesArrRelInsertInput _$InputspiciesArrRelInsertInputFromJson(
    Map<String, dynamic> json) {
  return InputspiciesArrRelInsertInput(
    data: (json['data'] as List<dynamic>)
        .map((e) => InputspiciesInsertInput.fromJson(e as Map<String, dynamic>))
        .toList(),
    onConflict: json['on_conflict'] == null
        ? null
        : InputspiciesOnConflict.fromJson(
            json['on_conflict'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$InputspiciesArrRelInsertInputToJson(
        InputspiciesArrRelInsertInput instance) =>
    <String, dynamic>{
      'data': instance.data,
      'on_conflict': instance.onConflict,
    };

InputspiciesAvgOrderBy _$InputspiciesAvgOrderByFromJson(
    Map<String, dynamic> json) {
  return InputspiciesAvgOrderBy(
    spiciesId: _$enumDecodeNullable(_$EnumorderByEnumMap, json['spiciesId'],
        unknownValue: EnumorderBy.$unknown),
  );
}

Map<String, dynamic> _$InputspiciesAvgOrderByToJson(
        InputspiciesAvgOrderBy instance) =>
    <String, dynamic>{
      'spiciesId': _$EnumorderByEnumMap[instance.spiciesId],
    };

InputspiciesBoolExp _$InputspiciesBoolExpFromJson(Map<String, dynamic> json) {
  return InputspiciesBoolExp(
    and: (json['_and'] as List<dynamic>?)
        ?.map((e) => e == null
            ? null
            : InputspiciesBoolExp.fromJson(e as Map<String, dynamic>))
        .toList(),
    not: json['_not'] == null
        ? null
        : InputspiciesBoolExp.fromJson(json['_not'] as Map<String, dynamic>),
    or: (json['_or'] as List<dynamic>?)
        ?.map((e) => e == null
            ? null
            : InputspiciesBoolExp.fromJson(e as Map<String, dynamic>))
        .toList(),
    description: json['description'] == null
        ? null
        : InputStringComparisonExp.fromJson(
            json['description'] as Map<String, dynamic>),
    isActive: json['isActive'] == null
        ? null
        : InputBooleanComparisonExp.fromJson(
            json['isActive'] as Map<String, dynamic>),
    isBreeding: json['isBreeding'] == null
        ? null
        : InputBooleanComparisonExp.fromJson(
            json['isBreeding'] as Map<String, dynamic>),
    name: json['name'] == null
        ? null
        : InputStringComparisonExp.fromJson(
            json['name'] as Map<String, dynamic>),
    spiciesId: json['spiciesId'] == null
        ? null
        : InputIntComparisonExp.fromJson(
            json['spiciesId'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$InputspiciesBoolExpToJson(
        InputspiciesBoolExp instance) =>
    <String, dynamic>{
      '_and': instance.and,
      '_not': instance.not,
      '_or': instance.or,
      'description': instance.description,
      'isActive': instance.isActive,
      'isBreeding': instance.isBreeding,
      'name': instance.name,
      'spiciesId': instance.spiciesId,
    };

InputspiciesIncInput _$InputspiciesIncInputFromJson(Map<String, dynamic> json) {
  return InputspiciesIncInput(
    spiciesId: json['spiciesId'] as int?,
  );
}

Map<String, dynamic> _$InputspiciesIncInputToJson(
        InputspiciesIncInput instance) =>
    <String, dynamic>{
      'spiciesId': instance.spiciesId,
    };

InputspiciesInsertInput _$InputspiciesInsertInputFromJson(
    Map<String, dynamic> json) {
  return InputspiciesInsertInput(
    description: json['description'] as String?,
    isActive: json['isActive'] as bool?,
    isBreeding: json['isBreeding'] as bool?,
    name: json['name'] as String?,
    spiciesId: json['spiciesId'] as int?,
  );
}

Map<String, dynamic> _$InputspiciesInsertInputToJson(
        InputspiciesInsertInput instance) =>
    <String, dynamic>{
      'description': instance.description,
      'isActive': instance.isActive,
      'isBreeding': instance.isBreeding,
      'name': instance.name,
      'spiciesId': instance.spiciesId,
    };

InputspiciesMaxOrderBy _$InputspiciesMaxOrderByFromJson(
    Map<String, dynamic> json) {
  return InputspiciesMaxOrderBy(
    description: _$enumDecodeNullable(_$EnumorderByEnumMap, json['description'],
        unknownValue: EnumorderBy.$unknown),
    name: _$enumDecodeNullable(_$EnumorderByEnumMap, json['name'],
        unknownValue: EnumorderBy.$unknown),
    spiciesId: _$enumDecodeNullable(_$EnumorderByEnumMap, json['spiciesId'],
        unknownValue: EnumorderBy.$unknown),
  );
}

Map<String, dynamic> _$InputspiciesMaxOrderByToJson(
        InputspiciesMaxOrderBy instance) =>
    <String, dynamic>{
      'description': _$EnumorderByEnumMap[instance.description],
      'name': _$EnumorderByEnumMap[instance.name],
      'spiciesId': _$EnumorderByEnumMap[instance.spiciesId],
    };

InputspiciesMinOrderBy _$InputspiciesMinOrderByFromJson(
    Map<String, dynamic> json) {
  return InputspiciesMinOrderBy(
    description: _$enumDecodeNullable(_$EnumorderByEnumMap, json['description'],
        unknownValue: EnumorderBy.$unknown),
    name: _$enumDecodeNullable(_$EnumorderByEnumMap, json['name'],
        unknownValue: EnumorderBy.$unknown),
    spiciesId: _$enumDecodeNullable(_$EnumorderByEnumMap, json['spiciesId'],
        unknownValue: EnumorderBy.$unknown),
  );
}

Map<String, dynamic> _$InputspiciesMinOrderByToJson(
        InputspiciesMinOrderBy instance) =>
    <String, dynamic>{
      'description': _$EnumorderByEnumMap[instance.description],
      'name': _$EnumorderByEnumMap[instance.name],
      'spiciesId': _$EnumorderByEnumMap[instance.spiciesId],
    };

InputspiciesObjRelInsertInput _$InputspiciesObjRelInsertInputFromJson(
    Map<String, dynamic> json) {
  return InputspiciesObjRelInsertInput(
    data:
        InputspiciesInsertInput.fromJson(json['data'] as Map<String, dynamic>),
    onConflict: json['on_conflict'] == null
        ? null
        : InputspiciesOnConflict.fromJson(
            json['on_conflict'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$InputspiciesObjRelInsertInputToJson(
        InputspiciesObjRelInsertInput instance) =>
    <String, dynamic>{
      'data': instance.data,
      'on_conflict': instance.onConflict,
    };

InputspiciesOnConflict _$InputspiciesOnConflictFromJson(
    Map<String, dynamic> json) {
  return InputspiciesOnConflict(
    constraint: _$enumDecode(_$EnumspiciesConstraintEnumMap, json['constraint'],
        unknownValue: EnumspiciesConstraint.$unknown),
    updateColumns: (json['update_columns'] as List<dynamic>)
        .map((e) => _$enumDecode(_$EnumspiciesUpdateColumnEnumMap, e,
            unknownValue: EnumspiciesUpdateColumn.$unknown))
        .toList(),
    where: json['where'] == null
        ? null
        : InputspiciesBoolExp.fromJson(json['where'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$InputspiciesOnConflictToJson(
        InputspiciesOnConflict instance) =>
    <String, dynamic>{
      'constraint': _$EnumspiciesConstraintEnumMap[instance.constraint],
      'update_columns': instance.updateColumns
          .map((e) => _$EnumspiciesUpdateColumnEnumMap[e])
          .toList(),
      'where': instance.where,
    };

const _$EnumspiciesConstraintEnumMap = {
  EnumspiciesConstraint.pK563a9682557cbbf04a2bb6eea6c:
      'PK_563a9682557cbbf04a2bb6eea6c',
  EnumspiciesConstraint.$unknown: r'$unknown',
};

const _$EnumspiciesUpdateColumnEnumMap = {
  EnumspiciesUpdateColumn.description: 'description',
  EnumspiciesUpdateColumn.isActive: 'isActive',
  EnumspiciesUpdateColumn.isBreeding: 'isBreeding',
  EnumspiciesUpdateColumn.name: 'name',
  EnumspiciesUpdateColumn.spiciesId: 'spiciesId',
  EnumspiciesUpdateColumn.$unknown: r'$unknown',
};

InputspiciesOrderBy _$InputspiciesOrderByFromJson(Map<String, dynamic> json) {
  return InputspiciesOrderBy(
    description: _$enumDecodeNullable(_$EnumorderByEnumMap, json['description'],
        unknownValue: EnumorderBy.$unknown),
    isActive: _$enumDecodeNullable(_$EnumorderByEnumMap, json['isActive'],
        unknownValue: EnumorderBy.$unknown),
    isBreeding: _$enumDecodeNullable(_$EnumorderByEnumMap, json['isBreeding'],
        unknownValue: EnumorderBy.$unknown),
    name: _$enumDecodeNullable(_$EnumorderByEnumMap, json['name'],
        unknownValue: EnumorderBy.$unknown),
    spiciesId: _$enumDecodeNullable(_$EnumorderByEnumMap, json['spiciesId'],
        unknownValue: EnumorderBy.$unknown),
  );
}

Map<String, dynamic> _$InputspiciesOrderByToJson(
        InputspiciesOrderBy instance) =>
    <String, dynamic>{
      'description': _$EnumorderByEnumMap[instance.description],
      'isActive': _$EnumorderByEnumMap[instance.isActive],
      'isBreeding': _$EnumorderByEnumMap[instance.isBreeding],
      'name': _$EnumorderByEnumMap[instance.name],
      'spiciesId': _$EnumorderByEnumMap[instance.spiciesId],
    };

InputspiciesPkColumnsInput _$InputspiciesPkColumnsInputFromJson(
    Map<String, dynamic> json) {
  return InputspiciesPkColumnsInput(
    spiciesId: json['spiciesId'] as int,
  );
}

Map<String, dynamic> _$InputspiciesPkColumnsInputToJson(
        InputspiciesPkColumnsInput instance) =>
    <String, dynamic>{
      'spiciesId': instance.spiciesId,
    };

InputspiciesSetInput _$InputspiciesSetInputFromJson(Map<String, dynamic> json) {
  return InputspiciesSetInput(
    description: json['description'] as String?,
    isActive: json['isActive'] as bool?,
    isBreeding: json['isBreeding'] as bool?,
    name: json['name'] as String?,
    spiciesId: json['spiciesId'] as int?,
  );
}

Map<String, dynamic> _$InputspiciesSetInputToJson(
        InputspiciesSetInput instance) =>
    <String, dynamic>{
      'description': instance.description,
      'isActive': instance.isActive,
      'isBreeding': instance.isBreeding,
      'name': instance.name,
      'spiciesId': instance.spiciesId,
    };

InputspiciesStddevOrderBy _$InputspiciesStddevOrderByFromJson(
    Map<String, dynamic> json) {
  return InputspiciesStddevOrderBy(
    spiciesId: _$enumDecodeNullable(_$EnumorderByEnumMap, json['spiciesId'],
        unknownValue: EnumorderBy.$unknown),
  );
}

Map<String, dynamic> _$InputspiciesStddevOrderByToJson(
        InputspiciesStddevOrderBy instance) =>
    <String, dynamic>{
      'spiciesId': _$EnumorderByEnumMap[instance.spiciesId],
    };

InputspiciesStddevPopOrderBy _$InputspiciesStddevPopOrderByFromJson(
    Map<String, dynamic> json) {
  return InputspiciesStddevPopOrderBy(
    spiciesId: _$enumDecodeNullable(_$EnumorderByEnumMap, json['spiciesId'],
        unknownValue: EnumorderBy.$unknown),
  );
}

Map<String, dynamic> _$InputspiciesStddevPopOrderByToJson(
        InputspiciesStddevPopOrderBy instance) =>
    <String, dynamic>{
      'spiciesId': _$EnumorderByEnumMap[instance.spiciesId],
    };

InputspiciesStddevSampOrderBy _$InputspiciesStddevSampOrderByFromJson(
    Map<String, dynamic> json) {
  return InputspiciesStddevSampOrderBy(
    spiciesId: _$enumDecodeNullable(_$EnumorderByEnumMap, json['spiciesId'],
        unknownValue: EnumorderBy.$unknown),
  );
}

Map<String, dynamic> _$InputspiciesStddevSampOrderByToJson(
        InputspiciesStddevSampOrderBy instance) =>
    <String, dynamic>{
      'spiciesId': _$EnumorderByEnumMap[instance.spiciesId],
    };

InputspiciesSumOrderBy _$InputspiciesSumOrderByFromJson(
    Map<String, dynamic> json) {
  return InputspiciesSumOrderBy(
    spiciesId: _$enumDecodeNullable(_$EnumorderByEnumMap, json['spiciesId'],
        unknownValue: EnumorderBy.$unknown),
  );
}

Map<String, dynamic> _$InputspiciesSumOrderByToJson(
        InputspiciesSumOrderBy instance) =>
    <String, dynamic>{
      'spiciesId': _$EnumorderByEnumMap[instance.spiciesId],
    };

InputspiciesVarPopOrderBy _$InputspiciesVarPopOrderByFromJson(
    Map<String, dynamic> json) {
  return InputspiciesVarPopOrderBy(
    spiciesId: _$enumDecodeNullable(_$EnumorderByEnumMap, json['spiciesId'],
        unknownValue: EnumorderBy.$unknown),
  );
}

Map<String, dynamic> _$InputspiciesVarPopOrderByToJson(
        InputspiciesVarPopOrderBy instance) =>
    <String, dynamic>{
      'spiciesId': _$EnumorderByEnumMap[instance.spiciesId],
    };

InputspiciesVarSampOrderBy _$InputspiciesVarSampOrderByFromJson(
    Map<String, dynamic> json) {
  return InputspiciesVarSampOrderBy(
    spiciesId: _$enumDecodeNullable(_$EnumorderByEnumMap, json['spiciesId'],
        unknownValue: EnumorderBy.$unknown),
  );
}

Map<String, dynamic> _$InputspiciesVarSampOrderByToJson(
        InputspiciesVarSampOrderBy instance) =>
    <String, dynamic>{
      'spiciesId': _$EnumorderByEnumMap[instance.spiciesId],
    };

InputspiciesVarianceOrderBy _$InputspiciesVarianceOrderByFromJson(
    Map<String, dynamic> json) {
  return InputspiciesVarianceOrderBy(
    spiciesId: _$enumDecodeNullable(_$EnumorderByEnumMap, json['spiciesId'],
        unknownValue: EnumorderBy.$unknown),
  );
}

Map<String, dynamic> _$InputspiciesVarianceOrderByToJson(
        InputspiciesVarianceOrderBy instance) =>
    <String, dynamic>{
      'spiciesId': _$EnumorderByEnumMap[instance.spiciesId],
    };

InputStringComparisonExp _$InputStringComparisonExpFromJson(
    Map<String, dynamic> json) {
  return InputStringComparisonExp(
    eq: json['_eq'] as String?,
    gt: json['_gt'] as String?,
    gte: json['_gte'] as String?,
    ilike: json['_ilike'] as String?,
    $in: (json['_in'] as List<dynamic>?)?.map((e) => e as String).toList(),
    isNull: json['_is_null'] as bool?,
    like: json['_like'] as String?,
    lt: json['_lt'] as String?,
    lte: json['_lte'] as String?,
    neq: json['_neq'] as String?,
    nilike: json['_nilike'] as String?,
    nin: (json['_nin'] as List<dynamic>?)?.map((e) => e as String).toList(),
    nlike: json['_nlike'] as String?,
    nsimilar: json['_nsimilar'] as String?,
    similar: json['_similar'] as String?,
  );
}

Map<String, dynamic> _$InputStringComparisonExpToJson(
        InputStringComparisonExp instance) =>
    <String, dynamic>{
      '_eq': instance.eq,
      '_gt': instance.gt,
      '_gte': instance.gte,
      '_ilike': instance.ilike,
      '_in': instance.$in,
      '_is_null': instance.isNull,
      '_like': instance.like,
      '_lt': instance.lt,
      '_lte': instance.lte,
      '_neq': instance.neq,
      '_nilike': instance.nilike,
      '_nin': instance.nin,
      '_nlike': instance.nlike,
      '_nsimilar': instance.nsimilar,
      '_similar': instance.similar,
    };
