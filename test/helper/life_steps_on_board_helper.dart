library life_steps_on_board_helper;

import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/models/common/life_road.dart';
import 'package:HumanLifeGame/models/common/life_step.dart';

void createDummyLifeStepsOnBoard(List<List<LifeEventModel>> lifeEvents) {
  List.generate(
    LifeRoadModel.height,
    (y) => List.generate(
      LifeRoadModel.width,
      (x) => LifeStepModel(
        id: x + (y * LifeRoadModel.width),
        lifeEvent: lifeEvents[y][x],
        right: null,
        left: null,
        up: null,
        down: null,
      ),
    ),
  );
}
