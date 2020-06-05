import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'life_item.freezed.dart';
part 'life_item.g.dart';

/// Map Value on Firestore
@freezed
abstract class LifeItem with _$LifeItem {
  const factory LifeItem({
    @required String type,
    @required String key,
    @required int amount,
  }) = _LifeItem;
  factory LifeItem.fromJson(Map<String, dynamic> json) => _$LifeItemFromJson(json);

  @visibleForTesting
  static const collectionId = 'lifeItem';
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
