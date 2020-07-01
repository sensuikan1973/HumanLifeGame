import 'package:HumanLifeGame/api/firestore/store.dart';
import 'package:HumanLifeGame/api/firestore/user.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:uuid/uuid.dart';

Future<Document<UserEntity>> createUser(Store store, {String uid}) async {
  final docId = uid ?? Uuid().v4();
  final userDocRef = store.docRef<UserEntity>(docId);
  await userDocRef.set(UserEntity(
    uid: docId,
    displayName: docId.substring(0, 6), // NOTE: 雑に頭6文字
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ));
  return userDocRef.get();
}
