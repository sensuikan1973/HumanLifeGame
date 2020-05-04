import 'package:HumanLifeGame/models/play_room/play_room.dart';
import 'package:HumanLifeGame/screens/common/life_road.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Align(
        child: SizedBox(
          width: 1050,
          height: 700,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.blue),
            ),
            child: Center(
              child: LifeRoad(Provider.of<PlayRoomModel>(context, listen: false).humanLife.lifeRoad),
            ),
          ),
        ),
      );
}
