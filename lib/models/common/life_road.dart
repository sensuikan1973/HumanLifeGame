import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/models/common/life_step.dart';

class LifeRoadModel {
  LifeRoadModel();

  // FIXME: いつか消す
  // 一番下の列一直線の仮データ
  LifeRoadModel.dummy() {
    lifeStepsOnBoard = List.generate(
      width,
      (y) => List.generate(
        height,
        (x) {
          final isStart = x == 0 && y == 0;
          final isGoal = x == width - 1 && y == 0;
          final eventType = () {
            if (isStart) return LifeEventType.start;
            if (isGoal) return LifeEventType.goal;
            if (y == 0) return LifeEventType.gainLifeItem;
            return LifeEventType.nothing;
          }();
          return LifeStepModel(
            id: (x + 1) * (y + 1), // 一意になるようにしたいだけ。仮。
            lifeEvent: LifeEventModel(LifeEventTarget.myself, eventType),
            right: null,
            left: null,
            up: null,
            down: null,
            isStart: isStart,
            isGoal: isGoal,
          );
        },
      ),
    );
    // 連結情報を更新する
    for (var i = 0; i < lifeStepsOnBoard.first.length; ++i) {
      if (lifeStepsOnBoard.first[i] == lifeStepsOnBoard.first.last) continue;
      lifeStepsOnBoard.first[i].right = lifeStepsOnBoard.first[i + 1];
    }
  }

  static const int width = 7;

  static const int height = 7;

  List<List<LifeStepModel>> lifeStepsOnBoard;

  LifeStepModel get start {
    for (final list in lifeStepsOnBoard) {
      for (final lifeStep in list) {
        if (lifeStep.isStart) return lifeStep;
      }
    }
    return null; // TODO: エラーでいい
  }

  Position getPosition(LifeStepModel lifeStep) {
    for (var y = 0; y < lifeStepsOnBoard.length; ++y) {
      for (var x = 0; x < lifeStepsOnBoard[y].length; ++x) {
        if (lifeStepsOnBoard[x][y] == lifeStep) return Position(x, y);
      }
    }
    return null;
  }
}

class Position {
  const Position(this.x, this.y);
  final int x;
  final int y;
}
