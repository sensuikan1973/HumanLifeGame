import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/models/play_room/player_action.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayerAction extends StatelessWidget {
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
