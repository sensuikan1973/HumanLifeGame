import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/models/common/human.dart';
import 'package:HumanLifeGame/models/common/human_life.dart';
import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/models/common/life_event_params/gain_life_items_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/goal_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/nothing_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/select_direction_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/start_params.dart';
import 'package:HumanLifeGame/models/common/life_road.dart';
import 'package:HumanLifeGame/models/common/life_step.dart';
import 'package:HumanLifeGame/models/common/user.dart';
import 'package:HumanLifeGame/models/play_room/play_room.dart';
import 'package:HumanLifeGame/models/play_room/player_action.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/dice.dart';

void main() {
  final start = LifeEventModel(LifeEventTarget.myself, const StartParams());
  final goals = LifeEventModel(LifeEventTarget.myself, const GoalParams());
  final direc = LifeEventModel(LifeEventTarget.myself, const SelectDirectionParams());
  final gains = LifeEventModel(LifeEventTarget.myself, const GainLifeItemsParams(targetItems: []));
  final blank = LifeEventModel(LifeEventTarget.myself, const NothingParams());

  final human1 = HumanModel(id: 'h1', name: 'foo', order: 0);
  final human2 = HumanModel(id: 'h2', name: 'bar', order: 1);
  final orderedHumans = [human1, human2];
  final author = UserModel(id: 'dummyUserId', name: 'dummyUser');

  test('without Direction', () {
    final lifeEvents = [
      [start, gains, gains, gains, gains, gains, goals],
      [blank, blank, blank, blank, blank, blank, blank],
      [blank, blank, blank, blank, blank, blank, blank],
      [blank, blank, blank, blank, blank, blank, blank],
      [blank, blank, blank, blank, blank, blank, blank],
      [blank, blank, blank, blank, blank, blank, blank],
      [blank, blank, blank, blank, blank, blank, blank],
    ];
    final lifeRoad = LifeRoadModel(lifeStepsOnBoard: LifeRoadModel.createLifeStepsOnBoard(lifeEvents));
    final humanLife = HumanLifeModel(title: 'dummy HumanLife', author: author, lifeRoad: lifeRoad);
    final playRoomModel = PlayRoomNotifier(const I18n('en'), humanLife, orderedHumans: orderedHumans);

    // 初期位置
    for (final human in playRoomModel.orderedHumans) {
      final position = playRoomModel.positionsByHumanId[human.id];
      expect(position.x, 0);
      expect(position.y, 0);
    }
    expect(playRoomModel.allHumansReachedTheGoal, false);

    // 5しか出ないサイコロを使う
    final dice = MockDice();
    const roll = 5;
    when(dice.roll()).thenReturn(roll);
    final playerActionNotifier = PlayerActionNotifier(dice);

    // human1 がサイコロを振って進む
    playRoomModel.update(playerActionNotifier..rollDice());
    expect(playRoomModel.positionsByHumanId[human1.id].x, roll);

    // human2 がサイコロを振って進む
    playRoomModel.update(playerActionNotifier..rollDice());
    expect(playRoomModel.positionsByHumanId[human2.id].x, roll);

    // human1 がサイコロを振って進む
    playRoomModel.update(playerActionNotifier..rollDice());
    expect(playRoomModel.positionsByHumanId[human1.id].x, lifeRoad.width - 1);

    // human2 がサイコロを振って進む
    playRoomModel.update(playerActionNotifier..rollDice());
    expect(playRoomModel.positionsByHumanId[human2.id].x, lifeRoad.width - 1);
    expect(playRoomModel.allHumansReachedTheGoal, true);
  });

  group('with Direction', () {
    final lifeEvents = [
      [start, direc, gains, gains],
      [blank, gains, blank, gains],
      [blank, gains, gains, goals],
      [blank, blank, blank, blank],
    ];
    final lifeRoad = LifeRoadModel(lifeStepsOnBoard: LifeRoadModel.createLifeStepsOnBoard(lifeEvents));
    final humanLife = HumanLifeModel(title: 'dummy HumanLife', author: author, lifeRoad: lifeRoad);

    test('Dice roll is 1', () {
      final playRoomModel = PlayRoomNotifier(const I18n('en'), humanLife, orderedHumans: orderedHumans);
      final dice = MockDice();
      const roll = 1;
      when(dice.roll()).thenReturn(roll);
      final playerActionNotifier = PlayerActionNotifier(dice);

      // human1 がサイコロを振って進む
      playRoomModel.update(playerActionNotifier..rollDice());
      expect(playRoomModel.positionsByHumanId[human1.id].x, roll);
      expect(playRoomModel.positionsByHumanId[human1.id].y, 0);

      // human2 がサイコロを振って進む
      playRoomModel.update(playerActionNotifier..rollDice());
      expect(playRoomModel.positionsByHumanId[human2.id].x, roll);
      expect(playRoomModel.positionsByHumanId[human2.id].y, 0);

      // human1 がサイコロを振って進もうとする
      playRoomModel.update(playerActionNotifier..rollDice());
      // しかし分岐地点なので、方向の選択を求められる
      expect(playRoomModel.requireSelectDirection, true);
      expect(playRoomModel.currentPlayerLifeStep.hasUp, false);
      expect(playRoomModel.currentPlayerLifeStep.hasDown, true);
      expect(playRoomModel.currentPlayerLifeStep.hasLeft, false);
      expect(playRoomModel.currentPlayerLifeStep.hasRight, true);
      // 右を選ぶ
      playRoomModel.update(playerActionNotifier..direction = Direction.right);
      expect(playRoomModel.positionsByHumanId[human1.id].x, 2);
      expect(playRoomModel.positionsByHumanId[human1.id].y, 0);

      // human2 がサイコロを振って進もうとする
      playRoomModel.update(playerActionNotifier..rollDice());
      // しかし分岐地点なので、方向の選択を求められる
      expect(playRoomModel.requireSelectDirection, true);
      expect(playRoomModel.currentPlayerLifeStep.hasUp, false);
      expect(playRoomModel.currentPlayerLifeStep.hasDown, true);
      expect(playRoomModel.currentPlayerLifeStep.hasLeft, false);
      expect(playRoomModel.currentPlayerLifeStep.hasRight, true);
      // 下を選ぶ
      playRoomModel.update(playerActionNotifier..direction = Direction.down);
      expect(playRoomModel.positionsByHumanId[human2.id].x, 1);
      expect(playRoomModel.positionsByHumanId[human2.id].y, 1);
    });

    test('Dice roll is 3', () {
      final playRoomModel = PlayRoomNotifier(const I18n('en'), humanLife, orderedHumans: orderedHumans);
      final dice = MockDice();
      const roll = 3;
      when(dice.roll()).thenReturn(roll);
      final playerActionNotifier = PlayerActionNotifier(dice);

      // human1 がサイコロを振って進む
      playRoomModel.update(playerActionNotifier..rollDice());
      expect(playRoomModel.positionsByHumanId[human1.id].x, 1);
      expect(playRoomModel.positionsByHumanId[human1.id].y, 0);
      // 途中で分岐地点を踏むので、方向の選択を求められる
      expect(playRoomModel.requireSelectDirection, true);
      expect(playRoomModel.currentPlayerLifeStep.hasUp, false);
      expect(playRoomModel.currentPlayerLifeStep.hasDown, true);
      expect(playRoomModel.currentPlayerLifeStep.hasLeft, false);
      expect(playRoomModel.currentPlayerLifeStep.hasRight, true);
      // 右を選ぶ
      playRoomModel.update(playerActionNotifier..direction = Direction.right);
      expect(playRoomModel.positionsByHumanId[human1.id].x, 3);
      expect(playRoomModel.positionsByHumanId[human1.id].y, 0);

      // human2 がサイコロを振って進む
      playRoomModel.update(playerActionNotifier..rollDice());
      expect(playRoomModel.positionsByHumanId[human2.id].x, 1);
      expect(playRoomModel.positionsByHumanId[human2.id].y, 0);
      // 途中で分岐地点を踏むので、方向の選択を求められる
      expect(playRoomModel.requireSelectDirection, true);
      expect(playRoomModel.currentPlayerLifeStep.hasUp, false);
      expect(playRoomModel.currentPlayerLifeStep.hasDown, true);
      expect(playRoomModel.currentPlayerLifeStep.hasLeft, false);
      expect(playRoomModel.currentPlayerLifeStep.hasRight, true);
      // 下を選ぶ
      playRoomModel.update(playerActionNotifier..direction = Direction.down);
      expect(playRoomModel.positionsByHumanId[human2.id].x, 1);
      expect(playRoomModel.positionsByHumanId[human2.id].y, 2);
    });
  });
}
