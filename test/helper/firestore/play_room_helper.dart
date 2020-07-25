import 'package:HumanLifeGame/api/firestore/play_room.dart';
import 'package:HumanLifeGame/api/firestore/store.dart';
import 'package:HumanLifeGame/api/firestore/user.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:uuid/uuid.dart';

import 'life_road_helper.dart';
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
  final userDoc = await createUser(store);
  final hostRef = host ?? userDoc.ref;
  final room = PlayRoomEntity(
    host: hostRef,
    humans: host == null ? [hostRef] : humans,
    lifeRoad: lifeRoad ?? (await createLifeRoad(store)).ref,
    title: title ?? Uuid().v4(),
    currentTurnHumanId: hostRef.documentID,
    createdAt: createdAt ?? DateTime.now(),
    updatedAt: updatedAt ?? DateTime.now(),
  );

  final batch = store.firestore.batch();
  final roomDocRef = collectionRef.docRef();
  await roomDocRef.set(room, batch: batch);
  final userDocRef = store.docRef<UserEntity>(userDoc.id);
  await userDocRef.update(
    userDoc.entity.copyWith(joinPlayRoom: roomDocRef.ref),
    batch: batch,
  );
  await batch.commit();
  return Doc<PlayRoomEntity>(store, roomDocRef.ref, room);
}
