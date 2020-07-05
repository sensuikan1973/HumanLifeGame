import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'entity.dart';
import 'life_road.dart';
import 'user.dart';

part 'play_room.freezed.dart';
part 'play_room.g.dart';

/// Document on Firestore
///
/// TODO: プレイ終了後に削除してもいいモノなので、DocRef で持ってるやつは Value で十分じゃないかを検討.
/// TODO: announcement はクライアントサイド完結想定だが、必要になったら追加.
/// TODO: finishedAt は削除ロジックに使う想定だが、不要だったら削除. まだロジックを考え中.
@freezed
abstract class PlayRoomEntity implements _$PlayRoomEntity, Entity {
  factory PlayRoomEntity({
    @required @DocumentReferenceConverter() DocumentReference host,
    @required @DocumentReferenceListConverter() List<DocumentReference> humans,
    @required @DocumentReferenceConverter() DocumentReference lifeRoad,
    @required String currentTurnHumanId,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
    @Default('') String title,
//    @TimestampConverter() DateTime finishedAt,
  }) = _PlayRoomEntity;
  PlayRoomEntity._();

  factory PlayRoomEntity.fromJson(Map<String, dynamic> json) => _$PlayRoomEntityFromJson(json);

  @override
  Map<String, dynamic> encode() => replacingTimestamp(json: toJson());

  static Document<PlayRoomEntity> decode(DocumentSnapshot snapshot) => Document<PlayRoomEntity>(
        snapshot.reference,
        PlayRoomEntity.fromJson(snapshot.data),
      );

  /// humans の document ID List
  @late
  List<String> get humanIds => humans.map((human) => human.documentID).toList();

  /// host の UserEntity を取得する
  @late
  Future<Document<UserEntity>> fetchHost() async => UserEntity.decode(await host.get());

  @late
  Future<List<Document<UserEntity>>> fetchHumans() async => Future.wait(
        humans.map((human) async => UserEntity.decode(await human.get())).toList(),
      );

  @late
  Future<Document<LifeRoadEntity>> fetchLifeRoad() async => LifeRoadEntity.decode(await lifeRoad.get());
}

class PlayRoomEntityField {
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
//  static const finishedAt = 'finishedAt'; // FIXME: 現状不要なのでコメントアウト. 今後要検討.
}
