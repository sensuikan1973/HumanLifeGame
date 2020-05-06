import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/models/common/life_road.dart';
import 'package:HumanLifeGame/models/common/life_step.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final start = LifeEventModel(LifeEventTarget.myself, LifeEventType.start);
  final goals = LifeEventModel(LifeEventTarget.myself, LifeEventType.goal);
  final gains = LifeEventModel(LifeEventTarget.myself, LifeEventType.gainLifeItem);
  final direc = LifeEventModel(LifeEventTarget.myself, LifeEventType.selectDirection);
  final blank = LifeEventModel(LifeEventTarget.myself, LifeEventType.nothing);
  final data = [
    [start, direc, gains, gains, gains, gains, goals],
    [blank, gains, blank, blank, blank, gains, blank],
    [blank, gains, gains, gains, gains, gains, blank],
    [blank, blank, blank, blank, blank, blank, blank],
    [blank, blank, blank, blank, blank, blank, blank],
    [blank, blank, blank, blank, blank, blank, blank],
    [blank, blank, blank, blank, blank, blank, blank],
  ];
  test('setDirectionsForLifeStepsOnBoard', () {
    final lifeStepList = List.generate(
        LifeRoadModel.height,
        (y) => List.generate(
              LifeRoadModel.width,
              (x) => LifeStepModel(
                id: x + (y * LifeRoadModel.width),
                lifeEvent: data[y][x],
                right: null,
                left: null,
                up: null,
                down: null,
              ),
            ));

    final model = LifeRoadModel()
      ..lifeStepsOnBoard = lifeStepList
      ..setDirectionsForLifeStepsOnBoard(lifeStepList[0][0]);
    final blank = ExactryPointer(up: false, down: false, right: false, left: false);
    final right = ExactryPointer(up: false, down: false, right: true, left: false);
    final up = ExactryPointer(up: true, down: false, right: false, left: false);
    final down = ExactryPointer(up: false, down: true, right: false, left: false);
    final brRD = ExactryPointer(up: false, down: true, right: true, left: false);
    final exactryPointerList = [
      [right, brRD, right, right, right, right, blank],
      [blank, down, blank, blank, blank, up, blank],
      [blank, right, right, right, right, up, blank],
      [blank, blank, blank, blank, blank, blank, blank],
      [blank, blank, blank, blank, blank, blank, blank],
      [blank, blank, blank, blank, blank, blank, blank],
      [blank, blank, blank, blank, blank, blank, blank],
    ];

    for (var y = 0; y < LifeRoadModel.height; ++y) {
      for (var x = 0; x < LifeRoadModel.width; ++x) {
        final up = model.lifeStepsOnBoard[y][x].up != null;
        expect(up, exactryPointerList[y][x].up);
        final down = model.lifeStepsOnBoard[y][x].down != null;
        expect(down, exactryPointerList[y][x].down);
        final right = model.lifeStepsOnBoard[y][x].right != null;
        expect(right, exactryPointerList[y][x].right);
        final left = model.lifeStepsOnBoard[y][x].left != null;
        expect(left, exactryPointerList[y][x].left);
      }
    }
  });
}

class ExactryPointer {
  ExactryPointer({
    @required this.up,
    @required this.down,
    @required this.right,
    @required this.left,
  });
  final bool up;
  final bool down;
  final bool right;
  final bool left;
}
