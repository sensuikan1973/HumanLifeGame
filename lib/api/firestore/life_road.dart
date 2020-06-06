import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'life_event.dart';

part 'life_road.freezed.dart';
part 'life_road.g.dart';

/// Document on Firestore
@freezed
abstract class HumanLife with _$HumanLife {
  const factory HumanLife({
    @required @DocumentReferenceConverter() DocumentReference author,
    @required String title,
    @required List<LifeEvent> lifeEvents,
    @required @TimestampConverter() DateTime createdAt,
    @required @TimestampConverter() DateTime updatedAt,
  }) = _HumanLife;
  factory HumanLife.fromJson(Map<String, dynamic> json) => _$HumanLifeFromJson(json);

  @visibleForTesting
  static const collectionId = 'humanLife';
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

  /// 作成時刻
  static const createdAt = 'createdAt';

  /// 更新時刻
  static const updatedAt = 'updatedAt';
}
