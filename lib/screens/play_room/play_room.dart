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

  Size get _announcement => const Size(1050, 50);
  Size get _lifeEventRecords => const Size(1050, 50);
  Size get _playView => const Size(1050, 750);

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    if (context.select<PlayRoomNotifier, bool>((model) => model.allHumansReachedTheGoal)) {
      WidgetsBinding.instance.addPostFrameCallback((_) async => _showResult(context));
    }
    return Scaffold(
      body: screen.width >= _desktop.width ? _largeScreen(screen) : _middleScreen(screen),
    );
  }

  Row _largeScreen(Size screen) => Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                width: _announcement.width,
                height: _announcement.height,
                child: const Announcement(),
              ),
              if (screen.height > _announcement.height + _lifeEventRecords.height + _playView.height)
                Expanded(
                  child: SizedBox(
                    width: _lifeEventRecords.width,
                    child: const LifeEventRecords(),
                  ),
                ),
              SizedBox(
                width: _playView.width,
                height: _playView.height,
                child: const PlayView(),
              ),
            ],
          ),
          Expanded(
            child: Column(
              children: const <Widget>[
                SizedBox(
                  height: 500,
                  child: LifeStages(),
                ),
                SizedBox(
                  height: 100,
                  child: DiceResult(),
                ),
                SizedBox(
                  height: 300,
                  child: PlayerAction(),
                ),
              ],
            ),
          ),
        ],
      );

  Column _middleScreen(Size screen) => Column(
        children: <Widget>[
          SizedBox(
            width: screen.width < _announcement.width ? screen.width : _announcement.width,
            height: _announcement.height,
            child: const Announcement(),
          ),
          if (screen.height > _announcement.height + _lifeEventRecords.height + _playView.height)
            Expanded(
              child: SizedBox(
                width: screen.width < _lifeEventRecords.width ? screen.width : _lifeEventRecords.width,
                child: const LifeEventRecords(),
              ),
            ),
          Stack(
            children: <Widget>[
              SizedBox(
                width: screen.width < _playView.width ? screen.width : _playView.width,
                height: _playView.height,
                child: const PlayView(),
              ),
              Positioned(
                right: 0,
                child: SizedBox(
                  height: 750,
                  child: Column(
                    children: const <Widget>[
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          width: 200,
                          child: LifeStages(),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 200,
                          child: DiceResult(),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 200,
                          child: PlayerAction(),
                        ),
                      ),
                    ],
                  ),
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
