import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'entity.dart';

part 'life_item.freezed.dart';
part 'life_item.g.dart';

@freezed
abstract class LifeItemEntity implements _$LifeItemEntity, Entity {
  const factory LifeItemEntity({
    @required LifeItemType type,
    @required String key,
    @required int amount,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
  }) = _LifeItemEntity;
  const LifeItemEntity._();

  factory LifeItemEntity.fromJson(Map<String, dynamic> json) => _$LifeItemEntityFromJson(json);

  @override
  Map<String, dynamic> encode() => replacingTimestamp(json: toJson());
}

class LifeItemFieldEntity {
  /// Item の種別
  static const type = 'type';

  /// Item の具体的な内容を一意に識別する文字列
  ///
  /// 例) type "money" の key "nihon ginko".
  static const key = 'key';

  /// 数量
  static const int = 'amount';
}

/// アイテム種別
enum LifeItemType {
  /// 職業
  ///
  /// 詳細は key 文字列で表現する.
  job,

  /// 株
  stock,

  /// 配偶者
  spouse,

  /// 家
  house,

  /// 金
  money,

  /// 乗り物
  vehicle,

  /// 子供(女の子)
  childGirl,

  /// 子供(男の子)
  childBoy,

  /// 火災保険
  fireInsurance,

  /// 生命保険
  lifeInsurance,

  /// 地震保険
  earthquakeInsurance,

  /// 自動車保険
  carInsurance,

  /// コーヒー
  ///
  /// 特殊アイテム. 所有している場合、強制的に消費して「1回休み」をくらう.
  coffee,
}
