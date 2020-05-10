import 'package:flutter/material.dart';

import 'announcement.dart';
import 'dice_result.dart';
import 'life_event_records.dart';
import 'life_stages.dart';
import 'play_view.dart';
import 'player_action.dart';

class PlayRoom extends StatelessWidget {
  const PlayRoom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Row(
          children: <Widget>[
            Column(
              children: const <Widget>[
                Announcement(),
                LifeEventRecords(),
                PlayView(),
              ],
            ),
            Column(
              children: const <Widget>[
                LifeStages(),
                DiceResult(),
                PlayerAction(),
              ],
            ),
          ],
        ),
      );
}
