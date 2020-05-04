import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/models/common/life_road.dart';
import 'package:HumanLifeGame/screens/play_room/human.dart';
import 'package:flutter/material.dart';

class LifeStep extends StatelessWidget {
  const LifeStep(this.model, this.width, this.height);
  final LifeEventModel model;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          SizedBox(
            width: width / LifeRoadModel.width,
            height: height / LifeRoadModel.height,
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: model.type == LifeEventType.nothing ? Colors.amber[50] : Colors.cyan[50],
                ),
              ),
            ),
          ),
          const Positioned(
            top: 0,
            right: 0,
            child: Human(),
          ),
        ],
      );
}
