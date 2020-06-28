import 'dart:math';

import 'package:HumanLifeGame/api/firestore/store.dart';
import 'package:HumanLifeGame/api/firestore/user.dart';
import 'package:firestore_ref/firestore_ref.dart';

Future<Document<UserEntity>> createUser(Store store, {String uid}) async {
  final docId = uid ?? Random().nextInt(1000).toString();
  final userDocRef = store.docRef<UserEntity>(docId);
  await userDocRef.set(UserEntity(
    uid: docId,
    displayName: docId,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ));
  return userDocRef.get();
}
