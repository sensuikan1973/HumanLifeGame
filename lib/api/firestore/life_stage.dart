import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'entity.dart';
import 'store.dart';
import 'user.dart';

part 'life_stage.freezed.dart';
part 'life_stage.g.dart';

@immutable
@freezed
abstract class LifeStageEntity implements _$LifeStageEntity, Entity {
  const factory LifeStageEntity({
    @required @DocumentReferenceConverter() DocumentReference human,
    @required String currentLifeStepId,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
  }) = _LifeStageEntity;
  const LifeStageEntity._();

  factory LifeStageEntity.fromJson(Map<String, dynamic> json) => _$LifeStageEntityFromJson(json);

  @override
  Map<String, dynamic> encode() => replacingTimestamp(json: toJson());

  static Doc<LifeStageEntity> decode(Store store, DocumentSnapshot snapshot) => Doc<LifeStageEntity>(
        store,
        snapshot.reference,
        LifeStageEntity.fromJson(snapshot.data),
      );

  /// この人生の進捗を歩んでる human を取得する
  Future<Doc<UserEntity>> fetchHuman(Store store) async => UserEntity.decode(store, await human.get());
}

class LifeStageEntityField {
  /// 対象の human
  static const human = 'human';

  /// 現在位置する LifeStep の識別子
  static const currentLifeStepId = 'currentLifeStepId';
}
