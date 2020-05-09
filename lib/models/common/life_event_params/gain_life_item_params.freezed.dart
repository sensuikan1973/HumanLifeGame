// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'gain_life_item_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
GainLifeItemParams _$GainLifeItemParamsFromJson(Map<String, dynamic> json) {
  return _GainLifeItemParams.fromJson(json);
}

class _$GainLifeItemParamsTearOff {
  const _$GainLifeItemParamsTearOff();

  _GainLifeItemParams call({List<GainLifeItemTarget> targetItems}) {
    return _GainLifeItemParams(
      targetItems: targetItems,
    );
  }
}

// ignore: unused_element
const $GainLifeItemParams = _$GainLifeItemParamsTearOff();

mixin _$GainLifeItemParams {
  List<GainLifeItemTarget> get targetItems;

  Map<String, dynamic> toJson();
  $GainLifeItemParamsCopyWith<GainLifeItemParams> get copyWith;
}

abstract class $GainLifeItemParamsCopyWith<$Res> {
  factory $GainLifeItemParamsCopyWith(
          GainLifeItemParams value, $Res Function(GainLifeItemParams) then) =
      _$GainLifeItemParamsCopyWithImpl<$Res>;
  $Res call({List<GainLifeItemTarget> targetItems});
}

class _$GainLifeItemParamsCopyWithImpl<$Res>
    implements $GainLifeItemParamsCopyWith<$Res> {
  _$GainLifeItemParamsCopyWithImpl(this._value, this._then);

  final GainLifeItemParams _value;
  // ignore: unused_field
  final $Res Function(GainLifeItemParams) _then;

  @override
  $Res call({
    Object targetItems = freezed,
  }) {
    return _then(_value.copyWith(
      targetItems: targetItems == freezed
          ? _value.targetItems
          : targetItems as List<GainLifeItemTarget>,
    ));
  }
}

abstract class _$GainLifeItemParamsCopyWith<$Res>
    implements $GainLifeItemParamsCopyWith<$Res> {
  factory _$GainLifeItemParamsCopyWith(
          _GainLifeItemParams value, $Res Function(_GainLifeItemParams) then) =
      __$GainLifeItemParamsCopyWithImpl<$Res>;
  @override
  $Res call({List<GainLifeItemTarget> targetItems});
}

class __$GainLifeItemParamsCopyWithImpl<$Res>
    extends _$GainLifeItemParamsCopyWithImpl<$Res>
    implements _$GainLifeItemParamsCopyWith<$Res> {
  __$GainLifeItemParamsCopyWithImpl(
      _GainLifeItemParams _value, $Res Function(_GainLifeItemParams) _then)
      : super(_value, (v) => _then(v as _GainLifeItemParams));

  @override
  _GainLifeItemParams get _value => super._value as _GainLifeItemParams;

  @override
  $Res call({
    Object targetItems = freezed,
  }) {
    return _then(_GainLifeItemParams(
      targetItems: targetItems == freezed
          ? _value.targetItems
          : targetItems as List<GainLifeItemTarget>,
    ));
  }
}

@JsonSerializable()
class _$_GainLifeItemParams
    with DiagnosticableTreeMixin
    implements _GainLifeItemParams {
  const _$_GainLifeItemParams({this.targetItems});

  factory _$_GainLifeItemParams.fromJson(Map<String, dynamic> json) =>
      _$_$_GainLifeItemParamsFromJson(json);

  @override
  final List<GainLifeItemTarget> targetItems;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GainLifeItemParams(targetItems: $targetItems)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GainLifeItemParams'))
      ..add(DiagnosticsProperty('targetItems', targetItems));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _GainLifeItemParams &&
            (identical(other.targetItems, targetItems) ||
                const DeepCollectionEquality()
                    .equals(other.targetItems, targetItems)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(targetItems);

  @override
  _$GainLifeItemParamsCopyWith<_GainLifeItemParams> get copyWith =>
      __$GainLifeItemParamsCopyWithImpl<_GainLifeItemParams>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_GainLifeItemParamsToJson(this);
  }
}

abstract class _GainLifeItemParams implements GainLifeItemParams {
  const factory _GainLifeItemParams({List<GainLifeItemTarget> targetItems}) =
      _$_GainLifeItemParams;

  factory _GainLifeItemParams.fromJson(Map<String, dynamic> json) =
      _$_GainLifeItemParams.fromJson;

  @override
  List<GainLifeItemTarget> get targetItems;
  @override
  _$GainLifeItemParamsCopyWith<_GainLifeItemParams> get copyWith;
}

