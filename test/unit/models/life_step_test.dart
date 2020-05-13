import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/models/common/life_event_params/goal_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/nothing_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/start_params.dart';
import 'package:HumanLifeGame/models/common/life_step.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final lifeStepList = List.generate(
    5,
    (index) {
      final isStart = index == 0;
      final isGoal = index == 4;
      final params = () {
        if (isStart) return const StartParams();
        if (isGoal) return const GoalParams();
        return const NothingParams();
      }();
      return LifeStepModel(
        id: index,
        lifeEvent: LifeEventModel(LifeEventTarget.myself, params),
        right: null,
        left: null,
        up: null,
        down: null,
      );
    },
  );

  test('move up straight', () {
    // 全て up 方向に進めるものとする
    for (var i = 0; i < lifeStepList.length; ++i) {
      if (lifeStepList[i] == lifeStepList.last) continue;
      lifeStepList[i].up = lifeStepList[i + 1];
    }
    expect(lifeStepList.first.getNextUntilMustStopStep(0).destination.id, 0);
    expect(lifeStepList.first.getNextUntilMustStopStep(3).destination.id, 3);
    expect(lifeStepList.first.getNextUntilMustStopStep(4).destination.id, 4);
    expect(lifeStepList.first.getNextUntilMustStopStep(5).destination.id, 4);
    expect(lifeStepList.first.getNextUntilMustStopStep(100).destination.id, 4);
  });
}
