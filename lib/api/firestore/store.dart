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

  CollectionRef<T, Document<T>> collectionRef<T extends Entity>() => CollectionRef(
        firestore.collection(getCollectionId<T>()),
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
    throw Error(); // unexpected
  }

  @visibleForTesting
  String getCollectionId<T>() {
    if (T == ServiceControlEntity) return 'serviceControl';
    if (T == LifeEventEntity) return 'lifeEvent';
    if (T == LifeEventRecordEntity) return 'lifeEventRecord';
    if (T == LifeItemEntity) return 'lifeItem';
    if (T == HumanLife) return 'humanLife';
    if (T == LifeStageEntity) return 'LifeStage';
    if (T == PlayRoomEntity) return 'playRoom';
    if (T == UserEntity) return 'user';
    throw Error(); // unexpected
  }
}
