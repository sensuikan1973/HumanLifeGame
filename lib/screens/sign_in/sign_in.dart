import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// FIXME: 仮実装
class SignIn extends StatelessWidget {
  SignIn({Key key}) : super(key: key);

  final _auth = FirebaseAuth.instance;
  final _uid = ValueNotifier<String>(' ');

  Future<void> _signIn() async {
    var user = await _auth.currentUser();
    if (user == null) {
      final result = await _auth.signInAnonymously();
      user = result.user;
    }
    _uid.value = user.uid;
  }

  Future<void> _signOut() async {
    await _auth.signOut();
    final user = await _auth.currentUser();
    _uid.value = user?.uid ?? ' ';
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          FlatButton(
            onPressed: _signIn,
            color: Colors.blueGrey,
            child: const Text('Sign in Anonymously'),
          ),
          ValueListenableBuilder<String>(
            valueListenable: _uid,
            builder: (_, uid, __) => Text('uid: $uid'),
          ),
          const Divider(thickness: 2),
          FlatButton(
            onPressed: _signOut,
            color: Colors.red,
            child: const Text('Sign out'),
          ),
        ],
      );
}
