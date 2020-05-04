import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/models/common/life_step.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LifeStep', () {
    final lifeStepList = List.generate(
      5,
      (index) {
        final isStart = index == 0;
        final isGoal = index == 4;
        final eventType = () {
          if (isStart) return LifeEventType.start;
          if (isGoal) return LifeEventType.goal;
          return LifeEventType.nothing;
        }();
        return LifeStepModel(
            id: index,
            lifeEvent: LifeEventModel(LifeEventTarget.myself, eventType),
            right: null,
            left: null,
            up: null,
            down: null,
            isStart: isStart,
            isGoal: isGoal);
      },
    );

    test('move up straight', () {
      // 全て up 方向に進めるものとする
      for (var i = 0; i < lifeStepList.length; ++i) {
        if (lifeStepList[i] == lifeStepList.last) continue;
        lifeStepList[i].up = lifeStepList[i + 1];
      }
      expect(lifeStepList.first.move(0).id, 0);
      expect(lifeStepList.first.move(3).id, 3);
      expect(lifeStepList.first.move(4).id, 4);
      expect(lifeStepList.first.move(5).id, 4);
      expect(lifeStepList.first.move(100).id, 4);
    });
  });
}
