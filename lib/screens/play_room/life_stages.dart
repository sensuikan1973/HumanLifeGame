import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/common/human.dart';
import '../../models/play_room/life_stage.dart';
import '../../models/play_room/play_room.dart';

/// Humanの状況を表示
class LifeStages extends StatelessWidget {
  const LifeStages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        child: SizedBox(
          width: 300,
          height: 500,
          child: _lifeStages(context),
        ),
      );

  Column _lifeStages(BuildContext context) {
    final lifeStages = context.select<PlayRoomModel, List<LifeStageModel>>((model) => model.lifeStages);
    final currentPlayer = context.select<PlayRoomModel, HumanModel>((model) => model.currentPlayer);
    final humanNames = <Widget>[
      for (final lifeStage in lifeStages)
        Row(
          children: [
            SizedBox(
              width: 15,
              height: 15,
              child: (currentPlayer == lifeStage.human) ? dot() : null,
            ),
            Text(lifeStage.human.name),
          ],
        ),
    ];

    return Column(
      children: humanNames,
    );
  }

  ColoredBox dot() => ColoredBox(color: Colors.black);
}
