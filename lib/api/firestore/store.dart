import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';

import 'entity.dart';
import 'service_control.dart';

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
        encoder: (entity) => replacingTimestamp(json: entity.toJson()),
      );

  // 関連: https://stackoverflow.com/a/55237197/10928938
  T _jsonFactory<T extends Entity>(Map<String, dynamic> json) {
    if (T == ServiceControl) return ServiceControl.fromJson(json) as T;
    return null;
  }

  @visibleForTesting
  String getCollectionId<T>() {
    if (T == ServiceControl) return 'serviceControl';
    return '';
  }
}
