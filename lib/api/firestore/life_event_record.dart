import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../entities/life_event.dart';
import '../../entities/life_event_params/life_event_params.dart';
import 'store.dart';
import 'store_entity.dart';

part 'life_event_record.freezed.dart';
part 'life_event_record.g.dart';

@immutable
@freezed
abstract class LifeEventRecordEntity implements _$LifeEventRecordEntity, StoreEntity {
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

enum LifeEventRecordEntityField {
  /// Event を経験した human (user)
  human,

  /// LifeEvent
  lifeEvent,
}

extension LifeEventRecordEntityFieldExtension on LifeEventRecordEntityField {
  String get name => describeEnum(this);
}
