import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/play_room/play_room_notifier.dart';
import 'announcement.dart';
import 'dice_result.dart';
import 'life_event_records.dart';
import 'life_stages.dart';
import 'play_view.dart';
import 'player_action.dart';
import 'result_dialog.dart';

class PlayRoom extends StatefulWidget {
  const PlayRoom({Key key}) : super(key: key);

  @override
  PlayRoomState createState() => PlayRoomState();
}

class PlayRoomState extends State<PlayRoom> {
  bool isDisplayedResult = false;

  Size get _desktopSize => const Size(1440, 1024); // FIXME: 最終的には、左側のビューと右側のビューの最小サイズをトリガとして切り替える
  Size get _announcementSize => const Size(1050, 50);
  Size get _lifeEventRecordsSize => const Size(1050, 50);
  Size get _lifeStagesSize => const Size(200, 500);
  Size get _diceResultSize => const Size(200, 100);
  Size get _playerActionSize => const Size(200, 300);
  bool get _showLifeEventRecords =>
      MediaQuery.of(context).size.height >
      _announcementSize.height + _lifeEventRecordsSize.height + _playViewSize.height;
  Size get _playViewSize {
    const defaultPlayViewSize = Size(1050, 750);
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width > defaultPlayViewSize.width ? defaultPlayViewSize.width : screenSize.width;
    final height = screenSize.height < defaultPlayViewSize.height + _announcementSize.height
        ? screenSize.height - _announcementSize.height
        : defaultPlayViewSize.height;
    return Size(width, height);
  }

  void _setShowDialogCallback() {
    if (isDisplayedResult) return;
    if (context.select<PlayRoomNotifier, bool>((model) => model.value.allHumansReachedTheGoal)) {
      isDisplayedResult = true;
      WidgetsBinding.instance.addPostFrameCallback((_) async => showDialog<void>(
            context: context,
            builder: (_) => ResultDialog(context.read<PlayRoomNotifier>().value.lifeStages),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    _setShowDialogCallback();
    return Scaffold(
      body: MediaQuery.of(context).size.width >= _desktopSize.width ? _largeScreen() : _middleScreen(),
    );
  }

  Row _largeScreen() => Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                width: _announcementSize.width,
                height: _announcementSize.height,
                child: const Announcement(),
              ),
              if (_showLifeEventRecords)
                Expanded(
                  child: SizedBox(
                    width: _lifeEventRecordsSize.width,
                    child: const LifeEventRecords(),
                  ),
                ),
              SizedBox(
                width: _playViewSize.width,
                height: _playViewSize.height,
                child: const PlayView(),
              ),
            ],
          ),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: const <Widget>[
                  Expanded(flex: 2, child: LifeStages()),
                  Expanded(child: DiceResult()),
                  Expanded(child: PlayerAction()),
                ],
              ),
            ),
          ),
        ],
      );

  Column _middleScreen() => Column(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width < _announcementSize.width
                ? MediaQuery.of(context).size.width
                : _announcementSize.width,
            height: _announcementSize.height,
            child: const Announcement(),
          ),
          if (_showLifeEventRecords)
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width < _lifeEventRecordsSize.width
                    ? MediaQuery.of(context).size.width
                    : _lifeEventRecordsSize.width,
                child: const LifeEventRecords(),
              ),
            ),
          Stack(
            children: <Widget>[
              SizedBox(
                width: _playViewSize.width,
                height: _playViewSize.height,
                child: const PlayView(),
              ),
              Positioned(
                right: 0,
                child: SizedBox(
                  height: _playViewSize.height,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          width: _lifeStagesSize.width,
                          child: const LifeStages(),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: _diceResultSize.width,
                          child: const DiceResult(),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: _playerActionSize.width,
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
