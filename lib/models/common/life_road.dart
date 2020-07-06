import 'package:flutter/foundation.dart';

import '../../api/firestore/life_event.dart';
import '../../api/firestore/life_item.dart';
import '../../api/firestore/user.dart';
import '../../entities/life_step_entity.dart';
import 'life_event_params/exchange_life_items_params.dart';
import 'life_event_params/gain_life_items_params.dart';
import 'life_event_params/goal_params.dart';
import 'life_event_params/life_event_params.dart';
import 'life_event_params/lose_life_items_params.dart';
import 'life_event_params/nothing_params.dart';
import 'life_event_params/select_direction_params.dart';
import 'life_event_params/start_params.dart';
import 'life_event_params/target_life_item_params.dart';

class LifeRoadModel {
  LifeRoadModel({
    @required this.lifeStepsOnBoard,
    this.title,
    this.author,
  }) : assert(lifeStepsOnBoard.every((row) => row.length == lifeStepsOnBoard.first.length)) {
    _initDirections(start);
    print(debugMessage());
  }

  final String title;
  final UserEntity author;
  final List<List<LifeStepEntity>> lifeStepsOnBoard;
  int get height => lifeStepsOnBoard.length;
  int get width => lifeStepsOnBoard.first.length;

  /// TODO: これ本当にいいんか?
  /// LifeStepsOnBoard の生成ヘルパー
  static List<List<LifeStepEntity>> createLifeStepsOnBoard(List<List<LifeEventEntity>> lifeEvents) => List.generate(
        lifeEvents.length,
        (y) => List.generate(
          lifeEvents[y].length,
          (x) => LifeStepEntity(
            id: (x + (y * lifeEvents[y].length)).toString(),
            lifeEvent: lifeEvents[y][x],
          ),
        ),
      );

  /// FIXME: いつか消す
  static List<List<LifeEventEntity>> dummyLifeEvents() {
    const start = LifeEventEntity<StartParams>(
      target: LifeEventTarget.myself,
      type: LifeEventType.start,
      params: StartParams(),
      description: 'Start だよ',
    );
    const goals = LifeEventEntity<GoalParams>(
      target: LifeEventTarget.myself,
      type: LifeEventType.goal,
      params: GoalParams(),
      description: 'Goal だよ',
    );
    const gains = LifeEventEntity<GainLifeItemsParams>(
      target: LifeEventTarget.myself,
      type: LifeEventType.gainLifeItems,
      params: GainLifeItemsParams(targetItems: [
        TargetLifeItemParams(key: 'money', type: LifeItemType.money, amount: 1000),
      ]),
      description: 'お金ゲット〜',
    );
    const loses = LifeEventEntity<LoseLifeItemsParams>(
      target: LifeEventTarget.myself,
      type: LifeEventType.loseLifeItems,
      params: LoseLifeItemsParams(targetItems: [
        TargetLifeItemParams(key: 'money', type: LifeItemType.money, amount: 1000),
      ]),
      description: 'お金なくした...',
    );
    const exchg = LifeEventEntity<ExchangeLifeItemsParams>(
      target: LifeEventTarget.myself,
      type: LifeEventType.exchangeLifeItems,
      params: ExchangeLifeItemsParams(
        targetItems: [
          TargetLifeItemParams(key: 'HumanLifeGames Inc.', type: LifeItemType.stock, amount: 1),
        ],
        baseItems: [
          TargetLifeItemParams(key: 'money', type: LifeItemType.money, amount: 1000),
        ],
      ),
      description: '株を購入する',
    );
    const direc = LifeEventEntity<SelectDirectionParams>(
      target: LifeEventTarget.myself,
      type: LifeEventType.selectDirection,
      params: SelectDirectionParams(),
      description: '分岐だよー',
    );
    const blank = LifeEventEntity<NothingParams>(
      target: LifeEventTarget.myself,
      type: LifeEventType.nothing,
      params: NothingParams(),
    );
    return [
      [start, direc, gains, gains, exchg, loses, blank, blank, blank, blank],
      [blank, gains, blank, blank, blank, gains, blank, blank, blank, blank],
      [blank, gains, gains, loses, gains, gains, gains, blank, blank, blank],
      [blank, blank, blank, blank, blank, blank, exchg, blank, blank, blank],
      [goals, exchg, loses, gains, exchg, loses, direc, blank, blank, blank],
      [blank, gains, blank, blank, blank, blank, gains, blank, blank, blank],
      [blank, gains, exchg, loses, gains, gains, gains, blank, blank, blank],
      [blank, blank, blank, blank, blank, blank, blank, blank, blank, blank],
      [blank, blank, blank, blank, blank, blank, blank, blank, blank, blank],
      [blank, blank, blank, blank, blank, blank, blank, blank, blank, blank],
    ];
  }

  LifeStepEntity get start {
    final lifeSteps = lifeStepsOnBoard.expand((el) => el);
    final startSteps = lifeSteps.where((step) => step.isStart).toList();
    if (startSteps.isEmpty || startSteps.length > 1) {
      throw Exception('start step should be just one. found start ${startSteps.length} steps.');
    }
    return startSteps.first;
  }

  Position getPosition(LifeStepEntity lifeStep) {
    for (var y = 0; y < lifeStepsOnBoard.length; ++y) {
      for (var x = 0; x < lifeStepsOnBoard[y].length; ++x) {
        if (lifeStepsOnBoard[y][x] == lifeStep) return Position(y, x);
      }
    }
    throw Exception('lifeStep should be in lifeStepsOnBoard');
  }

  void _initDirections(LifeStepEntity currentLifeStep) {
    if (currentLifeStep.isGoal) return;

    final pos = getPosition(currentLifeStep);
    LifeStepEntity upLifeStep;
    LifeStepEntity downLifeStep;
    LifeStepEntity rightLifeStep;
    LifeStepEntity leftLifeStep;
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

  bool _isUncheckedLifeStep(LifeStepEntity lifeStep) {
    if (!lifeStep.isTargetToRoad) return false;
    return [lifeStep.up, lifeStep.down, lifeStep.right, lifeStep.left].every((el) => el == null);
  }

  String debugMessage() {
    final messageBuffer = StringBuffer();
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

@immutable
class Position {
  const Position(this.y, this.x);
  final int y;
  final int x;
}
