import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../i18n/i18n.dart';
import '../../models/play_room/player_action.dart';

class PlayerAction extends StatelessWidget {
  const PlayerAction({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          width: 100,
          height: 100,
          child: FlatButton(
            key: const Key('playerActionDiceRollButton'),
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: () {
              Provider.of<PlayerActionModel>(context, listen: false).rollDice();
            },
            child: Text(
              I18n.of(context).rollDice,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      );
}
