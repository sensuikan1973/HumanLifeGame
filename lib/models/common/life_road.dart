import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/models/common/life_step.dart';

class LifeRoadModel {
  LifeRoadModel();

  // FIXME: いつか消す
  // 一番下の列一直線の仮データ
  LifeRoadModel.dummy() {
    final targetRow = lifeStepsOnBoard.first
      // Start
      ..first = LifeStepModel(
        lifeEvent: LifeEventModel(LifeEventTarget.myself, LifeEventType.start),
        right: null,
        left: null,
        up: null,
        down: null,
        isStart: true,
        isGoal: false,
      )
      // Goal
      ..last = LifeStepModel(
        lifeEvent: LifeEventModel(LifeEventTarget.myself, LifeEventType.goal),
        right: null,
        left: null,
        up: null,
        down: null,
        isStart: false,
        isGoal: true,
      )
      // それ以外
      ..fillRange(
        1,
        width - 2,
        LifeStepModel(
          lifeEvent: LifeEventModel(LifeEventTarget.myself, LifeEventType.gainLifeItem),
          right: null,
          left: null,
          up: null,
          down: null,
          isStart: null,
          isGoal: null,
        ),
      );
    // 連結情報を更新する
    for (var i = 0; i < targetRow.length; ++i) {
      if (targetRow[i] == targetRow.last) continue;
      targetRow[i].right = targetRow[i + 1];
    }
  }

  static const int width = 7;

  static const int height = 7;

  List<List<LifeStepModel>> lifeStepsOnBoard = List.generate(
    width,
    (index) => List.filled(
      height,
      LifeStepModel(
        lifeEvent: LifeEventModel(LifeEventTarget.myself, LifeEventType.nothing),
        right: null,
        left: null,
        up: null,
        down: null,
        isStart: false,
        isGoal: false,
      ),
    ),
  );
}
