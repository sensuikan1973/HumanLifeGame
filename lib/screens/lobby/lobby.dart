import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import '../../api/auth.dart';
import '../../models/common/user.dart';
import '../../router.dart';

/// FIXME: ロジックべた書き
class Lobby extends StatelessWidget {
  const Lobby({Key key}) : super(key: key);

  /// Only for Debug Mode
  Future<UserModel> _signInOrCreateWithEmailAndPassForDev(Auth auth) async {
    final env = DotEnv().env;
    final email = env['EMAIL'] ?? '';
    final pass = env['PASS'] ?? '';
    if (email.isEmpty || pass.isEmpty) return null;
    UserModel user;
    try {
      user = await auth.createUserWithEmailAndPassword(email: email, password: pass);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      // See: https://github.com/FirebaseExtended/flutterfire/pull/1698
      // 上記 issue にあるように、現状 Error を広く拾って強引に解釈する他ない
      final code = e.code as String;
      if (code == 'auth/email-already-in-use') {
        user = await auth.signInWithEmailAndPassword(email: email, password: pass);
      }
    }
    return user;
  }

  Future<UserModel> _signIn(Auth auth) async {
    var user = await auth.currentUser;
    if (user != null) return user;
    if (!kReleaseMode) user = await _signInOrCreateWithEmailAndPassForDev(auth);
    return user ?? await auth.signInAnonymously();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<UserModel>(
                future: _signIn(context.watch<Auth>()),
                builder: (context, snap) {
                  if (snap.hasError) return const Text('Oops');
                  if (snap.hasData) return Text(snap.data.id);
                  return const Text('You must sign in');
                },
              ),
              RaisedButton(
                onPressed: () => Navigator.of(context).pushNamed(context.read<Router>().playRoom),
                child: const Text('Go to PlayRoom'),
              ),
            ],
          ),
        ),
      );
}
