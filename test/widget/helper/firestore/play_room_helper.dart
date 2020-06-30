import 'package:HumanLifeGame/api/firestore/life_road.dart';
import 'package:HumanLifeGame/api/firestore/play_room.dart';
import 'package:HumanLifeGame/api/firestore/store.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:uuid/uuid.dart';

import 'user_helper.dart';

Future<Document<PlayRoomEntity>> createPlayRoom(
  Store store, {
  DocumentReference host,
  String title,
  List<DocumentReference> humans,
  DocumentReference lifeRoad,
  String currentTurnHumanId,
  DateTime createdAt,
  DateTime updatedAt,
}) async {
  final collectionRef = store.collectionRef<PlayRoomEntity>();
  var hostRef = host;
  if (hostRef == null) {
    final user = await createUser(store);
    hostRef = host ?? user.ref;
  }
  final docRef = await collectionRef.add(PlayRoomEntity(
    host: hostRef,
    humans: [hostRef],
    lifeRoad: lifeRoad ?? store.docRef<LifeRoadEntity>(Uuid().v4()).ref,
    title: Uuid().v4(),
    currentTurnHumanId: hostRef.documentID,
    createdAt: createdAt ?? DateTime.now(),
    updatedAt: updatedAt ?? DateTime.now(),
  ));
  return docRef.get();
}
