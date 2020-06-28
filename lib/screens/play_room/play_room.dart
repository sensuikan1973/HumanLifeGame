import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../i18n/i18n.dart';
import '../../models/play_room/play_room_notifier.dart';
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

  Size get _desktopSize => const Size(1440, 1024); // FIXME: 最終的には、左側のビューと右側のビューの最小サイズをトリガとして切り替える
  Size get _announcementSize => const Size(1050, 50);
  Size get _lifeEventRecordsSize => const Size(1050, 50);
  Size get _lifeStagesSize => const Size(200, 500);
  Size get _diceResultSize => const Size(200, 100);
  Size get _playerActionSize => const Size(200, 300);

  Size _playViewSize(BuildContext context) {
    const defaultPlayViewSize = Size(1050, 750);
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width > defaultPlayViewSize.width ? defaultPlayViewSize.width : screenSize.width;
    final height = screenSize.height < defaultPlayViewSize.height + _announcementSize.height
        ? screenSize.height - _announcementSize.height
        : defaultPlayViewSize.height;
    return Size(width, height);
  }

  bool _showLifeEventRecords(BuildContext context) =>
      MediaQuery.of(context).size.height >
      _announcementSize.height + _lifeEventRecordsSize.height + _playViewSize(context).height;

  @override
  Widget build(BuildContext context) {
    if (context.select<PlayRoomNotifier, bool>((model) => model.value.allHumansReachedTheGoal)) {
      if (!isDisplayedResult) {
        isDisplayedResult = true;
        WidgetsBinding.instance.addPostFrameCallback((_) async => _showResult(context));
      }
    }
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: screenSize.width >= _desktopSize.width ? _largeScreen(screenSize) : _middleScreen(screenSize),
    );
  }

  Row _largeScreen(Size screenSize) => Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                width: _announcementSize.width,
                height: _announcementSize.height,
                child: const Announcement(),
              ),
              if (_showLifeEventRecords(context))
                Expanded(
                  child: SizedBox(
                    width: _lifeEventRecordsSize.width,
                    child: const LifeEventRecords(),
                  ),
                ),
              SizedBox(
                width: _playViewSize(context).width,
                height: _playViewSize(context).height,
                child: const PlayView(),
              ),
            ],
          ),
          Expanded(
            child: SizedBox(
              height: screenSize.height,
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

  Column _middleScreen(Size screenSize) => Column(
        children: <Widget>[
          SizedBox(
            width: screenSize.width < _announcementSize.width ? screenSize.width : _announcementSize.width,
            height: _announcementSize.height,
            child: const Announcement(),
          ),
          if (_showLifeEventRecords(context))
            Expanded(
              child: SizedBox(
                width: screenSize.width < _lifeEventRecordsSize.width ? screenSize.width : _lifeEventRecordsSize.width,
                child: const LifeEventRecords(),
              ),
            ),
          Stack(
            children: <Widget>[
              SizedBox(
                width: _playViewSize(context).width,
                height: _playViewSize(context).height,
                child: const PlayView(),
              ),
              Positioned(
                right: 0,
                child: SizedBox(
                  height: _playViewSize(context).height,
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

  Future<void> _showResult(BuildContext context) async {
    final lifeStages = context.read<PlayRoomNotifier>().value.lifeStages;
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
