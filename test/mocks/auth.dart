import 'package:HumanLifeGame/api/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';

// ignore: must_be_immutable
class MockAuth extends Mock implements Auth {
  MockAuth([MockFirebaseUser user]) {
    if (user != null) {
      when(currentUser).thenAnswer((_) async => user);
      when(currentUserStream).thenAnswer((_) => Stream.fromIterable([user]));
    }
  }
}

class MockFirebaseUser extends Mock implements FirebaseUser {
  @override
  String get uid => 'dummy uid';

  @override
  String get displayName => 'dummy displayName';
}
