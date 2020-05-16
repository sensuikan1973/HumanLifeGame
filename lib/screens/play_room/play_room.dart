import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../i18n/i18n.dart';
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
    final allHumansReachedTheGoal = context.select<PlayRoomNotifier, bool>((model) => model.allHumansReachedTheGoal);

    if (allHumansReachedTheGoal) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showResult(context);
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

  void _showResult(BuildContext context) {
    final lifeStages = context.read<PlayRoomNotifier>().lifeStages;
    final result = <Widget>[
      for (final lifeStage in lifeStages)
        Row(
          children: [
            Text(lifeStage.human.name),
            const Text(', 💵: '), // FIXME: 仮テキスト
            Text(lifeStage.totalMoney.toString()),
          ],
        ),
    ];
    showDialog<void>(
        context: context,
        builder: (context) => SimpleDialog(
              title: Text(I18n.of(context).resultAnnouncementDialogMessage),
              children: result,
            ));
    return;
  }
}
