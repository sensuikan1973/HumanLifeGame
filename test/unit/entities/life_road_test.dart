import 'package:HumanLifeGame/api/firestore/life_event.dart';
import 'package:HumanLifeGame/api/firestore/life_road.dart';
import 'package:HumanLifeGame/api/firestore/store.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helper/firestore/life_event_helper.dart';
import '../../helper/firestore/user_helper.dart';

void main() {
  final epBlank = _Pointer(up: false, down: false, right: false, left: false);
  final epUp = _Pointer(up: true, down: false, right: false, left: false);
  final epDown = _Pointer(up: false, down: true, right: false, left: false);
  final epRight = _Pointer(up: false, down: false, right: true, left: false);
  final epLeft = _Pointer(up: false, down: false, right: false, left: true);
  final epBrDR = _Pointer(up: false, down: true, right: true, left: false);
  final epBrDL = _Pointer(up: false, down: true, right: false, left: true);
  final epBrUDR = _Pointer(up: true, down: true, right: true, left: false);

  final store = Store(MockFirestoreInstance());

  test('detect a single direction ', () {
    final lifeEvents = [
      [startEvent, gainEvent, gainEvent, gainEvent, gainEvent, gainEvent, gainEvent],
      [blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, gainEvent],
      [goalEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, gainEvent],
      [gainEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, gainEvent],
      [gainEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, gainEvent],
      [gainEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, gainEvent],
      [gainEvent, gainEvent, gainEvent, gainEvent, gainEvent, gainEvent, gainEvent],
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
    _DirectionChecker(store, lifeEvents: lifeEvents, expectedPointers: expectedPointers).execute();
  });

  test('detect a branch direction', () {
    final lifeEvents = [
      [startEvent, directionEvent, gainEvent, gainEvent, gainEvent, gainEvent, blankEvent],
      [blankEvent, gainEvent, blankEvent, blankEvent, blankEvent, gainEvent, blankEvent],
      [blankEvent, gainEvent, gainEvent, gainEvent, gainEvent, gainEvent, gainEvent],
      [blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, gainEvent],
      [goalEvent, gainEvent, gainEvent, gainEvent, gainEvent, gainEvent, directionEvent],
      [blankEvent, gainEvent, blankEvent, blankEvent, blankEvent, blankEvent, gainEvent],
      [blankEvent, gainEvent, gainEvent, gainEvent, gainEvent, gainEvent, gainEvent],
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

    _DirectionChecker(store, lifeEvents: lifeEvents, expectedPointers: expectedPointers).execute();
  });

  test('detect two branch direction', () {
    final lifeEvents = [
      [startEvent, directionEvent, gainEvent, gainEvent, gainEvent, gainEvent, goalEvent],
      [blankEvent, gainEvent, blankEvent, blankEvent, blankEvent, gainEvent, blankEvent],
      [blankEvent, gainEvent, directionEvent, gainEvent, gainEvent, gainEvent, blankEvent],
      [blankEvent, blankEvent, gainEvent, blankEvent, gainEvent, blankEvent, blankEvent],
      [blankEvent, blankEvent, gainEvent, gainEvent, gainEvent, blankEvent, blankEvent],
      [blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent],
      [blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent],
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

    _DirectionChecker(store, lifeEvents: lifeEvents, expectedPointers: expectedPointers).execute();
  });

  test('detect three branch direction', () {
    final lifeEvents = [
      [blankEvent, gainEvent, gainEvent, gainEvent, gainEvent, gainEvent, blankEvent],
      [blankEvent, gainEvent, blankEvent, blankEvent, blankEvent, gainEvent, blankEvent],
      [blankEvent, gainEvent, blankEvent, blankEvent, blankEvent, gainEvent, blankEvent],
      [startEvent, directionEvent, gainEvent, gainEvent, gainEvent, gainEvent, goalEvent],
      [blankEvent, gainEvent, blankEvent, blankEvent, blankEvent, gainEvent, blankEvent],
      [blankEvent, gainEvent, blankEvent, blankEvent, blankEvent, gainEvent, blankEvent],
      [blankEvent, gainEvent, gainEvent, gainEvent, gainEvent, gainEvent, blankEvent],
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

    _DirectionChecker(store, lifeEvents: lifeEvents, expectedPointers: expectedPointers).execute();
  });
}

class _DirectionChecker {
  _DirectionChecker(
    this._store, {
    @required List<List<LifeEventEntity>> lifeEvents,
    @required List<List<_Pointer>> expectedPointers,
  })  : _expectedPointers = expectedPointers,
        _lifeEvents = lifeEvents;

  final Store _store;
  final List<List<_Pointer>> _expectedPointers;
  final List<List<LifeEventEntity>> _lifeEvents;

  Future<void> execute() async {
    final entity = LifeRoadEntity(
      lifeEvents: _lifeEvents ?? LifeRoadEntity.dummyLifeEvents(),
      author: (await createUser(_store)).ref,
    );
    for (var y = 0; y < entity.height; ++y) {
      for (var x = 0; x < entity.width; ++x) {
        expect(entity.lifeStepsOnBoard[y][x].hasUp, _expectedPointers[y][x].up);
        expect(entity.lifeStepsOnBoard[y][x].hasDown, _expectedPointers[y][x].down);
        expect(entity.lifeStepsOnBoard[y][x].hasRight, _expectedPointers[y][x].right);
        expect(entity.lifeStepsOnBoard[y][x].hasLeft, _expectedPointers[y][x].left);
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
