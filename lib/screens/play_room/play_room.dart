import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/dice.dart';
import '../../i18n/i18n.dart';
import '../../models/play_room/play_room.dart';
import '../../models/play_room/player_action.dart';
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
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => PlayerActionModel(context.read<Dice>()),
            ),
            ChangeNotifierProxyProvider<PlayerActionModel, PlayRoomModel>(
              create: (_) => PlayRoomModel(I18n.of(context)),
              update: (context, playerAction, playRoom) => playRoom..playerAction = playerAction,
            )
          ],
          child: _layout(context),
        ),
      );

  Row _layout(BuildContext context) => Row(
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
}
