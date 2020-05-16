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
    final lifeEvents = [
      [start, gains, gains, gains, gains, gains, gains],
      [blank, blank, blank, blank, blank, blank, gains],
      [goals, blank, blank, blank, blank, blank, gains],
      [gains, blank, blank, blank, blank, blank, gains],
      [gains, blank, blank, blank, blank, blank, gains],
      [gains, blank, blank, blank, blank, blank, gains],
      [gains, gains, gains, gains, gains, gains, gains],
    ];
    final expectedPointers = [
      [epRight, epRight, epRight, epRight, epRight, epRight, epDown],
      [epBlank, epBlank, epBlank, epBlank, epBlank, epBlank, epDown],
      [epBlank, epBlank, epBlank, epBlank, epBlank, epBlank, epDown],
      [epUp, epBlank, epBlank, epBlank, epBlank, epBlank, epDown],
      [epUp, epBlank, epBlank, epBlank, epBlank, epBlank, epDown],
      [epUp, epBlank, epBlank, epBlank, epBlank, epBlank, epDown],
      [epUp, epLeft, epLeft, epLeft, epLeft, epLeft, epLeft],
    ];
    _DirectionChecker(lifeEvents: lifeEvents, expectedPointers: expectedPointers).execute();
  });

  test('ditect a branch direction', () {
    final lifeEvents = [
      [start, direc, gains, gains, gains, gains, blank],
      [blank, gains, blank, blank, blank, gains, blank],
      [blank, gains, gains, gains, gains, gains, gains],
      [blank, blank, blank, blank, blank, blank, gains],
      [goals, gains, gains, gains, gains, gains, direc],
      [blank, gains, blank, blank, blank, blank, gains],
      [blank, gains, gains, gains, gains, gains, gains],
    ];

    final expectedPointers = [
      [epRight, epBrDR, epRight, epRight, epRight, epDown, epBlank],
      [epBlank, epDown, epBlank, epBlank, epBlank, epDown, epBlank],
      [epBlank, epRight, epRight, epRight, epRight, epRight, epDown],
      [epBlank, epBlank, epBlank, epBlank, epBlank, epBlank, epDown],
      [epBlank, epLeft, epLeft, epLeft, epLeft, epLeft, epBrDL],
      [epBlank, epUp, epBlank, epBlank, epBlank, epBlank, epDown],
      [epBlank, epUp, epLeft, epLeft, epLeft, epLeft, epLeft],
    ];

    _DirectionChecker(lifeEvents: lifeEvents, expectedPointers: expectedPointers).execute();
  });

  test('ditect two branch direction', () {
    final lifeEvents = [
      [start, direc, gains, gains, gains, gains, goals],
      [blank, gains, blank, blank, blank, gains, blank],
      [blank, gains, direc, gains, gains, gains, blank],
      [blank, blank, gains, blank, gains, blank, blank],
      [blank, blank, gains, gains, gains, blank, blank],
      [blank, blank, blank, blank, blank, blank, blank],
      [blank, blank, blank, blank, blank, blank, blank],
    ];

    final expectedPointers = [
      [epRight, epBrDR, epRight, epRight, epRight, epRight, epBlank],
      [epBlank, epDown, epBlank, epBlank, epBlank, epUp, epBlank],
      [epBlank, epRight, epBrDR, epRight, epRight, epUp, epBlank],
      [epBlank, epBlank, epDown, epBlank, epUp, epBlank, epBlank],
      [epBlank, epBlank, epRight, epRight, epUp, epBlank, epBlank],
      [epBlank, epBlank, epBlank, epBlank, epBlank, epBlank, epBlank],
      [epBlank, epBlank, epBlank, epBlank, epBlank, epBlank, epBlank],
    ];

    _DirectionChecker(lifeEvents: lifeEvents, expectedPointers: expectedPointers).execute();
  });

  test('ditect three branch direction', () {
    final lifeEvents = [
      [blank, gains, gains, gains, gains, gains, blank],
      [blank, gains, blank, blank, blank, gains, blank],
      [blank, gains, blank, blank, blank, gains, blank],
      [start, direc, gains, gains, gains, gains, goals],
      [blank, gains, blank, blank, blank, gains, blank],
      [blank, gains, blank, blank, blank, gains, blank],
      [blank, gains, gains, gains, gains, gains, blank],
    ];

    final expectedPointers = [
      [epBlank, epRight, epRight, epRight, epRight, epDown, epBlank],
      [epBlank, epUp, epBlank, epBlank, epBlank, epDown, epBlank],
      [epBlank, epUp, epBlank, epBlank, epBlank, epDown, epBlank],
      [epRight, epBrUDR, epRight, epRight, epRight, epRight, epBlank],
      [epBlank, epDown, epBlank, epBlank, epBlank, epUp, epBlank],
      [epBlank, epDown, epBlank, epBlank, epBlank, epUp, epBlank],
      [epBlank, epRight, epRight, epRight, epRight, epUp, epBlank],
    ];

    _DirectionChecker(lifeEvents: lifeEvents, expectedPointers: expectedPointers).execute();
  });

  test('debugMessage', () {
    final model = LifeRoadModel(lifeStepsOnBoard: LifeRoadModel.createDummyLifeStepsOnBoard());
    const expectedMessage = '''
type:1   type:3   type:6   type:6   type:6   type:6   type:0   
up:null  up:null  up:null  up:null  up:null  up:null  up:null  
dn:null  dn:exist dn:null  dn:null  dn:null  dn:exist dn:null  
rl:exist rl:exist rl:exist rl:exist rl:exist rl:null  rl:null  
lt:null  lt:null  lt:null  lt:null  lt:null  lt:null  lt:null  
type:0   type:6   type:0   type:0   type:0   type:6   type:0   
up:null  up:null  up:null  up:null  up:null  up:null  up:null  
dn:null  dn:exist dn:null  dn:null  dn:null  dn:exist dn:null  
rl:null  rl:null  rl:null  rl:null  rl:null  rl:null  rl:null  
lt:null  lt:null  lt:null  lt:null  lt:null  lt:null  lt:null  
type:0   type:6   type:6   type:6   type:6   type:6   type:6   
up:null  up:null  up:null  up:null  up:null  up:null  up:null  
dn:null  dn:null  dn:null  dn:null  dn:null  dn:null  dn:exist 
rl:null  rl:exist rl:exist rl:exist rl:exist rl:exist rl:null  
lt:null  lt:null  lt:null  lt:null  lt:null  lt:null  lt:null  
type:0   type:0   type:0   type:0   type:0   type:0   type:6   
up:null  up:null  up:null  up:null  up:null  up:null  up:null  
dn:null  dn:null  dn:null  dn:null  dn:null  dn:null  dn:exist 
rl:null  rl:null  rl:null  rl:null  rl:null  rl:null  rl:null  
lt:null  lt:null  lt:null  lt:null  lt:null  lt:null  lt:null  
type:2   type:6   type:6   type:6   type:6   type:6   type:3   
up:null  up:null  up:null  up:null  up:null  up:null  up:null  
dn:null  dn:null  dn:null  dn:null  dn:null  dn:null  dn:exist 
rl:null  rl:null  rl:null  rl:null  rl:null  rl:null  rl:null  
lt:null  lt:exist lt:exist lt:exist lt:exist lt:exist lt:exist 
type:0   type:6   type:0   type:0   type:0   type:0   type:6   
up:null  up:exist up:null  up:null  up:null  up:null  up:null  
dn:null  dn:null  dn:null  dn:null  dn:null  dn:null  dn:exist 
rl:null  rl:null  rl:null  rl:null  rl:null  rl:null  rl:null  
lt:null  lt:null  lt:null  lt:null  lt:null  lt:null  lt:null  
type:0   type:6   type:6   type:6   type:6   type:6   type:6   
up:null  up:exist up:null  up:null  up:null  up:null  up:null  
dn:null  dn:null  dn:null  dn:null  dn:null  dn:null  dn:null  
rl:null  rl:null  rl:null  rl:null  rl:null  rl:null  rl:null  
lt:null  lt:null  lt:exist lt:exist lt:exist lt:exist lt:exist \n''';
    expect(model.debugMessage(), expectedMessage);
  });
}

