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
  Size get _desktop => const Size(1440, 1024); // FIXME: 最終的には、左側のビューと右側のビューの最小サイズをトリガとして切り替える
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    if (context.select<PlayRoomNotifier, bool>((model) => model.allHumansReachedTheGoal)) {
      WidgetsBinding.instance.addPostFrameCallback((_) async => _showResult(context));
    }
    return Scaffold(
      body: screen.width >= _desktop.width ? largeScreen() : middleScreen(),
    );
  }

  Row largeScreen() => Row(
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
      );

  Column middleScreen() => Column(
        children: <Widget>[
          const Announcement(),
          const LifeEventRecords(),
          Stack(
            children: <Widget>[
              const PlayView(),
              Positioned(
                top: 0,
                right: 0,
                child: Column(
                  children: const <Widget>[
                    LifeStages(),
                    DiceResult(),
                    PlayerAction(),
                  ],
                ),
              ),
            ],
          ),
        ],
      );

  Future<void> _showResult(BuildContext context) async {
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
    await showDialog<void>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(I18n.of(context).resultAnnouncementDialogMessage),
        children: result,
      ),
    );
  }
}
