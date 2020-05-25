import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/auth.dart';
import '../../models/common/user.dart';
import '../../router.dart';

/// FIXME: ロジックべた書き
class Lobby extends StatelessWidget {
  const Lobby({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<UserModel>(
                future: context.watch<Auth>().currentUser,
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
