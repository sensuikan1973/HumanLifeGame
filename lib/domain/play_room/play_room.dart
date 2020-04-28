import 'package:HumanLifeGame/domain/play_room/human_info.dart';
import 'package:HumanLifeGame/domain/play_room/player_action.dart';
import 'package:flutter/material.dart';

class PlayRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: <Widget>[
            HumanInfo(),
            PlayerAction(),
          ],
        ),
      );
}
