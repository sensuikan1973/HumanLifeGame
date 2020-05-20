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
  _PlayRoomState createState() => _PlayRoomState();
}

class _PlayRoomState extends State<PlayRoom> {
  bool isDisplayedResult;

  Size get _desktop => const Size(1440, 1024);

  @override
  void initState() {
    super.initState();
    isDisplayedResult = false;
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    if (context.select<PlayRoomNotifier, bool>((model) => model.allHumansReachedTheGoal)) {
      if (!isDisplayedResult) {
        WidgetsBinding.instance.addPostFrameCallback((_) async => _showResult(context));
      }
    }
    return Scaffold(
      body: screen.width >= _desktop.width ? _largeScreen() : _middleScreen(),
    );
  }

  Row _largeScreen() => Row(
        children: <Widget>[
          Column(
            children: const <Widget>[
              Announcement(),
              LifeEventRecords(),
              PlayView(),
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

  Column _middleScreen() => Column(
        children: <Widget>[
          const Announcement(),
          const LifeEventRecords(),
          Stack(
            children: <Widget>[
              const PlayView(),
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
    isDisplayedResult = true;
    await showDialog<void>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(I18n.of(context).resultAnnouncementDialogMessage),
        children: result,
      ),
    );
  }
}
