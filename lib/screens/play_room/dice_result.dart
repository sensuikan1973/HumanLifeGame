import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/play_room/player_action.dart';

/// ダイスを降った結果
class DiceResult extends StatelessWidget {
  const DiceResult({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        child: SizedBox(
          width: 300,
          height: 100,
          child: Text(
            context.select<PlayerActionNotifier, int>((model) => model.roll).toString(),
            key: const Key('diceResultText'),
          ),
        ),
      );
}
