import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'entity.dart';
import 'life_event.dart';

part 'life_event_record.freezed.dart';
part 'life_event_record.g.dart';

/// Document on Firestore
@freezed
abstract class LifeEventRecord implements _$LifeEventRecord, Entity {
  const factory LifeEventRecord({
    @required String humanId,
    @required LifeEvent lifeEvent,
    @required @TimestampConverter() DateTime createdAt,
  }) = _LifeEventRecord;
  const LifeEventRecord._();

  factory LifeEventRecord.fromJson(Map<String, dynamic> json) => _$LifeEventRecordFromJson(json);

  @override
  Map<String, dynamic> encode() => replacingTimestamp(json: toJson());
}

class LifeEventRecordField {
  /// 主(human) の id
  static const humanId = 'humanId';

  /// LifeEvent
  static const lifeEvent = 'lifeEvent';
}
