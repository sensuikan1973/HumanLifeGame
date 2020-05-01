import 'package:HumanLifeGame/models/player_action.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// ダイスを降った結果
class DiceResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SizedBox(
        width: 100,
        height: 100,
        child: Consumer<PlayerActionModel>(
          builder: (context, model, child) => Text(
            '${model.dice.toString()}',
            key: const Key('diceResultText'),
          ),
        ),
      );
}
