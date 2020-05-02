import 'package:HumanLifeGame/screens/play_room/life_road.dart';
import 'package:flutter/material.dart';

class HumanLife extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Align(
        child: SizedBox(
          width: 1000,
          height: 600,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: LifeRoad(),
          ),
        ),
      );
}
