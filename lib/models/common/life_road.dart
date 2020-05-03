import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/models/common/life_step.dart';
import 'package:flutter/foundation.dart';

class LifeRoadModel {
  LifeRoadModel();
  // FIXME: いつか消す
  LifeRoadModel.dummy() {
    final lifeStepNothing = LifeStepModel(
      lifeEvent: LifeEventModel(LifeEventTarget.myself, LifeEventType.nothing),
      right: null,
      left: null,
      up: null,
      down: null,
      isStart: null,
      isGoal: null,
    );
    final lifeStep = LifeStepModel(
      lifeEvent: LifeEventModel(LifeEventTarget.myself, LifeEventType.gainLifeItem),
      right: null,
      left: null,
      up: null,
      down: null,
      isStart: null,
      isGoal: null,
    );
    lifeStepsOnBoard = List.generate(
      10,
      (index) => List.generate(
        10,
        (index) => lifeStepNothing,
      ),
    );
    for (var index = 3; index <= 8; index++) {
      lifeStepsOnBoard[index][4] = lifeStep;
    }
  }

  @visibleForTesting
  static const int width = 10;

  @visibleForTesting
  static const int height = 10;

  List<List<LifeStepModel>> lifeStepsOnBoard = List.generate(width, (index) => List.generate(height, (index) => null));
}
