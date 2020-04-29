import 'package:HumanLifeGame/screens/play_room/human_life_stages.dart';
import 'package:HumanLifeGame/screens/play_room/dice_result.dart';
import 'package:HumanLifeGame/screens/play_room/player_action.dart';
import 'package:flutter/material.dart';

class PlayRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: <Widget>[
            HumanLifeStages(),
            DiceResult(),
            PlayerAction(),
          ],
        ),
      );
}
