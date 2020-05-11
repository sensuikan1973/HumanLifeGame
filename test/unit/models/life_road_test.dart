import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/models/common/life_event_params/gain_life_items_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/goal_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/nothing_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/select_direction_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/start_params.dart';
import 'package:HumanLifeGame/models/common/life_road.dart';
import 'package:HumanLifeGame/models/common/life_step.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final start = LifeEventModel(LifeEventTarget.myself, const StartParams());
  final goals = LifeEventModel(LifeEventTarget.myself, const GoalParams());
  final gains = LifeEventModel(LifeEventTarget.myself, const GainLifeItemsParams(targetItems: []));
  final direc = LifeEventModel(LifeEventTarget.myself, const SelectDirectionParams());
  final blank = LifeEventModel(LifeEventTarget.myself, const NothingParams());

  final epBlank = _Pointer(up: false, down: false, right: false, left: false);
  final epUp = _Pointer(up: true, down: false, right: false, left: false);
  final epDown = _Pointer(up: false, down: true, right: false, left: false);
  final epRight = _Pointer(up: false, down: false, right: true, left: false);
  final epLeft = _Pointer(up: false, down: false, right: false, left: true);
  final epBrDR = _Pointer(up: false, down: true, right: true, left: false);
  final epBrDL = _Pointer(up: false, down: true, right: false, left: true);
  final epBrUDR = _Pointer(up: true, down: true, right: true, left: false);

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
    _TestExecutorForDirectionTest(lifeEvents: testData, expectedPointers: checkList).test();
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

    _TestExecutorForDirectionTest(lifeEvents: testData, expectedPointers: checkList).test();
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

    _TestExecutorForDirectionTest(lifeEvents: testData, expectedPointers: checkList).test();
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

    _TestExecutorForDirectionTest(lifeEvents: testData, expectedPointers: checkList).test();
  });

  test('debugMessage', () {
    final model = LifeRoadModel(lifeStepsOnBoard: LifeRoadModel.createDummyLifeStepsOnBoard());
    const text = 'type:1   type:6   type:6   type:6   type:6   type:6   type:2   \n'
        'up:null  up:null  up:null  up:null  up:null  up:null  up:null  \n'
        'dn:null  dn:null  dn:null  dn:null  dn:null  dn:null  dn:null  \n'
        'rl:exist rl:exist rl:exist rl:exist rl:exist rl:exist rl:null  \n'
        'lt:null  lt:null  lt:null  lt:null  lt:null  lt:null  lt:null  \n'
        'type:0   type:0   type:0   type:0   type:0   type:0   type:0   \n'
        'up:null  up:null  up:null  up:null  up:null  up:null  up:null  \n'
        'dn:null  dn:null  dn:null  dn:null  dn:null  dn:null  dn:null  \n'
        'rl:null  rl:null  rl:null  rl:null  rl:null  rl:null  rl:null  \n'
        'lt:null  lt:null  lt:null  lt:null  lt:null  lt:null  lt:null  \n'
        'type:0   type:0   type:0   type:0   type:0   type:0   type:0   \n'
        'up:null  up:null  up:null  up:null  up:null  up:null  up:null  \n'
        'dn:null  dn:null  dn:null  dn:null  dn:null  dn:null  dn:null  \n'
        'rl:null  rl:null  rl:null  rl:null  rl:null  rl:null  rl:null  \n'
        'lt:null  lt:null  lt:null  lt:null  lt:null  lt:null  lt:null  \n'
        'type:0   type:0   type:0   type:0   type:0   type:0   type:0   \n'
        'up:null  up:null  up:null  up:null  up:null  up:null  up:null  \n'
        'dn:null  dn:null  dn:null  dn:null  dn:null  dn:null  dn:null  \n'
        'rl:null  rl:null  rl:null  rl:null  rl:null  rl:null  rl:null  \n'
        'lt:null  lt:null  lt:null  lt:null  lt:null  lt:null  lt:null  \n'
        'type:0   type:0   type:0   type:0   type:0   type:0   type:0   \n'
        'up:null  up:null  up:null  up:null  up:null  up:null  up:null  \n'
        'dn:null  dn:null  dn:null  dn:null  dn:null  dn:null  dn:null  \n'
        'rl:null  rl:null  rl:null  rl:null  rl:null  rl:null  rl:null  \n'
        'lt:null  lt:null  lt:null  lt:null  lt:null  lt:null  lt:null  \n'
        'type:0   type:0   type:0   type:0   type:0   type:0   type:0   \n'
        'up:null  up:null  up:null  up:null  up:null  up:null  up:null  \n'
        'dn:null  dn:null  dn:null  dn:null  dn:null  dn:null  dn:null  \n'
        'rl:null  rl:null  rl:null  rl:null  rl:null  rl:null  rl:null  \n'
        'lt:null  lt:null  lt:null  lt:null  lt:null  lt:null  lt:null  \n'
        'type:0   type:0   type:0   type:0   type:0   type:0   type:0   \n'
        'up:null  up:null  up:null  up:null  up:null  up:null  up:null  \n'
        'dn:null  dn:null  dn:null  dn:null  dn:null  dn:null  dn:null  \n'
        'rl:null  rl:null  rl:null  rl:null  rl:null  rl:null  rl:null  \n'
        'lt:null  lt:null  lt:null  lt:null  lt:null  lt:null  lt:null  \n';
    expect(model.debugMessage(), text);
  });
}

class _TestExecutorForDirectionTest {
  _TestExecutorForDirectionTest({
    @required this.lifeEvents,
    @required this.expectedPointers,
  }) {
    final lifeStepsOnBoard = List.generate(
      LifeRoadModel.height,
      (y) => List.generate(
        LifeRoadModel.width,
        (x) => LifeStepModel(
          id: x + (y * LifeRoadModel.width),
          lifeEvent: lifeEvents[y][x],
          right: null,
          left: null,
          up: null,
          down: null,
        ),
      ),
    );
    model = LifeRoadModel(lifeStepsOnBoard: lifeStepsOnBoard);
  }

  final List<List<LifeEventModel>> lifeEvents;
  final List<List<_Pointer>> expectedPointers;

  List<List<LifeStepModel>> lifeStepList;
  LifeRoadModel model;

  void test() {
    for (var y = 0; y < LifeRoadModel.height; ++y) {
      for (var x = 0; x < LifeRoadModel.width; ++x) {
        final up = model.lifeStepsOnBoard[y][x].up != null;
        expect(up, expectedPointers[y][x].up);
        final down = model.lifeStepsOnBoard[y][x].down != null;
        expect(down, expectedPointers[y][x].down);
        final right = model.lifeStepsOnBoard[y][x].right != null;
        expect(right, expectedPointers[y][x].right);
        final left = model.lifeStepsOnBoard[y][x].left != null;
        expect(left, expectedPointers[y][x].left);
      }
    }
  }
}

class _Pointer {
  _Pointer({
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
