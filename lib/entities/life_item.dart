import 'package:HumanLifeGame/entities/life_event_params/target_life_item_params.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'life_item_type.dart';

part 'life_item.freezed.dart';
part 'life_item.g.dart';

@immutable
@freezed
abstract class LifeItemEntity implements _$LifeItemEntity {
  const factory LifeItemEntity({
    @required LifeItemType type,
    @required int amount,
    @Default('') String key, // type だけで一意に識別できない時に使う
  }) = _LifeItemEntity;
  const LifeItemEntity._();

  factory LifeItemEntity.fromJson(Map<String, dynamic> json) => _$LifeItemEntityFromJson(json);

  /// FIXME: == の override は現状機能してない。↓の issue が対応されたら使う。
  /// See: https://github.com/rrousselGit/freezed/issues/221
  //  @override
  //  bool operator ==(Object other) => other is LifeItemEntity && other.type == type && other.key == key;
  //
  //  @override
  //  int get hashCode => type.hashCode ^ key.hashCode;

  bool equalToTarget(Object object) => object is TargetLifeItemParams && object.type == type && object.key == key;
}

class LifeItemEntityField {
  /// Item の種別
  static const type = 'type';

  /// Item の具体的な内容を一意に識別する文字列
  /// 任意で使う
  /// 例) type "money" の key "nihon ginko".
  static const key = 'key';

  /// 数量
  static const int = 'amount';
}
