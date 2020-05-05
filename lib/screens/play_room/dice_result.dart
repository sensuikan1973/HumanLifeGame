import 'package:HumanLifeGame/models/play_room/player_action.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// ダイスを降った結果
class DiceResult extends StatelessWidget {
  const DiceResult({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 100,
        height: 100,
        child: Text(
          Provider.of<PlayerActionModel>(context).roll.toString(),
          key: const Key('diceResultText'),
        ),
      );
}
