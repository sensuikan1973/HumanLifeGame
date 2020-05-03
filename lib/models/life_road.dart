import 'package:HumanLifeGame/models/life_step.dart';
import 'package:flutter/foundation.dart';

class LifeRoadModel {
  // FIXME: いつか消す
  LifeRoadModel.dummy() {
    final lifeStep = LifeStepModel(null, null, null, null, null, isStart: false, isGoal: false);
    lifeStepsOnBoard = List.generate(
      10,
      (index) => List.generate(
        10,
        (index) => null,
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
