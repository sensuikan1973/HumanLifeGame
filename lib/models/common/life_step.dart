import 'package:flutter/foundation.dart';

import 'life_event.dart';

class LifeStepModel {
  LifeStepModel({
    @required this.id,
    @required this.lifeEvent,
    @required this.right,
    @required this.left,
    @required this.up,
    @required this.down,
  });

  final int id;

  final LifeEventModel lifeEvent;

  LifeStepModel up;
  LifeStepModel down;
  LifeStepModel right;
  LifeStepModel left;

  bool get isStart => lifeEvent.type == LifeEventType.start;
  bool get isGoal => lifeEvent.type == LifeEventType.goal;

  LifeStepModel getNext(int num) {
    var current = this;
    var count = 0;
    while (current != null && count < num) {
      // FIXME: 分岐が無いことを前提にしている。分岐があるとバグる。
      final next = [
        current.up,
        current.down,
        current.right,
        current.left,
      ].firstWhere((el) => el != null, orElse: () => null);
      if (next == null) break;
      current = next;
      count++;
    }
    return current;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => other is LifeStepModel && other.id == id;
}
