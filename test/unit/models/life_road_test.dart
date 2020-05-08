import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/models/common/life_road.dart';
import 'package:HumanLifeGame/models/common/life_step.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final start = LifeEventModel(LifeEventTarget.myself, LifeEventType.start, params: <String, dynamic>{});
  final goals = LifeEventModel(LifeEventTarget.myself, LifeEventType.goal, params: <String, dynamic>{});
  final gains = LifeEventModel(LifeEventTarget.myself, LifeEventType.gainLifeItems, params: <String, dynamic>{});
  final direc = LifeEventModel(LifeEventTarget.myself, LifeEventType.selectDirection, params: <String, dynamic>{});
  final blank = LifeEventModel(LifeEventTarget.myself, LifeEventType.nothing, params: <String, dynamic>{});

  final epBlank = ExactryPointer(up: false, down: false, right: false, left: false);
  final epUp = ExactryPointer(up: true, down: false, right: false, left: false);
  final epDown = ExactryPointer(up: false, down: true, right: false, left: false);
  final epRight = ExactryPointer(up: false, down: false, right: true, left: false);
  final epLeft = ExactryPointer(up: false, down: false, right: false, left: true);
  final epBrDR = ExactryPointer(up: false, down: true, right: true, left: false);
  final epBrDL = ExactryPointer(up: false, down: true, right: false, left: true);
  final epBrUDR = ExactryPointer(up: true, down: true, right: true, left: false);

  test('ditect a single direction ', () {
    final testData = [
      [start, gains, gains, gains, gains, gains, gains],
      [blank, blank, blank, blank, blank, blank, gains],
      [goals, blank, blank, blank, blank, blank, gains],
      [gains, blank, blank, blank, blank, blank, gains],
      [gains, blank, blank, blank, blank, blank, gains],
      [gains, blank, blank, blank, blank, blank, gains],
      [gains, gains, gains, gains, gains, gains, gains],
    ];
    final checkList = [
      [epRight, epRight, epRight, epRight, epRight, epRight, epDown],
      [epBlank, epBlank, epBlank, epBlank, epBlank, epBlank, epDown],
      [epBlank, epBlank, epBlank, epBlank, epBlank, epBlank, epDown],
      [epUp, epBlank, epBlank, epBlank, epBlank, epBlank, epDown],
      [epUp, epBlank, epBlank, epBlank, epBlank, epBlank, epDown],
      [epUp, epBlank, epBlank, epBlank, epBlank, epBlank, epDown],
      [epUp, epLeft, epLeft, epLeft, epLeft, epLeft, epLeft],
    ];
    _TestExecuterForDirectionTest(testData: testData, checkList: checkList).test();
  });
  test('ditect a branch direction', () {
    final testData = [
      [start, direc, gains, gains, gains, gains, blank],
      [blank, gains, blank, blank, blank, gains, blank],
      [blank, gains, gains, gains, gains, gains, gains],
      [blank, blank, blank, blank, blank, blank, gains],
      [goals, gains, gains, gains, gains, gains, direc],
      [blank, gains, blank, blank, blank, blank, gains],
      [blank, gains, gains, gains, gains, gains, gains],
    ];

    final checkList = [
      [epRight, epBrDR, epRight, epRight, epRight, epDown, epBlank],
      [epBlank, epDown, epBlank, epBlank, epBlank, epDown, epBlank],
      [epBlank, epRight, epRight, epRight, epRight, epRight, epDown],
      [epBlank, epBlank, epBlank, epBlank, epBlank, epBlank, epDown],
      [epBlank, epLeft, epLeft, epLeft, epLeft, epLeft, epBrDL],
      [epBlank, epUp, epBlank, epBlank, epBlank, epBlank, epDown],
      [epBlank, epUp, epLeft, epLeft, epLeft, epLeft, epLeft],
    ];

    _TestExecuterForDirectionTest(testData: testData, checkList: checkList).test();
  });
  test('ditect two branch direction', () {
    final testData = [
      [start, direc, gains, gains, gains, gains, goals],
      [blank, gains, blank, blank, blank, gains, blank],
      [blank, gains, direc, gains, gains, gains, blank],
      [blank, blank, gains, blank, gains, blank, blank],
      [blank, blank, gains, gains, gains, blank, blank],
      [blank, blank, blank, blank, blank, blank, blank],
      [blank, blank, blank, blank, blank, blank, blank],
    ];

    final checkList = [
      [epRight, epBrDR, epRight, epRight, epRight, epRight, epBlank],
      [epBlank, epDown, epBlank, epBlank, epBlank, epUp, epBlank],
      [epBlank, epRight, epBrDR, epRight, epRight, epUp, epBlank],
      [epBlank, epBlank, epDown, epBlank, epUp, epBlank, epBlank],
      [epBlank, epBlank, epRight, epRight, epUp, epBlank, epBlank],
      [epBlank, epBlank, epBlank, epBlank, epBlank, epBlank, epBlank],
      [epBlank, epBlank, epBlank, epBlank, epBlank, epBlank, epBlank],
    ];

    _TestExecuterForDirectionTest(testData: testData, checkList: checkList).test();
  });

  test('ditect three branch direction', () {
    final testData = [
      [blank, gains, gains, gains, gains, gains, blank],
      [blank, gains, blank, blank, blank, gains, blank],
      [blank, gains, blank, blank, blank, gains, blank],
      [start, direc, gains, gains, gains, gains, goals],
      [blank, gains, blank, blank, blank, gains, blank],
      [blank, gains, blank, blank, blank, gains, blank],
      [blank, gains, gains, gains, gains, gains, blank],
    ];

    final checkList = [
      [epBlank, epRight, epRight, epRight, epRight, epDown, epBlank],
      [epBlank, epUp, epBlank, epBlank, epBlank, epDown, epBlank],
      [epBlank, epUp, epBlank, epBlank, epBlank, epDown, epBlank],
      [epRight, epBrUDR, epRight, epRight, epRight, epRight, epBlank],
      [epBlank, epDown, epBlank, epBlank, epBlank, epUp, epBlank],
      [epBlank, epDown, epBlank, epBlank, epBlank, epUp, epBlank],
      [epBlank, epRight, epRight, epRight, epRight, epUp, epBlank],
    ];

    _TestExecuterForDirectionTest(testData: testData, checkList: checkList).test();
  });
}

