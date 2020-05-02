import 'package:HumanLifeGame/models/player_action.dart';
import 'package:HumanLifeGame/screens/play_room/human_life.dart';
import 'package:HumanLifeGame/screens/play_room/human_life_stages.dart';
import 'package:HumanLifeGame/screens/play_room/dice_result.dart';
import 'package:HumanLifeGame/screens/play_room/player_action.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: ChangeNotifierProvider(
          create: (context) => PlayerActionModel(),
          child: _layout(context),
        ),
      );

  Row _layout(BuildContext context) => Row(
        children: <Widget>[
          Column(
            children: <Widget>[
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
