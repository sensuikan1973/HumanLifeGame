import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              RaisedButton(
                onPressed: () => Navigator.of(context).pushNamed(context.read<Router>().playRoom),
                child: const Text('Go to PlayRoom'),
              ),
            ],
          ),
        ),
      );
}
