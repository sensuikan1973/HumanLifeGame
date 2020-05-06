import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'life_event.dart';
import 'life_step.dart';

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
            id: x + (y * width),
            lifeEvent: LifeEventModel(LifeEventTarget.myself, eventType),
            right: null,
            left: null,
            up: null,
            down: null,
          );
        },
      ),
    );
    // 連結情報を更新する
    setDirectionsForLifeStepsOnBoard(start);
    debugPrintPointerList();
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
        if (lifeStepsOnBoard[y][x] == lifeStep) return Position(y, x);
      }
    }
    return null;
  }

  void setDirectionsForLifeStepsOnBoard(LifeStepModel currentLifeStep) {
    final pos = getPosition(currentLifeStep);
    LifeStepModel upLifeStep;
    LifeStepModel downLifeStep;
    LifeStepModel rightLifeStep;
    LifeStepModel leftLifeStep;
    var isUpUnchecked = false;
    var isDownUnchecked = false;
    var isRightUnchecked = false;
    var isLeftUnchecked = false;

    var numOfUncheckedLifeStep = 0;
    var isBranchEvent = false;

    // isGoalなら探索終了
    if (currentLifeStep.isGoal) return;
    // 現在のLifeStepの上下左右に未探索のLifeStepが存在するか
    // 上方をチェック
    if (pos.y != 0) {
      upLifeStep = lifeStepsOnBoard[pos.y - 1][pos.x];
      if (isUpUnchecked = _isUncheckedLifeStep(upLifeStep)) numOfUncheckedLifeStep++;
    }
    // 下方をチェック
    if (pos.y != height - 1) {
      downLifeStep = lifeStepsOnBoard[pos.y + 1][pos.x];
      if (isDownUnchecked = _isUncheckedLifeStep(downLifeStep)) numOfUncheckedLifeStep++;
    }
    // 右方をチェック
    if (pos.x != width - 1) {
      rightLifeStep = lifeStepsOnBoard[pos.y][pos.x + 1];
      if (isRightUnchecked = _isUncheckedLifeStep(rightLifeStep)) numOfUncheckedLifeStep++;
    }
    // 左方をチェック
    if (pos.x != 0) {
      leftLifeStep = lifeStepsOnBoard[pos.y][pos.x - 1];
      if (isLeftUnchecked = _isUncheckedLifeStep(leftLifeStep)) numOfUncheckedLifeStep++;
    }
    // 現在のLifeStepが分岐するEventかチェック

    isBranchEvent = [
      LifeEventType.selectDirection,
      LifeEventType.selectDirectionPerDiceRoll,
      LifeEventType.selectDirectionPerLifeItem,
    ].contains(currentLifeStep.lifeEvent.type);

    // 分岐するEventの場合のフロー
    if (isBranchEvent) {
      if (numOfUncheckedLifeStep > 1) {
        if (isUpUnchecked) {
          lifeStepsOnBoard[pos.y][pos.x].up = upLifeStep;
          setDirectionsForLifeStepsOnBoard(upLifeStep);
        }
        if (isDownUnchecked) {
          lifeStepsOnBoard[pos.y][pos.x].down = downLifeStep;
          setDirectionsForLifeStepsOnBoard(downLifeStep);
        }
        if (isRightUnchecked) {
          lifeStepsOnBoard[pos.y][pos.x].right = rightLifeStep;
          setDirectionsForLifeStepsOnBoard(rightLifeStep);
        }
        if (isLeftUnchecked) {
          lifeStepsOnBoard[pos.y][pos.x].left = leftLifeStep;
          setDirectionsForLifeStepsOnBoard(leftLifeStep);
        }
      } else {
        // エラー（もしくは離小島にジャンプ）
      }
    } else {
      if (numOfUncheckedLifeStep == 1) {
        // 次のLifeStepと紐付けし、次のLifeStepから探索を開始
        if (isUpUnchecked) {
          lifeStepsOnBoard[pos.y][pos.x].up = upLifeStep;
          setDirectionsForLifeStepsOnBoard(upLifeStep);
        } else if (isDownUnchecked) {
          lifeStepsOnBoard[pos.y][pos.x].down = downLifeStep;
          setDirectionsForLifeStepsOnBoard(downLifeStep);
        } else if (isRightUnchecked) {
          lifeStepsOnBoard[pos.y][pos.x].right = rightLifeStep;
          setDirectionsForLifeStepsOnBoard(rightLifeStep);
        } else if (isLeftUnchecked) {
          lifeStepsOnBoard[pos.y][pos.x].left = leftLifeStep;
          setDirectionsForLifeStepsOnBoard(leftLifeStep);
        } else {
          // 例外
        }
      } else if (numOfUncheckedLifeStep > 1) {
        // 合流のため、探索終了
        // TODO: LifeStepが４つボックス状にくっついてたらどうする
        return;
      } else {
        // 例外（もしくは離小島にジャンプ）
      }
    }
  }

  bool _isUncheckedLifeStep(LifeStepModel lifeStep) {
    if (lifeStep.lifeEvent.type == LifeEventType.nothing) return false;
    return [lifeStep.up, lifeStep.down, lifeStep.right, lifeStep.left].every((el) => el == null);
  }

  void debugPrintPointerList() {
    String message;
    final messageBuffer = StringBuffer(message);
    for (var y = 0; y < lifeStepsOnBoard.length; ++y) {
      for (var x = 0; x < lifeStepsOnBoard[y].length; ++x) {
        messageBuffer.write('type:${lifeStepsOnBoard[y][x].lifeEvent.type.index}   ');
      }
      messageBuffer.writeln();
      for (var x = 0; x < lifeStepsOnBoard[y].length; ++x) {
        if (lifeStepsOnBoard[y][x].up != null) {
          messageBuffer.write('up:exist ');
        } else {
          messageBuffer.write('up:null  ');
        }
      }
      messageBuffer.writeln();
      for (var x = 0; x < lifeStepsOnBoard[y].length; ++x) {
        if (lifeStepsOnBoard[y][x].down != null) {
          messageBuffer.write('dn:exist ');
        } else {
          messageBuffer.write('dn:null  ');
        }
      }
      messageBuffer.writeln();
      for (var x = 0; x < lifeStepsOnBoard[y].length; ++x) {
        if (lifeStepsOnBoard[y][x].right != null) {
          messageBuffer.write('rl:exist ');
        } else {
          messageBuffer.write('rl:null  ');
        }
      }
      messageBuffer.writeln();
      for (var x = 0; x < lifeStepsOnBoard[y].length; ++x) {
        if (lifeStepsOnBoard[y][x].left != null) {
          messageBuffer.write('lt:exist ');
        } else {
          messageBuffer.write('lt:null  ');
        }
      }
      messageBuffer.writeln();
    }
    DiagnosticsNode.message(messageBuffer.toString());
  }
}

class Position {
  const Position(this.y, this.x);
  final int y;
  final int x;
}
