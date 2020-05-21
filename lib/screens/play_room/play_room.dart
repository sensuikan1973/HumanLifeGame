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

class PlayRoom extends StatefulWidget {
  const PlayRoom({Key key}) : super(key: key);

  @override
  PlayRoomState createState() => PlayRoomState();
}

class PlayRoomState extends State<PlayRoom> {
  bool isDisplayedResult = false;

  Size get _desktop => const Size(1440, 1024); // FIXME: 最終的には、左側のビューと右側のビューの最小サイズをトリガとして切り替える
  Size get _announcement => const Size(1050, 50);
  Size get _lifeEventRecords => const Size(1050, 50);
  Size get _playView => const Size(1050, 750);
  Size get _lifeStages => const Size(200, 500);
  Size get _diceResult => const Size(200, 100);
  Size get _playerAction => const Size(200, 300);
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    if (context.select<PlayRoomNotifier, bool>((model) => model.allHumansReachedTheGoal)) {
      if (!isDisplayedResult) {
        isDisplayedResult = true;
        WidgetsBinding.instance.addPostFrameCallback((_) async => _showResult(context));
      }
    }
    return Scaffold(
      body: screen.width >= _desktop.width ? _largeScreen(screen) : _middleScreen(screen),
    );
  }

  Row _largeScreen(Size screen) {
    final playView = Size(
      _playView.width,
      screen.height < _playView.height + _announcement.height ? screen.height - _announcement.height : _playView.height,
    );
    return Row(
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
              width: playView.width,
              height: playView.height,
              child: const PlayView(),
            ),
          ],
        ),
        Expanded(
          child: SizedBox(
            height: _playView.height + _diceResult.height + _playerAction.height,
            child: Column(
              children: const <Widget>[
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    child: LifeStages(),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    child: DiceResult(),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    child: PlayerAction(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column _middleScreen(Size screen) {
    final playView = Size(
      screen.width < _playView.width ? screen.width : _playView.width,
      screen.height < _playView.height + _announcement.height ? screen.height - _announcement.height : _playView.height,
    );
    return Column(
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
              width: playView.width,
              height: playView.height,
              child: const PlayView(),
            ),
            Positioned(
              right: 0,
              child: SizedBox(
                height: playView.height,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        width: _lifeStages.width,
                        child: const LifeStages(),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: _diceResult.width,
                        child: const DiceResult(),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: _playerAction.width,
                        child: const PlayerAction(),
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
  }

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
