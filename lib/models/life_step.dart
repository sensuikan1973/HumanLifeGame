import 'package:HumanLifeGame/models/life_event.dart';
import 'package:flutter/foundation.dart';

class LifeStepModel {
  LifeStepModel(
    this.lifeEvent,
    this.right,
    this.left,
    this.up,
    this.down, {
    @required this.isStart,
    @required this.isGoal,
  });

  final LifeEventModel lifeEvent;

  final bool isStart;
  final bool isGoal;

  final LifeStepModel up;
  final LifeStepModel down;
  final LifeStepModel right;
  final LifeStepModel left;
}
