import 'package:HumanLifeGame/screens/play_room/life_step.dart';
import 'package:flutter/material.dart';

class LifeRoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Align(
        child: SizedBox(
          width: 990,
          height: 590,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: LifeStep(),
          ),
        ),
      );
}
