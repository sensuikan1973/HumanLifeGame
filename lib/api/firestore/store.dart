import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';

import 'entity.dart';
import 'life_event.dart';
import 'life_event_record.dart';
import 'life_item.dart';
import 'life_road.dart';
import 'life_stage.dart';
import 'play_room.dart';
import 'service_control.dart';
import 'user.dart';

@immutable
class Store {
  const Store(this.firestore);

  final Firestore firestore;

  CollectionRef<T, Doc<T>> collectionRef<T extends StoreEntity>([String parent]) => CollectionRef(
        firestore.collection(parent == null ? getCollectionId<T>() : '$parent/${getCollectionId<T>()}'),
        decoder: (snapshot) => _decode<T>(snapshot),
        encoder: (entity) => entity.encode(),
      );

  CollectionGroup<T, Doc<T>> collectionGroupRef<T extends StoreEntity>(String path) => CollectionGroup(
        path: path,
        decoder: (snapshot) => _decode<T>(snapshot),
        encoder: (entity) => entity.encode(),
      );

  DocumentRef<T, Doc<T>> docRef<T extends StoreEntity>(String documentId) => DocumentRef(
        collectionRef: collectionRef<T>(),
        id: documentId,
      );

  // 関連: https://stackoverflow.com/a/55237197/10928938
  Doc<T> _decode<T extends StoreEntity>(DocumentSnapshot snapshot) {
    if (T == ServiceControlEntity) return ServiceControlEntity.decode(this, snapshot) as Doc<T>;
    if (T == PlayRoomEntity) return PlayRoomEntity.decode(this, snapshot) as Doc<T>;
    if (T == UserEntity) return UserEntity.decode(this, snapshot) as Doc<T>;
    if (T == LifeRoadEntity) return LifeRoadEntity.decode(this, snapshot) as Doc<T>;
    if (T == LifeStageEntity) return LifeStageEntity.decode(this, snapshot) as Doc<T>;
    if (T == LifeEventRecordEntity) return LifeEventRecordEntity.decode(this, snapshot) as Doc<T>;
    throw Exception('unexpected Entity Type: $T');
  }

  @visibleForTesting
  String getCollectionId<T>() {
    if (T == ServiceControlEntity) return 'serviceControl';
    if (T == LifeEventEntity) return 'lifeEvent';
    if (T == LifeEventRecordEntity) return 'lifeEventRecord';
    if (T == LifeItemEntity) return 'lifeItem';
    if (T == LifeRoadEntity) return 'lifeRoad';
    if (T == LifeStageEntity) return 'LifeStage';
    if (T == PlayRoomEntity) return 'playRoom';
    if (T == UserEntity) return 'user';
    throw Exception('unexpected Entity Type: $T');
  }
}

@immutable
class Doc<T> extends Document<T> {
  const Doc(this.store, DocumentReference ref, T entity) : super(ref, entity);

  final Store store;
}
