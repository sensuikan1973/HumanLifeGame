import 'package:HumanLifeGame/api/dice.dart';
import 'package:HumanLifeGame/models/play_room.dart';
import 'package:HumanLifeGame/models/player_action.dart';
import 'package:HumanLifeGame/screens/common/human_life.dart';
import 'package:HumanLifeGame/screens/play_room/announcement.dart';
import 'package:HumanLifeGame/screens/play_room/human_life_stages.dart';
import 'package:HumanLifeGame/screens/play_room/dice_result.dart';
import 'package:HumanLifeGame/screens/play_room/player_action.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => PlayerActionModel(Provider.of<Dice>(context, listen: false)),
            ),
            ChangeNotifierProxyProvider<PlayerActionModel, PlayRoomModel>(
              create: (context) => PlayRoomModel(),
              update: (context, playerAction, playRoom) => playRoom..playerAction = playerAction,
            )
          ],
          child: _layout(context),
        ),
      );

  Row _layout(BuildContext context) => Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Announcement(),
              HumanLife(),
            ],
          ),
          Column(
            children: <Widget>[
              HumanLifeStages(),
              DiceResult(),
              PlayerAction(),
            ],
          ),
        ],
      );
}
