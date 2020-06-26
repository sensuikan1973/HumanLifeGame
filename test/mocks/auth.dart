import 'package:HumanLifeGame/api/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';

// ignore: must_be_immutable
class MockAuth extends Mock implements Auth {}

class MockFirebaseUser extends Mock implements FirebaseUser {}
