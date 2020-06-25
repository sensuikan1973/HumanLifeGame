import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'entity.dart';
import 'life_event.dart';

part 'life_road.freezed.dart';
part 'life_road.g.dart';

// FIXME: LifeRoad だし、あるべき Field でない
@freezed
abstract class HumanLife implements _$HumanLife, Entity {
  const factory HumanLife({
    @required @DocumentReferenceConverter() DocumentReference author,
    @required String title,
    @required List<LifeEventEntity> lifeEvents,
    @required @TimestampConverter() DateTime createdAt,
    @required @TimestampConverter() DateTime updatedAt,
  }) = _HumanLife;
  const HumanLife._();

  factory HumanLife.fromJson(Map<String, dynamic> json) => _$HumanLifeFromJson(json);

  @override
  Map<String, dynamic> encode() => replacingTimestamp(json: toJson());
}

class HumanLifeField {
  /// 作成者
  static const author = 'author';

  /// タイトル
  static const title = 'title';

  /// LifeRoad の LifeEvent 配列
  ///
  /// クライアントサイドで二次元に展開 + 連結リスト化 するのが必要
  static const lifeRoadEvents = 'lifeRoadEvents';
}
