import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'life_event_record.dart';
import 'life_stage.dart';

part 'play_room.freezed.dart';
part 'play_room.g.dart';

/// Document on Firestore
///
/// TODO: プレイ終了後に削除してもいいモノなので、DocRef で持ってるやつは Value で十分じゃないかを検討.
/// TODO: announcement はクライアントサイド完結想定だが、必要になったら追加.
/// TODO: finishedAt は削除ロジックに使う想定だが、不要だったら削除. まだロジックを考え中.
@freezed
abstract class PlayRoom with _$PlayRoom {
  const factory PlayRoom({
    @required @DocumentReferenceConverter() DocumentReference host,
    @required String title,
    @required @DocumentReferenceListConverter() List<DocumentReference> humans,
    @required @DocumentReferenceConverter() DocumentReference lifeRoad,
    @required List<LifeEventRecord> everyLifeEventRecords,
    @required List<LifeStage> lifeStages,
    @required String currentTurnHumanId,
    @required @TimestampConverter() DateTime createdAt,
    @required @TimestampConverter() DateTime updatedAt,
    @TimestampConverter() DateTime finishedAt,
  }) = _PlayRoom;
  factory PlayRoom.fromJson(Map<String, dynamic> json) => _$PlayRoomFromJson(json);

  @visibleForTesting
  static const collectionId = 'playRoom';
}

class PlayRoomField {
  /// 主催者(user)
  static const host = 'host';

  /// 部屋のタイトル
  static const title = 'title';

  /// 人生を歩む参加者(human)
  static const humans = 'humans';

  /// 歩む対象となる人生
  static const lifeRoad = 'lifeRoad';

  /// 参加者全員の LifeEvent 履歴
  static const everyLifeEventRecords = 'everyLifeEventRecords';

  /// 参加者それぞれの人生の進捗
  static const lifeStages = 'lifeStages';

  /// 現在手番の human id
  static const currentTurnHumanId = 'currentTurnHumanId';

  /// ゲーム終了時刻
  static const finishedAt = 'finishedAt';
}
