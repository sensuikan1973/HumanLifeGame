import 'dart:io';

import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/models/common/life_road.dart';
import 'package:HumanLifeGame/models/common/life_step.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('setDirectionsForLifeStepsOnBoard', () {
    final lifeStepList = List.generate(
        LifeRoadModel.height,
        (y) => List.generate(
              LifeRoadModel.width,
              (x) {
                final start = LifeEventModel(LifeEventTarget.myself, LifeEventType.start);
                final goals = LifeEventModel(LifeEventTarget.myself, LifeEventType.goal);
                final gains = LifeEventModel(LifeEventTarget.myself, LifeEventType.gainLifeItem);
                final direc = LifeEventModel(LifeEventTarget.myself, LifeEventType.selectDirection);
                final blank = LifeEventModel(LifeEventTarget.myself, LifeEventType.nothing);
                final data = [
                  [start, gains, direc, gains, gains, gains, goals],
                  [blank, blank, gains, blank, blank, gains, blank],
                  [blank, blank, gains, gains, gains, gains, blank],
                  [blank, blank, blank, blank, blank, blank, blank],
                  [blank, blank, blank, blank, blank, blank, blank],
                  [blank, blank, blank, blank, blank, blank, blank],
                  [blank, blank, blank, blank, blank, blank, blank]
                ];
                return LifeStepModel(
                  id: x + (y * LifeRoadModel.width), // 一意になるようにしたいだけ。仮。
                  lifeEvent: data[y][x],
                  right: null,
                  left: null,
                  up: null,
                  down: null,
                );
              },
            ));

    final model = LifeRoadModel()
      ..lifeStepsOnBoard = lifeStepList
      ..setDirectionsForLifeStepsOnBoard(lifeStepList[0][0]);

    stdout.write('\n');
    for (var y = 0; y < model.lifeStepsOnBoard.length; ++y) {
      for (var x = 0; x < model.lifeStepsOnBoard[y].length; ++x) {
        stdout.write('type:${model.lifeStepsOnBoard[y][x].lifeEvent.type.index}   ');
      }
      stdout.write('\n');
      for (var x = 0; x < model.lifeStepsOnBoard[y].length; ++x) {
        if (model.lifeStepsOnBoard[y][x].up != null) {
          stdout.write('up:exist ');
        } else {
          stdout.write('up:null  ');
        }
      }
      stdout.write('\n');
      for (var x = 0; x < model.lifeStepsOnBoard[y].length; ++x) {
        if (model.lifeStepsOnBoard[y][x].down != null) {
          stdout.write('dn:exist ');
        } else {
          stdout.write('dn:null  ');
        }
      }
      stdout.write('\n');
      for (var x = 0; x < model.lifeStepsOnBoard[y].length; ++x) {
        if (model.lifeStepsOnBoard[y][x].right != null) {
          stdout.write('rl:exist ');
        } else {
          stdout.write('rl:null  ');
        }
      }
      stdout.write('\n');
      for (var x = 0; x < model.lifeStepsOnBoard[y].length; ++x) {
        if (model.lifeStepsOnBoard[y][x].left != null) {
          stdout.write('lt:exist ');
        } else {
          stdout.write('lt:null  ');
        }
      }
      stdout.write('\n\n');
    }
  });
}
