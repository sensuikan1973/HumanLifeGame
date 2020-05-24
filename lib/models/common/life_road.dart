import 'package:flutter/foundation.dart';

import 'life_event.dart';
import 'life_event_params/gain_life_items_params.dart';
import 'life_event_params/goal_params.dart';
import 'life_event_params/lose_life_items_params.dart';
import 'life_event_params/nothing_params.dart';
import 'life_event_params/select_direction_params.dart';
import 'life_event_params/start_params.dart';
import 'life_event_params/target_life_item_params.dart';
import 'life_item.dart';
import 'life_step.dart';

class LifeRoadModel {
  LifeRoadModel({
    @required this.lifeStepsOnBoard,
  })  : height = lifeStepsOnBoard.length,
        width = lifeStepsOnBoard.first.length,
        assert(lifeStepsOnBoard.every((row) => row.length == lifeStepsOnBoard.first.length)) {
    _initDirections(start);
  }

  final int width;
  final int height;

  /// LifeStepsOnBoard の生成ヘルパー
  static List<List<LifeStepModel>> createLifeStepsOnBoard(List<List<LifeEventModel>> lifeEvents) => List.generate(
        lifeEvents.length,
        (y) => List.generate(
          lifeEvents[y].length,
          (x) => LifeStepModel(
            id: x + (y * lifeEvents[y].length),
            lifeEvent: lifeEvents[y][x],
          ),
        ),
      );

  // FIXME: いつか消す
  static List<List<LifeEventModel>> dummyLifeEvents() {
    final start = LifeEventModel(LifeEventTarget.myself, const StartParams(), description: 'Start');
    final goals = LifeEventModel(LifeEventTarget.myself, const GoalParams(), description: 'Goal');
    final gains = LifeEventModel(
        LifeEventTarget.myself,
        const GainLifeItemsParams(targetItems: [
          TargetLifeItemParams(key: 'money', type: LifeItemType.money, amount: 1000),
        ]),
        description: 'バイトでお金を稼ぐ');
    final loses = LifeEventModel(
        LifeEventTarget.myself,
        const LoseLifeItemsParams(targetItems: [
          TargetLifeItemParams(key: 'money', type: LifeItemType.money, amount: 1000),
        ]),
        description: '財布を落とす');

    final direc = LifeEventModel(LifeEventTarget.myself, const SelectDirectionParams(), description: '人生の分岐点');
    final blank = LifeEventModel(LifeEventTarget.myself, const NothingParams());
    return [
      [start, direc, gains, gains, gains, loses, blank, blank, blank, blank],
      [blank, gains, blank, blank, blank, gains, blank, blank, blank, blank],
      [blank, gains, gains, loses, gains, gains, gains, blank, blank, blank],
      [blank, blank, blank, blank, blank, blank, gains, blank, blank, blank],
      [goals, gains, loses, gains, gains, loses, direc, blank, blank, blank],
      [blank, gains, blank, blank, blank, blank, gains, blank, blank, blank],
      [blank, gains, gains, loses, gains, gains, gains, blank, blank, blank],
      [blank, blank, blank, blank, blank, blank, blank, blank, blank, blank],
      [blank, blank, blank, blank, blank, blank, blank, blank, blank, blank],
      [blank, blank, blank, blank, blank, blank, blank, blank, blank, blank],
    ];
  }

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

  void _initDirections(LifeStepModel currentLifeStep) {
    if (currentLifeStep.isGoal) return;

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

    // 分岐するEventの場合のフロー
    if (currentLifeStep.isBranch) {
      if (numOfUncheckedLifeStep > 1) {
        if (isUpUnchecked) {
          lifeStepsOnBoard[pos.y][pos.x].up = upLifeStep;
          _initDirections(upLifeStep);
        }
        if (isDownUnchecked) {
          lifeStepsOnBoard[pos.y][pos.x].down = downLifeStep;
          _initDirections(downLifeStep);
        }
        if (isRightUnchecked) {
          lifeStepsOnBoard[pos.y][pos.x].right = rightLifeStep;
          _initDirections(rightLifeStep);
        }
        if (isLeftUnchecked) {
          lifeStepsOnBoard[pos.y][pos.x].left = leftLifeStep;
          _initDirections(leftLifeStep);
        }
      } else {
        // エラー（もしくは離小島にジャンプ）
      }
    } else {
      if (numOfUncheckedLifeStep == 1) {
        // 次のLifeStepと紐付けし、次のLifeStepから探索を開始
        if (isUpUnchecked) {
          lifeStepsOnBoard[pos.y][pos.x].up = upLifeStep;
          _initDirections(upLifeStep);
        } else if (isDownUnchecked) {
          lifeStepsOnBoard[pos.y][pos.x].down = downLifeStep;
          _initDirections(downLifeStep);
        } else if (isRightUnchecked) {
          lifeStepsOnBoard[pos.y][pos.x].right = rightLifeStep;
          _initDirections(rightLifeStep);
        } else if (isLeftUnchecked) {
          lifeStepsOnBoard[pos.y][pos.x].left = leftLifeStep;
          _initDirections(leftLifeStep);
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
    if (!lifeStep.isTargetToRoad) return false;
    return [lifeStep.up, lifeStep.down, lifeStep.right, lifeStep.left].every((el) => el == null);
  }

  String debugMessage() {
    final messageBuffer = StringBuffer('');
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
    return messageBuffer.toString();
  }
}

class Position {
  const Position(this.y, this.x);
  final int y;
  final int x;
}
