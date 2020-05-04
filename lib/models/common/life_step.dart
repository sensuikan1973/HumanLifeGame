import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:flutter/foundation.dart';

class LifeStepModel {
  LifeStepModel({
    @required this.id,
    @required this.lifeEvent,
    @required this.right,
    @required this.left,
    @required this.up,
    @required this.down,
    @required this.isStart,
    @required this.isGoal,
  });

  final int id;

  final LifeEventModel lifeEvent;

  final bool isStart;
  final bool isGoal;

  LifeStepModel up;
  LifeStepModel down;
  LifeStepModel right;
  LifeStepModel left;
}
