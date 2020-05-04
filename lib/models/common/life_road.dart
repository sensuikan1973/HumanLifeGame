import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/models/common/life_step.dart';

class LifeRoadModel {
  LifeRoadModel();
  // FIXME: いつか消す
  LifeRoadModel.dummy() {
    final empty = LifeStepModel(
      lifeEvent: LifeEventModel(LifeEventTarget.myself, LifeEventType.nothing),
      right: null,
      left: null,
      up: null,
      down: null,
      isStart: false,
      isGoal: false,
    );
    final lstep = LifeStepModel(
      lifeEvent: LifeEventModel(LifeEventTarget.myself, LifeEventType.gainLifeItem),
      right: null,
      left: null,
      up: null,
      down: null,
      isStart: false,
      isGoal: false,
    );

    final start = LifeStepModel(
      lifeEvent: LifeEventModel(LifeEventTarget.myself, LifeEventType.gainLifeItem),
      right: null,
      left: null,
      up: null,
      down: null,
      isStart: true,
      isGoal: false,
    );
    final goalp = LifeStepModel(
      lifeEvent: LifeEventModel(LifeEventTarget.myself, LifeEventType.gainLifeItem),
      right: null,
      left: null,
      up: null,
      down: null,
      isStart: false,
      isGoal: true,
    );
    lifeStepsOnBoard = [
      [empty, goalp, lstep, lstep, lstep, empty, empty],
      [empty, empty, empty, empty, lstep, empty, empty],
      [empty, empty, empty, empty, lstep, lstep, lstep],
      [empty, empty, empty, empty, lstep, empty, lstep],
      [empty, empty, empty, empty, lstep, empty, lstep],
      [empty, start, lstep, lstep, lstep, lstep, lstep],
      [empty, empty, empty, empty, empty, empty, empty],
    ];
  }

  static const int width = 7;

  static const int height = 7;

  List<List<LifeStepModel>> lifeStepsOnBoard = List.generate(width, (index) => List.generate(height, (index) => null));
}
