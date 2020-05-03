import 'package:HumanLifeGame/models/life_step.dart';
import 'package:flutter/foundation.dart';

class LifeRoadModel {
  LifeRoadModel();

  @visibleForTesting
  static const int width = 10;

  @visibleForTesting
  static const int height = 10;

  List<List<LifeStepModel>> lifeStepsOnBoard = List.generate(width, (index) => List.generate(height, (index) => null));
}
