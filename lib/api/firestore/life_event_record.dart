import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/common/life_event_params/life_event_params.dart';
import 'entity.dart';
import 'life_event.dart';

part 'life_event_record.freezed.dart';
part 'life_event_record.g.dart';

@freezed
abstract class LifeEventRecordEntity implements _$LifeEventRecordEntity, Entity {
  const factory LifeEventRecordEntity({
    @required String humanId,
    @required LifeEventEntity<LifeEventParams> lifeEvent,
    @required @TimestampConverter() DateTime createdAt,
  }) = _LifeEventRecordEntity;
  const LifeEventRecordEntity._();

  factory LifeEventRecordEntity.fromJson(Map<String, dynamic> json) => _$LifeEventRecordEntityFromJson(json);

  @override
  Map<String, dynamic> encode() => replacingTimestamp(json: toJson());

  static Document<LifeEventRecordEntity> decode(DocumentSnapshot snapshot) => Document<LifeEventRecordEntity>(
        snapshot.reference,
        LifeEventRecordEntity.fromJson(snapshot.data),
      );
}

class LifeEventRecordEntityField {
  /// 主(human) の id
  static const humanId = 'humanId';

  /// LifeEvent
  static const lifeEvent = 'lifeEvent';
}
