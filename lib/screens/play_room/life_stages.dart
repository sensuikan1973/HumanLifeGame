import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/play_room/play_room.dart';
import 'human.dart';

/// Humanの状況を表示
class LifeStages extends StatelessWidget {
  const LifeStages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 300,
        height: 500,
        child: _lifeStages(context),
      );

  Column _lifeStages(BuildContext context) {
    final _lifeStages = Provider.of<PlayRoomModel>(context).lifeStages;
    final _currentPlayer = Provider.of<PlayRoomModel>(context).currentPlayer;
    final _humanNames = <Widget>[
      for (final lifeStage in _lifeStages)
        Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: (_currentPlayer == lifeStage.human) ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Text(lifeStage.human.name),
          ],
        ),
    ];

    return Column(
      children: _humanNames,
    );
  }
}
