import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'entity.dart';

part 'life_item.freezed.dart';
part 'life_item.g.dart';

/// Map Value on Firestore
@freezed
abstract class LifeItem implements _$LifeItem, Entity {
  const factory LifeItem({
    @required String type,
    @required String key,
    @required int amount,
    @required @TimestampConverter() DateTime createdAt,
    @required @TimestampConverter() DateTime updatedAt,
  }) = _LifeItem;
  const LifeItem._();

  factory LifeItem.fromJson(Map<String, dynamic> json) => _$LifeItemFromJson(json);

  @override
  Map<String, dynamic> encode() => replacingTimestamp(json: toJson());
}

class LifeItemField {
  /// Item の種別
  static const type = 'type';

  /// Item の具体的な内容を一意に識別する文字列
  ///
  /// 例) type "money" の key "nihon ginko".
  static const key = 'key';

  /// 数量
  static const int = 'amount';
}
