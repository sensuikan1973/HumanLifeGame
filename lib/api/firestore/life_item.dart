import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../entities/life_item_type.dart';
import 'entity.dart';

part 'life_item.freezed.dart';
part 'life_item.g.dart';

@immutable
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
