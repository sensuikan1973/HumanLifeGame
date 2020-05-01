import 'package:HumanLifeGame/models/player_action.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// ダイスを降った結果
class DiceResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SizedBox(
        width: 100,
        height: 100,
        child: Text(
          Provider.of<PlayerActionModel>(context).dice.toString(),
          key: const Key('diceResultText'),
        ),
      );
}
