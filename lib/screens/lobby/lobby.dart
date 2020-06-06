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
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(title: const Text('Human Life Game')),
        ),
        body: Center(
          child: Row(
            children: [
              playView(context),
              createHumanLifeGame(),
            ],
          ),
        ),
      );

  SizedBox playView(BuildContext context) {
    return SizedBox(
      width: 720,
      height: 1020,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          roomTitle(),
          Row(
            children: [
              roomImage(),
              Column(
                children: [
                  playingHumans(),
                  FutureBuilder<UserModel>(
                    future: _signIn(context.watch<Auth>()),
                    builder: (context, snap) {
                      if (snap.hasError) return const Text('Oops');
                      if (snap.connectionState == ConnectionState.waiting) return const Text('waiting...');
                      if (snap.hasData) return Text(snap.data.id);
                      return const Text('You must sign in');
                    },
                  ),
                ],
              ),
            ],
          ),
          RaisedButton(
            onPressed: () => Navigator.of(context).pushNamed(context.read<Router>().playRoom),
            child: const Text('Join the game'),
          ),
        ],
      ),
    );
  }

  SizedBox roomTitle() {
    return SizedBox(
      width: 720,
      height: 40,
      child: ColoredBox(
        color: Colors.grey[100],
        child: const Text('Room 1'),
      ),
    );
  }

  SizedBox roomImage() {
    return SizedBox(
      width: 300,
      height: 200,
      child: Image.asset(
        'images/play_view_background.jpg',
        fit: BoxFit.fitHeight,
      ),
    );
  }

  SizedBox playingHumans() {
    return SizedBox(
      width: 420,
      height: 170,
      child: Column(
        children: [
          const Text('Human 1'),
          const Text('Human 2'),
        ],
      ),
    );
  }

  SizedBox createHumanLifeGame() {
    return const SizedBox(
      width: 720,
      height: 1020,
      child: Center(child: Text('開発中')),
    );
  }
}