class _DirectionChecker {
  _DirectionChecker({
    @required List<List<LifeEventModel>> lifeEvents,
    @required List<List<_Pointer>> expectedPointers,
  })  : _expectedPointers = expectedPointers,
        _model = LifeRoadModel(
          lifeStepsOnBoard: List.generate(
            lifeEvents.length,
            (y) => List.generate(
              lifeEvents[y].length,
              (x) => LifeStepModel(
                id: x + (y * lifeEvents[y].length),
                lifeEvent: lifeEvents[y][x],
                right: null,
                left: null,
                up: null,
                down: null,
              ),
            ),
          ),
        );

  final List<List<_Pointer>> _expectedPointers;
  final LifeRoadModel _model;

  void execute() {
    for (var y = 0; y < _model.height; ++y) {
      for (var x = 0; x < _model.width; ++x) {
        final hasUp = _model.lifeStepsOnBoard[y][x].up != null;
        expect(hasUp, _expectedPointers[y][x].up);
        final hasDown = _model.lifeStepsOnBoard[y][x].down != null;
        expect(hasDown, _expectedPointers[y][x].down);
        final hasRight = _model.lifeStepsOnBoard[y][x].right != null;
        expect(hasRight, _expectedPointers[y][x].right);
        final hasLeft = _model.lifeStepsOnBoard[y][x].left != null;
        expect(hasLeft, _expectedPointers[y][x].left);
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
