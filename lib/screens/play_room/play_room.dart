import 'package:HumanLifeGame/models/play_room.dart';
import 'package:HumanLifeGame/models/player_action.dart';
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
            ChangeNotifierProvider(create: (context) => PlayerActionModel()),
            ChangeNotifierProxyProvider<PlayerActionModel, PlayRoomModel>(
              create: (context) => PlayRoomModel(),
              update: (context, playerAction, playRoom) => playRoom..playerAction = playerAction,
            )
          ],
          child: Column(
            children: <Widget>[
              Announcement(),
              HumanLifeStages(),
              DiceResult(),
              PlayerAction(),
            ],
          ),
        ),
      );
}
