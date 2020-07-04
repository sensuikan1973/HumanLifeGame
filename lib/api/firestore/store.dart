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

  CollectionRef<T, Document<T>> collectionRef<T extends Entity>([String parent]) => CollectionRef(
        firestore.collection(parent == null ? getCollectionId<T>() : '$parent/${getCollectionId<T>()}'),
        decoder: (snapshot) => _decode<T>(snapshot),
        encoder: (entity) => entity.encode(),
      );

  CollectionGroup<T, Document<T>> collectionGroupRef<T extends Entity>(String path) => CollectionGroup(
        path: path,
        decoder: (snapshot) => _decode<T>(snapshot),
        encoder: (entity) => entity.encode(),
      );

  DocumentRef<T, Document<T>> docRef<T extends Entity>(String documentId) => DocumentRef(
        collectionRef: collectionRef<T>(),
        id: documentId,
      );

  // 関連: https://stackoverflow.com/a/55237197/10928938
  Document<T> _decode<T extends Entity>(DocumentSnapshot snapshot) {
    if (T == ServiceControlEntity) return ServiceControlEntity.decode(snapshot) as Document<T>;
    if (T == PlayRoomEntity) return PlayRoomEntity.decode(snapshot) as Document<T>;
    if (T == UserEntity) return UserEntity.decode(snapshot) as Document<T>;
    if (T == LifeRoadEntity) return LifeRoadEntity.decode(snapshot) as Document<T>;
    if (T == LifeStageEntity) return LifeStageEntity.decode(snapshot) as Document<T>;
    if (T == LifeEventRecordEntity) return LifeEventRecordEntity.decode(snapshot) as Document<T>;
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
