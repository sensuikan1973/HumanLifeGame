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
    @required String key,
    @required int amount,
  }) = _LifeItemEntity;
  const LifeItemEntity._();

  factory LifeItemEntity.fromJson(Map<String, dynamic> json) => _$LifeItemEntityFromJson(json);
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
