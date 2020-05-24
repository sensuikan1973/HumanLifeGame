import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/play_room/play_room.dart';

/// ダイスを降った結果
class DiceResult extends StatelessWidget {
  const DiceResult({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        child: Center(
          child: Text(
            context.select<PlayRoomNotifier, int>((model) => model.value.roll).toString(),
            key: const Key('diceResultText'),
          ),
        ),
      );
}
