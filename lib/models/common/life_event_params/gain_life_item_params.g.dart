// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gain_life_item_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GainLifeItemParams _$_$_GainLifeItemParamsFromJson(Map<String, dynamic> json) {
  return _$_GainLifeItemParams(
    targetItems: (json['targetItems'] as List)
        ?.map((e) => e == null ? null : GainLifeItemTarget.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$_$_GainLifeItemParamsToJson(_$_GainLifeItemParams instance) => <String, dynamic>{
      'targetItems': instance.targetItems,
    };

_$_GainLifeItemTarget _$_$_GainLifeItemTargetFromJson(Map<String, dynamic> json) {
  return _$_GainLifeItemTarget(
    key: json['key'] as String,
    type: _$enumDecodeNullable(_$LifeItemTypeEnumMap, json['type']),
    amount: json['amount'] as int,
  );
}

Map<String, dynamic> _$_$_GainLifeItemTargetToJson(_$_GainLifeItemTarget instance) => <String, dynamic>{
      'key': instance.key,
      'type': _$LifeItemTypeEnumMap[instance.type],
      'amount': instance.amount,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries.singleWhere((e) => e.value == source, orElse: () => null)?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$LifeItemTypeEnumMap = {
  LifeItemType.job: 'job',
  LifeItemType.stock: 'stock',
  LifeItemType.spouse: 'spouse',
  LifeItemType.house: 'house',
  LifeItemType.money: 'money',
  LifeItemType.vehicle: 'vehicle',
  LifeItemType.childGirl: 'childGirl',
  LifeItemType.childBoy: 'childBoy',
  LifeItemType.fireInsurance: 'fireInsurance',
  LifeItemType.lifeInsurance: 'lifeInsurance',
  LifeItemType.earthquakeInsurance: 'earthquakeInsurance',
  LifeItemType.carInsurance: 'carInsurance',
  LifeItemType.coffee: 'coffee',
};
