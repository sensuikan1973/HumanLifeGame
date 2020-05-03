import 'package:HumanLifeGame/models/life_step.dart';
import 'package:flutter/foundation.dart';

class LifeRoadModel {
  // FIXME: いつか消す
  LifeRoadModel.dummy() {
    LifeStepModel lifeStep;
    lifeStepsOnBoard = List.generate(
      10,
      (index) => List.generate(
        10,
        (index) => null,
      ),
    );
    lifeStepsOnBoard[5][5] = lifeStep;
  }

  @visibleForTesting
  static const int width = 10;

  @visibleForTesting
  static const int height = 10;

  List<List<LifeStepModel>> lifeStepsOnBoard = List.generate(width, (index) => List.generate(height, (index) => null));
}
