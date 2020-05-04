import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/models/common/life_road.dart';
import 'package:HumanLifeGame/models/common/life_step.dart';
import 'package:HumanLifeGame/screens/play_room/human.dart';
import 'package:flutter/material.dart';

class LifeStep extends StatelessWidget {
  const LifeStep(this.model, this.width, this.height);

  final LifeStepModel model;
  final double width;
  final double height;

  @visibleForTesting
  static Color nothing = Colors.amber[50];

  @visibleForTesting
  static Color exist = Colors.cyan[50];

  @override
  Widget build(BuildContext context) {
    if (model.isStart == true) return _squareWithHuman();

    return SizedBox(
      width: width / LifeRoadModel.width,
      height: height / LifeRoadModel.height,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: model.lifeEvent.type == LifeEventType.nothing ? nothing : exist,
          ),
        ),
      ),
    );
  }

  Widget _squareWithHuman() => Stack(
        children: <Widget>[
          SizedBox(
            width: width / LifeRoadModel.width,
            height: height / LifeRoadModel.height,
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: model.lifeEvent.type == LifeEventType.nothing ? nothing : exist,
                ),
              ),
            ),
          ),
          const Positioned(
            top: 0,
            left: 0,
            child: Human(),
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            child: Human(),
          ),
        ],
      );
}
