import 'package:HumanLifeGame/models/common/life_step.dart';
import 'package:flutter/foundation.dart';

class LifeRoadModel {
  // FIXME: いつか消す
  LifeRoadModel.dummy() {
    // TODO: lifeStepsOnBoard に LifeStep をいくつか雑に入れておく
  }

  @visibleForTesting
  static const int width = 10;

  @visibleForTesting
  static const int height = 10;

  List<List<LifeStepModel>> lifeStepsOnBoard = List.generate(width, (index) => List.generate(height, (index) => null));
}
