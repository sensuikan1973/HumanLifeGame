import 'package:HumanLifeGame/entities/life_event.dart';
import 'package:HumanLifeGame/entities/life_event_params/goal_params.dart';
import 'package:HumanLifeGame/entities/life_event_params/nothing_params.dart';
import 'package:HumanLifeGame/entities/life_event_params/select_direction_params.dart';
import 'package:HumanLifeGame/entities/life_event_params/start_params.dart';
import 'package:HumanLifeGame/entities/life_event_target.dart';
import 'package:HumanLifeGame/entities/life_event_type.dart';
import 'package:HumanLifeGame/entities/life_step_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('getNextUntilMustStopStep', () {
    group('up only', () {
      const lifeEventParams = [
        StartParams(),
        NothingParams(),
        NothingParams(),
        NothingParams(),
        GoalParams(),
      ];
      final lifeStepsOnBoard = [
        for (var i = 0; i < lifeEventParams.length; ++i)
          LifeStepEntity(
            id: i.toString(),
            lifeEvent: LifeEventEntity(
              target: LifeEventTarget.myself,
              params: lifeEventParams[i],
              type: LifeEventType.nothing,
            ),
          )
      ];
      // 全て up 方向に進めるものとする
      for (var i = 0; i < lifeStepsOnBoard.length; ++i) {
        if (lifeStepsOnBoard[i] == lifeStepsOnBoard.last) continue;
        lifeStepsOnBoard[i].up = lifeStepsOnBoard[i + 1];
      }

      test('move up straight', () {
        expect(lifeStepsOnBoard.first.getNextUntilMustStopStep(0).destination.id, '0');
        expect(lifeStepsOnBoard.first.getNextUntilMustStopStep(0).movedCount, 0);

        expect(lifeStepsOnBoard.first.getNextUntilMustStopStep(3).destination.id, '3');
        expect(lifeStepsOnBoard.first.getNextUntilMustStopStep(3).movedCount, 3);

        expect(lifeStepsOnBoard.first.getNextUntilMustStopStep(4).destination.id, '4');
        expect(lifeStepsOnBoard.first.getNextUntilMustStopStep(4).movedCount, 4);

        expect(lifeStepsOnBoard.first.getNextUntilMustStopStep(5).destination.id, '4');
        expect(lifeStepsOnBoard.first.getNextUntilMustStopStep(5).movedCount, 4);

        expect(lifeStepsOnBoard.first.getNextUntilMustStopStep(100).destination.id, '4');
        expect(lifeStepsOnBoard.first.getNextUntilMustStopStep(100).movedCount, 4);
      });
    });

    group('with direction', () {
      const lifeEventParams = [
        StartParams(),
        NothingParams(),
        NothingParams(),
        SelectDirectionParams(),
        GoalParams(),
      ];
      final lifeStepsOnBoard = [
        for (var i = 0; i < lifeEventParams.length; ++i)
          LifeStepEntity(
            id: i.toString(),
            lifeEvent: LifeEventEntity(
              target: LifeEventTarget.myself,
              params: lifeEventParams[i],
              type: LifeEventType.nothing,
            ),
          )
      ];
      // 全て up 方向に進めるものとする
      // NOTE: ここでは LifeEvent の type が重要なので、direction は雑に up のみ入れており、分岐のセットはしてない
      for (var i = 0; i < lifeStepsOnBoard.length; ++i) {
        if (lifeStepsOnBoard[i] == lifeStepsOnBoard.last) continue;
        lifeStepsOnBoard[i].up = lifeStepsOnBoard[i + 1];
      }

      test('move until direction', () {
        expect(lifeStepsOnBoard.first.getNextUntilMustStopStep(3).destination.id, '3');
        expect(lifeStepsOnBoard.first.getNextUntilMustStopStep(3).movedCount, 3);

        // 途中に SelectDirection があるから、強制ストップ
        expect(lifeStepsOnBoard.first.getNextUntilMustStopStep(4).destination.id, '3');
        expect(lifeStepsOnBoard.first.getNextUntilMustStopStep(4).movedCount, 3);

        // SelectDirection から進もうとしても、そこ自体が強制ストップ Event だから先に進めない
        expect(lifeStepsOnBoard[3].getNextUntilMustStopStep(4).destination.id, '3');
        expect(lifeStepsOnBoard[3].getNextUntilMustStopStep(4).movedCount, 0);
      });
    });
  });
}
