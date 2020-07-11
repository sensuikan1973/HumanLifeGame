import 'package:HumanLifeGame/api/firestore/life_event.dart';
import 'package:HumanLifeGame/api/firestore/life_road.dart';
import 'package:HumanLifeGame/api/firestore/store.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:uuid/uuid.dart';

import 'user_helper.dart';

Future<Doc<LifeRoadEntity>> createLifeRoad(
  Store store, {
  DocumentReference author,
  List<List<LifeEventEntity>> lifeEvents,
  String title,
  DateTime createdAt,
  DateTime updatedAt,
}) async {
  final collectionRef = store.collectionRef<LifeRoadEntity>();
  final entity = LifeRoadEntity(
    author: author ?? (await createUser(store)).ref,
    lifeEvents: lifeEvents ?? LifeRoadEntity.dummyLifeEvents(), // FIXME: dummy は test 固有で定義すべき
    title: title ?? Uuid().v4(),
    createdAt: createdAt ?? DateTime.now(),
    updatedAt: updatedAt ?? DateTime.now(),
  );
  final docRef = await collectionRef.add(entity);
  return Doc<LifeRoadEntity>(store, docRef.ref, entity);
}
