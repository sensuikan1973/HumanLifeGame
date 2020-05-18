import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// FIXME: 仮実装
class SignIn extends StatelessWidget {
  SignIn({Key key}) : super(key: key);

  final _uid = ValueNotifier<String>(' ');

  Future<void> signIn() async {
    final auth = FirebaseAuth.instance;
    final result = await auth.signInAnonymously();
    _uid.value = result.user.uid;
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          FlatButton(
            onPressed: signIn,
            color: Colors.blueGrey,
            child: const Text('Sign in Anonymously'),
          ),
          ValueListenableBuilder<String>(
            valueListenable: _uid,
            builder: (_, uid, __) => Text('uid: $uid'),
          ),
        ],
      );
}
