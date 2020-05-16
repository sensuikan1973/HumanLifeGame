library life_steps_on_board_helper;

import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/models/common/life_step.dart';

List<List<LifeStepModel>> createDummyLifeStepsOnBoard(List<List<LifeEventModel>> lifeEvents) => List.generate(
      lifeEvents.length,
      (y) => List.generate(
        lifeEvents.first.length,
        (x) => LifeStepModel(
          id: x + (y * lifeEvents[y].length),
          lifeEvent: lifeEvents[y][x],
          right: null,
          left: null,
          up: null,
          down: null,
        ),
      ),
    );
