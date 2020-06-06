import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/common/user.dart';

/// FIXME: エラーハンドリングの実装
///
/// See: <https://firebase.google.com/docs/reference/android/com/google/firebase/auth/FirebaseAuth>
@immutable
class Auth {
  const Auth();

  /// 匿名認証
  ///
  /// See: <https://firebase.google.com/docs/auth/web/anonymous-auth>
  Future<UserModel> signInAnonymously() async {
    final result = await FirebaseAuth.instance.signInAnonymously();
    return _toModel(result.user);
  }

  /// メール+パスワード認証(新規)
  ///
  /// See: <https://firebase.google.com/docs/auth/web/password-auth>
  Future<UserModel> createUserWithEmailAndPassword({String email, String password}) async {
    final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    return _toModel(result.user);
  }

  /// メール+パスワード認証
  ///
  /// See: <https://firebase.google.com/docs/auth/web/password-auth>
  Future<UserModel> signInWithEmailAndPassword({String email, String password}) async {
    final result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return _toModel(result.user);
  }

  /// 認証リンクをメール送信
  ///
  /// See: <https://firebase.google.com/docs/auth/web/email-link-auth#send_anFirebaseAuth.instanceentication_link_to_the_users_email_address>
  Future<void> sendSignInLinkToEmail({
    @required String email,
    @required String url,
  }) async {
    // See: https://firebase.google.com/docs/auth/web/passing-state-in-email-actions
    // FIXME: 現状 ios, android アプリは考えてないが、必須パラメータなのでテキトーに指定してる
    await FirebaseAuth.instance.sendSignInWithEmailLink(
      email: email,
      url: url,
      handleCodeInApp: true,
      iOSBundleID: 'human-life-game.example.com',
      androidMinimumVersion: '24',
      androidPackageName: 'human-life-game.example.com',
      androidInstallIfNotAvailable: false,
    );
  }

  /// メールリンク認証を行う
  ///
  /// See: <https://firebase.google.com/docs/auth/web/email-link-auth>
  Future<UserModel> signInWithEmailAndLink({String email, String link}) async {
    final result = await FirebaseAuth.instance.signInWithEmailAndLink(email: email, link: link);
    return _toModel(result.user);
  }

  /// 認証用メールリンクの文字列であるかどうか
  Future<bool> isSignInWithEmailLink(String str) async => FirebaseAuth.instance.isSignInWithEmailLink(str);

  /// 現在ログインしてるユーザのオブザーバ
  ///
  /// See: <https://firebase.google.com/docs/auth/web/manage-users>
  Stream<UserModel> get currentUserStream =>
      FirebaseAuth.instance.onAuthStateChanged.asyncMap((user) => user != null ? _toModel(user) : null);

  /// 現在ログインしてるユーザ
  ///
  /// See: <https://firebase.google.com/docs/auth/web/manage-users>
  Future<UserModel> get currentUser async {
    final user = await FirebaseAuth.instance.currentUser();
    return user != null ? _toModel(user) : null;
  }

  Future<void> signOut() async => FirebaseAuth.instance.signOut();

  UserModel _toModel(FirebaseUser user) => UserModel(
        id: user.uid,
        name: user.displayName,
        isAnonymous: user.isAnonymous,
        email: user.email,
        // TODO: 他に必要な属性が無いか検討
      );
}
