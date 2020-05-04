import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:flutter/foundation.dart';

class LifeStepModel {
  LifeStepModel({
    @required this.id,
    @required this.lifeEvent,
    @required this.right,
    @required this.left,
    @required this.up,
    @required this.down,
    @required this.isStart,
    @required this.isGoal,
  });

  final int id;

  final LifeEventModel lifeEvent;

  final bool isStart;
  final bool isGoal;

  LifeStepModel up;
  LifeStepModel down;
  LifeStepModel right;
  LifeStepModel left;

  LifeStepModel getNext(int num) {
    var current = this;
    var destination = this;
    var count = 0;
    while (current != null && count < num) {
      // FIXME: 分岐が無いことを前提にしている。分岐があるとバグる。
      final next = [
        current.up,
        current.down,
        current.right,
        current.left,
      ].firstWhere((el) => el != null, orElse: () => null);
      current = next;
      if (next != null) destination = next;
      count++;
    }
    return destination;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => other is LifeStepModel && other.id == id;
}
