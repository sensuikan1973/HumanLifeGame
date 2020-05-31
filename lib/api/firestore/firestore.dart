import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';

@immutable
class Store {
  const Store(this.firestore);

  final Firestore firestore;
}
