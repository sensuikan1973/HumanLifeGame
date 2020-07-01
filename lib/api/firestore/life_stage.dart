import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'entity.dart';

part 'life_stage.freezed.dart';
part 'life_stage.g.dart';

/// Document on Firestore
@freezed
abstract class LifeStageEntity implements _$LifeStageEntity, Entity {
  const factory LifeStageEntity({
    @required @DocumentReferenceConverter() DocumentReference human,
    @required String currentLifeStepId,
    @required @TimestampConverter() DateTime createdAt,
    @required @TimestampConverter() DateTime updatedAt,
  }) = _LifeStageEntity;
  const LifeStageEntity._();

  factory LifeStageEntity.fromJson(Map<String, dynamic> json) => _$LifeStageEntityFromJson(json);

  @override
  Map<String, dynamic> encode() => replacingTimestamp(json: toJson());

  static Document<LifeStageEntity> decode(DocumentSnapshot snapshot) => Document<LifeStageEntity>(
        snapshot.reference,
        LifeStageEntity.fromJson(snapshot.data),
      );
}

class LifeStageEntityField {
  /// 対象の human
  static const human = 'human';

  /// 現在位置する LifeStep の識別子
  static const currentLifeStepId = 'currentLifeStepId';
}
