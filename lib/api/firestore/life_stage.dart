import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'life_item.dart';

part 'life_stage.freezed.dart';
part 'life_stage.g.dart';

/// Document on Firestore
@freezed
abstract class LifeStage with _$LifeStage {
  const factory LifeStage({
    @required String currentLifeStepId,
    @required List<LifeItem> lifeItems,
    @required @TimestampConverter() DateTime createdAt,
    @required @TimestampConverter() DateTime updatedAt,
  }) = _LifeStage;
  factory LifeStage.fromJson(Map<String, dynamic> json) => _$LifeStageFromJson(json);

  @visibleForTesting
  static const collectionId = 'lifeStage';
}

class LifeStageField {
  /// 現在位置する LifeStep の識別子
  static const currentLifeStepId = 'currentLifeStepId';

  /// 所持してる LifeItem
  static const lifeItems = 'lifeItems';
}
