import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../entities/life_event_params/life_event_params.dart';
import 'entity.dart';
import 'life_event.dart';
import 'store.dart';

part 'life_event_record.freezed.dart';
part 'life_event_record.g.dart';

@freezed
abstract class LifeEventRecordEntity implements _$LifeEventRecordEntity, Entity {
  const factory LifeEventRecordEntity({
    @required @DocumentReferenceConverter() DocumentReference human,
    @required LifeEventEntity lifeEvent,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
  }) = _LifeEventRecordEntity;
  const LifeEventRecordEntity._();

  factory LifeEventRecordEntity.fromJson(Map<String, dynamic> json) => _$LifeEventRecordEntityFromJson(json);

  @override
  Map<String, dynamic> encode() => replacingTimestamp(json: toJson());

  static Doc<LifeEventRecordEntity> decode(Store store, DocumentSnapshot snapshot) => Doc<LifeEventRecordEntity>(
        store,
        snapshot.reference,
        LifeEventRecordEntity.fromJson(snapshot.data),
      );
}

class LifeEventRecordEntityField {
  /// Event を経験した human (user)
  static const human = 'human';

  /// LifeEvent
  static const lifeEvent = 'lifeEvent';
}
