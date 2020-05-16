import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/models/common/human.dart';
import 'package:HumanLifeGame/models/common/human_life.dart';
import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/models/common/life_event_params/gain_life_items_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/goal_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/nothing_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/start_params.dart';
import 'package:HumanLifeGame/models/common/life_road.dart';
import 'package:HumanLifeGame/models/common/user.dart';
import 'package:HumanLifeGame/models/play_room/play_room.dart';
import 'package:HumanLifeGame/models/play_room/player_action.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helper/life_steps_on_board_helper.dart';
import '../../mocks/mocks.dart';

void main() {
  test('without Direction', () {
    final start = LifeEventModel(LifeEventTarget.myself, const StartParams());
    final goals = LifeEventModel(LifeEventTarget.myself, const GoalParams());
    final gains = LifeEventModel(LifeEventTarget.myself, const GainLifeItemsParams(targetItems: []));
    final blank = LifeEventModel(LifeEventTarget.myself, const NothingParams());
    final lifeEvents = [
      [start, gains, gains, gains, gains, gains, goals],
      [blank, blank, blank, blank, blank, blank, blank],
      [blank, blank, blank, blank, blank, blank, blank],
      [blank, blank, blank, blank, blank, blank, blank],
      [blank, blank, blank, blank, blank, blank, blank],
      [blank, blank, blank, blank, blank, blank, blank],
      [blank, blank, blank, blank, blank, blank, blank],
    ];
    final lifeRoad = LifeRoadModel(lifeStepsOnBoard: createDummyLifeStepsOnBoard(lifeEvents));

    final humanLife = HumanLifeModel(
      title: 'dummy HumanLife',
      author: UserModel(id: 'dummyUserId', name: 'dummyUser'),
      lifeRoad: lifeRoad,
    );
    final human1 = HumanModel(id: 'h1', name: 'foo');
    final human2 = HumanModel(id: 'h2', name: 'bar');

    final playRoomModel = PlayRoomNotifier(
      I18n('en'),
      humanLife,
      orderedHumans: [human1, human2],
    );

    // 初期位置
    for (final human in playRoomModel.orderedHumans) {
      final position = playRoomModel.positionsByHumanId[human.id];
      expect(position.x, 0);
      expect(position.y, 0);
    }

    // 5しか出ないサイコロをセットする
    final dice = MockDice();
    const roll = 5;
    when(dice.roll()).thenReturn(roll);
    playRoomModel.update(PlayerActionNotifier(dice)..rollDice());

    // human1 がサイコロを振って進む
    expect(playRoomModel.positionsByHumanId[human1.id].x, roll);
    expect(playRoomModel.allHumansReachedTheGoal, false);

    // human2 がサイコロを振って進む
    playRoomModel.update(PlayerActionNotifier(dice)..rollDice());
    expect(playRoomModel.positionsByHumanId[human2.id].x, roll);
    expect(playRoomModel.allHumansReachedTheGoal, false);

    // human1 がサイコロを振って進む
    playRoomModel.update(PlayerActionNotifier(dice)..rollDice());
    expect(playRoomModel.positionsByHumanId[human1.id].x, lifeRoad.width - 1);
    expect(playRoomModel.allHumansReachedTheGoal, false);

    // human2 がサイコロを振って進む
    playRoomModel.update(PlayerActionNotifier(dice)..rollDice());
    expect(playRoomModel.positionsByHumanId[human2.id].x, lifeRoad.width - 1);
    expect(playRoomModel.allHumansReachedTheGoal, true);
  });
}
