import 'package:firebase_auth/firebase_auth.dart';

import '../models/common/user.dart';

// FIXME: エラーハンドリングの実装
// See: https://firebase.google.com/docs/reference/android/com/google/firebase/auth/FirebaseAuth
class Auth {
  final _auth = FirebaseAuth.instance;

  /// 匿名認証
  /// See: https://firebase.google.com/docs/auth/web/anonymous-auth
  Future<UserModel> signInAnonymously() async {
    final result = await _auth.signInAnonymously();
    return _toModel(result.user);
  }

  /// メールリンク認証
  /// See: https://firebase.google.com/docs/auth/web/email-link-auth
  Future<UserModel> signInWithEmailAndLink({String email, String link}) async {
    final result = await _auth.signInWithEmailAndLink(email: email, link: link);
    return _toModel(result.user);
  }

  /// 現在ログインしてるユーザ
  /// オブザーバを使うことで、非ログイン状態のハンドリングをしやすくする
  /// See: https://firebase.google.com/docs/auth/web/manage-users
  Stream<UserModel> get currentUser => _auth.onAuthStateChanged.asyncMap(_toModel);

  Future<void> signOut() async => _auth.signOut();

  UserModel _toModel(FirebaseUser user) => UserModel(
        id: user.uid,
        name: user.displayName,
        // TODO: 他に必要な属性が無いか検討
      );
}
