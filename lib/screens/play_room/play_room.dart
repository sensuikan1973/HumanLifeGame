import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/play_room/play_room.dart';
import 'announcement.dart';
import 'dice_result.dart';
import 'life_event_records.dart';
import 'life_stages.dart';
import 'play_view.dart';
import 'player_action.dart';

class PlayRoom extends StatelessWidget {
  const PlayRoom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _allHumansReachedTheGoal = context.select<PlayRoomModel, bool>((model) => model.allHumansReachedTheGoal);
    if (_allHumansReachedTheGoal) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog<void>(
            context: context,
            builder: (context) {
              return const SimpleDialog(
                title: Text('ok'),
                children: <Widget>[
                  Text('Human 1'),
                  Text('Human 1'),
                  Text('Human 1'),
                  Text('Human 1'),
                ],
              );
            });
        return;
      });
    }
    return Scaffold(
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
}
