import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'life_road.dart';
import 'store.dart';
import 'store_entity.dart';
import 'user.dart';

part 'play_room.freezed.dart';
part 'play_room.g.dart';

/// TODO: プレイ終了後に削除してもいいモノなので、DocRef で持ってるやつは Value で十分じゃないかを検討.
/// TODO: announcement はクライアントサイド完結想定だが、必要になったら追加.
@freezed
abstract class PlayRoomEntity implements _$PlayRoomEntity, StoreEntity {
  factory PlayRoomEntity({
    @required @DocumentReferenceConverter() DocumentReference host,
    @required @DocumentReferenceListConverter() List<DocumentReference> humans,
    @required @DocumentReferenceConverter() DocumentReference lifeRoad,
    @required String currentTurnHumanId,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
    @Default('') String title,
  }) = _PlayRoomEntity;
  PlayRoomEntity._();

  factory PlayRoomEntity.fromJson(Map<String, dynamic> json) => _$PlayRoomEntityFromJson(json);

  @override
  Map<String, dynamic> encode() => replacingTimestamp(json: toJson());

  static Doc<PlayRoomEntity> decode(Store store, DocumentSnapshot snapshot) => Doc<PlayRoomEntity>(
        store,
        snapshot.reference,
        PlayRoomEntity.fromJson(snapshot.data),
      );

  /// humans の document ID List
  List<String> get humanIds => humans.map((human) => human.documentID).toList();

  /// host の UserEntity を取得する
  Future<Doc<UserEntity>> fetchHost(Store store) async => UserEntity.decode(store, await host.get());

  Future<List<Doc<UserEntity>>> fetchHumans(Store store) async => Future.wait(
        humans.map((human) async => UserEntity.decode(store, await human.get())).toList(),
      );

  @late
  Future<Doc<LifeRoadEntity>> fetchLifeRoad(Store store) async => LifeRoadEntity.decode(store, await lifeRoad.get());
}

enum PlayRoomEntityField {
  /// 主催者(user)
  host,

  /// 部屋のタイトル
  title,

  /// 人生を歩む参加者(human)
  humans,

  /// 歩む対象となる人生
  lifeRoad,

  /// 参加者全員の LifeEvent 履歴
  everyLifeEventRecords,

  /// 参加者それぞれの人生の進捗
  lifeStages,

  /// 現在手番の human id
  currentTurnHumanId,
}

extension PlayRoomEntityFieldExtension on PlayRoomEntityField {
  String get name => describeEnum(this);
}