GainLifeItemTarget _$GainLifeItemTargetFromJson(Map<String, dynamic> json) {
  return _GainLifeItemTarget.fromJson(json);
}

class _$GainLifeItemTargetTearOff {
  const _$GainLifeItemTargetTearOff();

  _GainLifeItemTarget call({String key, LifeItemType type, int amount}) {
    return _GainLifeItemTarget(
      key: key,
      type: type,
      amount: amount,
    );
  }
}

// ignore: unused_element
const $GainLifeItemTarget = _$GainLifeItemTargetTearOff();

mixin _$GainLifeItemTarget {
  String get key;
  LifeItemType get type;
  int get amount;

  Map<String, dynamic> toJson();
  $GainLifeItemTargetCopyWith<GainLifeItemTarget> get copyWith;
}

abstract class $GainLifeItemTargetCopyWith<$Res> {
  factory $GainLifeItemTargetCopyWith(
          GainLifeItemTarget value, $Res Function(GainLifeItemTarget) then) =
      _$GainLifeItemTargetCopyWithImpl<$Res>;
  $Res call({String key, LifeItemType type, int amount});
}

class _$GainLifeItemTargetCopyWithImpl<$Res>
    implements $GainLifeItemTargetCopyWith<$Res> {
  _$GainLifeItemTargetCopyWithImpl(this._value, this._then);

  final GainLifeItemTarget _value;
  // ignore: unused_field
  final $Res Function(GainLifeItemTarget) _then;

  @override
  $Res call({
    Object key = freezed,
    Object type = freezed,
    Object amount = freezed,
  }) {
    return _then(_value.copyWith(
      key: key == freezed ? _value.key : key as String,
      type: type == freezed ? _value.type : type as LifeItemType,
      amount: amount == freezed ? _value.amount : amount as int,
    ));
  }
}

abstract class _$GainLifeItemTargetCopyWith<$Res>
    implements $GainLifeItemTargetCopyWith<$Res> {
  factory _$GainLifeItemTargetCopyWith(
          _GainLifeItemTarget value, $Res Function(_GainLifeItemTarget) then) =
      __$GainLifeItemTargetCopyWithImpl<$Res>;
  @override
  $Res call({String key, LifeItemType type, int amount});
}

class __$GainLifeItemTargetCopyWithImpl<$Res>
    extends _$GainLifeItemTargetCopyWithImpl<$Res>
    implements _$GainLifeItemTargetCopyWith<$Res> {
  __$GainLifeItemTargetCopyWithImpl(
      _GainLifeItemTarget _value, $Res Function(_GainLifeItemTarget) _then)
      : super(_value, (v) => _then(v as _GainLifeItemTarget));

  @override
  _GainLifeItemTarget get _value => super._value as _GainLifeItemTarget;

  @override
  $Res call({
    Object key = freezed,
    Object type = freezed,
    Object amount = freezed,
  }) {
    return _then(_GainLifeItemTarget(
      key: key == freezed ? _value.key : key as String,
      type: type == freezed ? _value.type : type as LifeItemType,
      amount: amount == freezed ? _value.amount : amount as int,
    ));
  }
}

@JsonSerializable()
class _$_GainLifeItemTarget
    with DiagnosticableTreeMixin
    implements _GainLifeItemTarget {
  const _$_GainLifeItemTarget({this.key, this.type, this.amount});

  factory _$_GainLifeItemTarget.fromJson(Map<String, dynamic> json) =>
      _$_$_GainLifeItemTargetFromJson(json);

  @override
  final String key;
  @override
  final LifeItemType type;
  @override
  final int amount;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GainLifeItemTarget(key: $key, type: $type, amount: $amount)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GainLifeItemTarget'))
      ..add(DiagnosticsProperty('key', key))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('amount', amount));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _GainLifeItemTarget &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(key) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(amount);

  @override
  _$GainLifeItemTargetCopyWith<_GainLifeItemTarget> get copyWith =>
      __$GainLifeItemTargetCopyWithImpl<_GainLifeItemTarget>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_GainLifeItemTargetToJson(this);
  }
}

abstract class _GainLifeItemTarget implements GainLifeItemTarget {
  const factory _GainLifeItemTarget(
      {String key, LifeItemType type, int amount}) = _$_GainLifeItemTarget;

  factory _GainLifeItemTarget.fromJson(Map<String, dynamic> json) =
      _$_GainLifeItemTarget.fromJson;

  @override
  String get key;
  @override
  LifeItemType get type;
  @override
  int get amount;
  @override
  _$GainLifeItemTargetCopyWith<_GainLifeItemTarget> get copyWith;
}
