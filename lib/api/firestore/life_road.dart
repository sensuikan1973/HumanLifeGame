import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/common/life_event_params/life_event_params.dart';
import 'entity.dart';
import 'life_event.dart';
import 'store.dart';

part 'life_road.freezed.dart';
part 'life_road.g.dart';

// FIXME: LifeRoad だし、あるべき Field でない
@freezed
abstract class LifeRoadEntity implements _$LifeRoadEntity, Entity {
  const factory LifeRoadEntity({
    @required @DocumentReferenceConverter() DocumentReference author,
    @required List<LifeEventEntity<LifeEventParams>> lifeEvents,
    @required @TimestampConverter() DateTime createdAt,
    @required @TimestampConverter() DateTime updatedAt,
    @Default('') String title,
  }) = _LifeRoadEntity;
  const LifeRoadEntity._();

  factory LifeRoadEntity.fromJson(Map<String, dynamic> json) => _$LifeRoadEntityFromJson(json);

  @override
  Map<String, dynamic> encode() => replacingTimestamp(json: toJson());

  static Doc<LifeRoadEntity> decode(Store store, DocumentSnapshot snapshot) => Doc<LifeRoadEntity>(
        store,
        snapshot.reference,
        LifeRoadEntity.fromJson(snapshot.data),
      );
}

class LifeRoadEntityField {
  /// 作成者
  static const author = 'author';

  /// タイトル
  static const title = 'title';

  /// LifeRoad の LifeEvent 配列
  ///
  /// クライアントサイドで二次元に展開 + 連結リスト化 するのが必要
  static const lifeRoadEvents = 'lifeRoadEvents';
}
