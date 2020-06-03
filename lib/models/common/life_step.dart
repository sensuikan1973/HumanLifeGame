import 'package:flutter/foundation.dart';

import 'life_event.dart';
import 'life_event_params/life_event_params.dart';

class LifeStepModel {
  LifeStepModel({
    @required this.id,
    @required this.lifeEvent,
    this.right,
    this.left,
    this.up,
    this.down,
  });

  final int id;
  final LifeEventModel lifeEvent;

  LifeStepModel up;
  LifeStepModel down;
  LifeStepModel right;
  LifeStepModel left;

  bool get hasUp => up != null;
  bool get hasDown => down != null;
  bool get hasLeft => left != null;
  bool get hasRight => right != null;

  bool get isTargetToRoad => lifeEvent.type != LifeEventType.nothing;
  bool get isStart => lifeEvent.type == LifeEventType.start;
  bool get isGoal => lifeEvent.type == LifeEventType.goal;
  bool get isBranch => lifeEvent.isBranch;
  bool get mustStop => lifeEvent.mustStop;
  bool get selectableForExecution => lifeEvent.selectableForExecution;
  bool get requireDiceRoll => lifeEvent.requireDiceRoll;
  bool get requireToSelectDirectionManually => lifeEvent.requireToSelectDirectionManually;

  DestinationWithMovedStepCount getNextUntilMustStopStep(int num, {Direction firstDirection}) {
    var current = this;
    var count = 0;
    if (firstDirection != null) {
      current = current._getNext(firstDirection);
      count++;
    }
    while (current != null && count < num) {
      if (current.mustStop) break;
      final next = current._getNext();
      if (next == null) break;
      current = next;
      count++;
    }
    return DestinationWithMovedStepCount(wantToMoveCount: num, movedCount: count, destination: current);
  }

  LifeStepModel _getNext([Direction direction]) {
    if (direction == null) {
      final candidateList = [up, down, right, left].where((el) => el != null);
      if (candidateList.length > 1) {
        throw Exception('called _getNext without Direction arg, but candidateList($candidateList) has many');
      }
      return candidateList.isNotEmpty ? candidateList.first : null;
    }
    switch (direction) {
      case Direction.up:
        return up;
      case Direction.down:
        return down;
      case Direction.left:
        return left;
      case Direction.right:
        return right;
    }
    return null;
  }
}

class DestinationWithMovedStepCount {
  const DestinationWithMovedStepCount({
    this.wantToMoveCount,
    this.movedCount,
    this.destination,
  });

  /// 進もうとした数
  final int wantToMoveCount;

  /// 実際に進んだ数
  final int movedCount;

  /// 進んだ結果到着した lifeStep
  final LifeStepModel destination;

  /// 残り
  int get remainCount => wantToMoveCount - movedCount;
}

enum Direction { up, down, left, right }
