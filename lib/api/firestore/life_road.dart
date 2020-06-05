import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'life_event.dart';

part 'life_road.freezed.dart';
part 'life_road.g.dart';

@freezed
abstract class LifeRoad with _$LifeRoad {
  const factory LifeRoad({
    @required @DocumentReferenceConverter() DocumentReference author,
    @required String title,
    @required List<LifeEvent> lifeEvents,
    @required @TimestampConverter() DateTime createdAt,
    @required @TimestampConverter() DateTime updatedAt,
  }) = _LifeRoad;
  factory LifeRoad.fromJson(Map<String, dynamic> json) => _$LifeRoadFromJson(json);

  @visibleForTesting
  static const collectionId = 'lifeRoad';
}

class LifeRoadField {
  /// 作成者
  static const author = 'author';

  /// タイトル
  static const title = 'title';

  /// LifeEvent の配列
  ///
  /// クライアントサイドで二次元に展開 + 連結リスト化 するのが必要
  static const lifeEvents = 'lifeEvents';

  /// 作成時刻
  static const createdAt = 'createdAt';

  /// 更新時刻
  static const updatedAt = 'updatedAt';
}
