import 'package:HumanLifeGame/models/play_room.dart';
import 'package:HumanLifeGame/screens/common/life_road.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HumanLife extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Align(
        child: SizedBox(
          width: 500,
          height: 400,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: LifeRoad(Provider.of<PlayRoomModel>(context, listen: false).humanLife.lifeRoad),
          ),
        ),
      );
}
