import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/auth.dart';

// FIXME: 仮実装
class SignIn extends StatelessWidget {
  SignIn({Key key}) : super(key: key);

  final _uid = ValueNotifier<String>(' ');

  @override
  Widget build(BuildContext context) => Column(
        children: [
          FlatButton(
            onPressed: () async {
              final user = await context.read<Auth>().signInAnonymously();
              _uid.value = user.id;
            },
            color: Colors.blueGrey,
            child: const Text('Sign in Anonymously'),
          ),
          ValueListenableBuilder<String>(
            valueListenable: _uid,
            builder: (_, uid, __) => Text('uid: $uid'),
          ),
          const Divider(thickness: 2),
          FlatButton(
            onPressed: () async => context.read<Auth>().signOut(),
            color: Colors.red,
            child: const Text('Sign out'),
          ),
        ],
      );
}
