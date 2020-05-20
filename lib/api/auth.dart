import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/common/user.dart';

// FIXME: エラーハンドリングの実装
// See: https://firebase.google.com/docs/reference/android/com/google/firebase/auth/FirebaseAuth
@immutable
class Auth {
  final _auth = FirebaseAuth.instance;

  /// 匿名認証
  /// See: https://firebase.google.com/docs/auth/web/anonymous-auth
  Future<UserModel> signInAnonymously() async {
    final result = await _auth.signInAnonymously();
    return _toModel(result.user);
  }

  /// 認証リンクをメール送信
  /// See: https://firebase.google.com/docs/auth/web/email-link-auth?hl=ja#send_an_authentication_link_to_the_users_email_address
  Future<void> sendSignInLinkToEmail({String url}) async {
    final user = await currentUser;
    if (user == null || user.email.isEmpty) return;

    // See: https://firebase.google.com/docs/auth/web/passing-state-in-email-actions
    // NOTE: 現状 ios, android アプリは考えてない
    await _auth.sendSignInWithEmailLink(
      email: user.email,
      url: url,
      iOSBundleID: null,
      handleCodeInApp: null,
      androidMinimumVersion: null,
      androidPackageName: null,
      androidInstallIfNotAvailable: null,
    );
  }

  /// メールリンク認証
  /// See: https://firebase.google.com/docs/auth/web/email-link-auth
  Future<UserModel> signInWithEmailAndLink({String email, String link}) async {
    final result = await _auth.signInWithEmailAndLink(email: email, link: link);
    return _toModel(result.user);
  }

  /// 現在ログインしてるユーザのオブザーバ
  /// See: https://firebase.google.com/docs/auth/web/manage-users
  Stream<UserModel> get currentUserStream => _auth.onAuthStateChanged.asyncMap(_toModel);

  /// 現在ログインしてるユーザ
  /// See: https://firebase.google.com/docs/auth/web/manage-users
  Future<UserModel> get currentUser async {
    final user = await _auth.currentUser();
    return _toModel(user);
  }

  Future<void> signOut() async => _auth.signOut();

  UserModel _toModel(FirebaseUser user) => UserModel(
        id: user.uid,
        name: user.displayName,
        email: user.email,
        // TODO: 他に必要な属性が無いか検討
      );
}