class _TestExecuterForDirectionTest {
  _TestExecuterForDirectionTest({
    @required this.testData,
    @required this.checkList,
  }) {
    lifeStepList = List.generate(
      LifeRoadModel.height,
      (y) => List.generate(
        LifeRoadModel.width,
        (x) => LifeStepModel(
          id: x + (y * LifeRoadModel.width),
          lifeEvent: testData[y][x],
          right: null,
          left: null,
          up: null,
          down: null,
        ),
      ),
    );
    model = LifeRoadModel()..lifeStepsOnBoard = lifeStepList;
  }

  final List<List<LifeEventModel>> testData;
  final List<List<ExactryPointer>> checkList;

  List<List<LifeStepModel>> lifeStepList;
  LifeRoadModel model;

  void test() {
    model.setDirectionsForLifeStepsOnBoard(model.start);

    for (var y = 0; y < LifeRoadModel.height; ++y) {
      for (var x = 0; x < LifeRoadModel.width; ++x) {
        final up = model.lifeStepsOnBoard[y][x].up != null;
        expect(up, checkList[y][x].up);
        final down = model.lifeStepsOnBoard[y][x].down != null;
        expect(down, checkList[y][x].down);
        final right = model.lifeStepsOnBoard[y][x].right != null;
        expect(right, checkList[y][x].right);
        final left = model.lifeStepsOnBoard[y][x].left != null;
        expect(left, checkList[y][x].left);
      }
    }
  }
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
