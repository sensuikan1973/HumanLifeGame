import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/common/human.dart';
import '../../models/play_room/life_stage.dart';
import '../../models/play_room/play_room.dart';

import '../common/human.dart';

/// Humanの状況を表示
class LifeStages extends StatelessWidget {
  const LifeStages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        child: _lifeStages(context),
      );

  Column _lifeStages(BuildContext context) {
    final lifeStages = context.select<PlayRoomNotifier, List<LifeStageModel>>((model) => model.lifeStages);
    final currentPlayer = context.select<PlayRoomNotifier, HumanModel>((model) => model.currentPlayer);
    final humanNames = <Widget>[
      for (var i = 0; i < lifeStages.length; ++i)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 30,
              height: 30,
              child: (currentPlayer == lifeStages[i].human) ? currentPlayerSelector() : null,
            ),
            Human(lifeStages[i].human, i),
            Text(lifeStages[i].human.name),
            const Text(', 💵: '), // FIXME: 仮テキスト
            Text(lifeStages[i].totalMoney.toString()),
          ],
        ),
    ];

    return Column(
      children: humanNames,
    );
  }

  Icon currentPlayerSelector() => const Icon(Icons.chevron_right, color: Colors.pink);
}
