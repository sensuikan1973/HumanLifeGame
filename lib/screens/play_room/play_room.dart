import 'package:HumanLifeGame/api/dice.dart';
import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/models/play_room/play_room.dart';
import 'package:HumanLifeGame/models/play_room/player_action.dart';
import 'package:HumanLifeGame/screens/play_room/announcement.dart';
import 'package:HumanLifeGame/screens/play_room/dice_result.dart';
import 'package:HumanLifeGame/screens/play_room/life_event_records.dart';
import 'package:HumanLifeGame/screens/play_room/life_stages.dart';
import 'package:HumanLifeGame/screens/play_room/play_view.dart';
import 'package:HumanLifeGame/screens/play_room/player_action.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayRoom extends StatelessWidget {
  const PlayRoom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => PlayerActionModel(Provider.of<Dice>(context, listen: false)),
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
