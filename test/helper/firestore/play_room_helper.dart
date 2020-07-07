import 'package:HumanLifeGame/api/firestore/life_road.dart';
import 'package:HumanLifeGame/api/firestore/play_room.dart';
import 'package:HumanLifeGame/api/firestore/store.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:uuid/uuid.dart';

import 'user_helper.dart';

Future<Doc<PlayRoomEntity>> createPlayRoom(
  Store store, {
  DocumentReference host,
  String title,
  List<DocumentReference> humans,
  DocumentReference lifeRoad,
  String currentTurnHumanId,
  DateTime createdAt,
  DateTime updatedAt,
}) async {
  assert(host == null || humans.contains(host));

  final collectionRef = store.collectionRef<PlayRoomEntity>();
  final hostRef = host ?? (await createUser(store)).ref;
  final entity = PlayRoomEntity(
    host: hostRef,
    humans: host == null ? [hostRef] : humans,
    lifeRoad: lifeRoad ?? store.docRef<LifeRoadEntity>(Uuid().v4()).ref,
    title: title ?? Uuid().v4(),
    currentTurnHumanId: hostRef.documentID,
    createdAt: createdAt ?? DateTime.now(),
    updatedAt: updatedAt ?? DateTime.now(),
  );
  final docRef = await collectionRef.add(entity);
  // TODO: user の joinPlayRoom を batch write で更新
  return Doc<PlayRoomEntity>(store, docRef.ref, entity);
}
