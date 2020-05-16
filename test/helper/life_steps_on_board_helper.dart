library life_steps_on_board_helper;

import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/models/common/life_road.dart';
import 'package:HumanLifeGame/models/common/life_step.dart';

List<List<LifeStepModel>> createDummyLifeStepsOnBoard(
  List<List<LifeEventModel>> lifeEvents, {
  int width = LifeRoadModel.width,
  int height = LifeRoadModel.height,
}) =>
    List.generate(
      height,
      (y) => List.generate(
        width,
        (x) => LifeStepModel(
          id: x + (y * width),
          lifeEvent: lifeEvents[y][x],
          right: null,
          left: null,
          up: null,
          down: null,
        ),
      ),
    );
