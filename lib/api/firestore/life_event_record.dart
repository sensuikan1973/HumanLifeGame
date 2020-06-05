import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'life_event.dart';

part 'life_event_record.freezed.dart';
part 'life_event_record.g.dart';

/// Document on Firestore
@freezed
abstract class LifeEventRecord with _$LifeEventRecord {
  const factory LifeEventRecord({
    @required String humanId,
    @required LifeEvent lifeEvent,
    @required @TimestampConverter() DateTime updatedAt,
  }) = _LifeEventRecord;
  factory LifeEventRecord.fromJson(Map<String, dynamic> json) => _$LifeEventRecordFromJson(json);

  @visibleForTesting
  static const collectionId = 'lifeEventRecord';
}

class LifeEventRecordField {
  /// 主(human) の id
  static const humanId = 'humanId';

  /// LifeEvent
  static const lifeEvent = 'lifeEvent';

  /// 更新時刻
  static const updatedAt = 'updatedAt';
}
