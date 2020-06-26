import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// FIXME: エラーハンドリングの実装
///
/// See: <https://firebase.google.com/docs/reference/android/com/google/firebase/auth/FirebaseAuth>
@immutable
class Auth {
  const Auth();

  FirebaseAuth get _auth => FirebaseAuth.instance;

  /// 匿名認証
  ///
  /// See: <https://firebase.google.com/docs/auth/web/anonymous-auth>
  Future<FirebaseUser> signInAnonymously() async {
    final result = await _auth.signInAnonymously();
    return result.user;
  }

  /// メール+パスワード認証(新規)
  ///
  /// See: <https://firebase.google.com/docs/auth/web/password-auth>
  Future<FirebaseUser> createUserWithEmailAndPassword({String email, String password}) async {
    final result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return result.user;
  }

  /// メール+パスワード認証
  ///
  /// See: <https://firebase.google.com/docs/auth/web/password-auth>
  Future<FirebaseUser> signInWithEmailAndPassword({String email, String password}) async {
    final result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return result.user;
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
    await _auth.sendSignInWithEmailLink(
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
  Future<FirebaseUser> signInWithEmailAndLink({String email, String link}) async {
    final result = await _auth.signInWithEmailAndLink(email: email, link: link);
    return result.user;
  }

  /// 認証用メールリンクの文字列であるかどうか
  Future<bool> isSignInWithEmailLink(String str) async => _auth.isSignInWithEmailLink(str);

  /// 現在ログインしてるユーザのオブザーバ
  ///
  /// See: <https://firebase.google.com/docs/auth/web/manage-users>
  Stream<FirebaseUser> get currentUserStream => _auth.onAuthStateChanged;

  /// 現在ログインしてるユーザ
  ///
  /// See: <https://firebase.google.com/docs/auth/web/manage-users>
  Future<FirebaseUser> get currentUser async => _auth.currentUser();

  /// サインアウトする
  Future<void> signOut() async => _auth.signOut();

  /// 開発環境専用の sign in ロジック
  ///
  /// デバッグ実行のたびに匿名アカウントが作られるのが煩わしいので、Email + Password 認証を行う.
  /// Email, Password の設定が不適切な場合は、通常通り匿名認証を行う
  Future<FirebaseUser> signInForDebug() async {
    final env = DotEnv().env;
    final email = env['EMAIL'] ?? '';
    final pass = env['PASS'] ?? '';
    if (email.isEmpty || pass.isEmpty) return null;
    FirebaseUser user;
    try {
      user = await createUserWithEmailAndPassword(email: email, password: pass);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      // See: https://github.com/FirebaseExtended/flutterfire/pull/1698
      // 上記 issue にあるように、現状 Error を広く拾って強引に解釈する他ない
      final code = e.code as String;
      if (code == 'auth/email-already-in-use') {
        user = await signInWithEmailAndPassword(email: email, password: pass);
      }
    }
    return user ?? await signInAnonymously();
  }
}
