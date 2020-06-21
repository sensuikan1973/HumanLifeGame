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
        decoder: (snapshot) => Document(
          snapshot.reference,
          _jsonFactory<T>(snapshot.data),
        ),
        encoder: (entity) => entity.encode(),
      );

  // 関連: https://stackoverflow.com/a/55237197/10928938
  T _jsonFactory<T extends Entity>(Map<String, dynamic> json) {
    if (T == ServiceControl) return ServiceControl.fromJson(json) as T;
    throw Error(); // unexpected
  }

  @visibleForTesting
  String getCollectionId<T>() {
    if (T == ServiceControl) return 'serviceControl';
    if (T == LifeEvent) return 'lifeEvent';
    if (T == LifeEventRecord) return 'lifeEventRecord';
    if (T == LifeItem) return 'lifeItem';
    if (T == HumanLife) return 'humanLife';
    if (T == LifeStage) return 'LifeStage';
    if (T == PlayRoom) return 'playRoom';
    if (T == User) return 'user';
    throw Error(); // unexpected
  }
}
