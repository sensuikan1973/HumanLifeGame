import 'package:HumanLifeGame/api/firestore/store.dart';
import 'package:HumanLifeGame/entities/life_step_entity.dart';
import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/models/play_room/play_room_notifier.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helper/firestore/life_event_helper.dart';
import '../../helper/firestore/life_road_helper.dart';
import '../../helper/firestore/play_room_helper.dart';
import '../../helper/firestore/user_helper.dart';
import '../../mocks/auth.dart';
import '../../mocks/dice.dart';

Future<void> main() async {
  final user = MockFirebaseUser();
  const i18n = I18n('en');

  test('without directionEvent', () async {
    final lifeEvents = [
      [startEvent, gainEvent, gainEvent, gainEvent, gainEvent, gainEvent, goalEvent],
      [blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent],
      [blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent],
      [blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent],
      [blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent],
      [blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent],
      [blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent],
    ];
    final store = Store(MockFirestoreInstance());
    final humans = [await createUser(store), await createUser(store, uid: user.uid)];
    final lifeRoad = await createLifeRoad(store, lifeEvents: lifeEvents);

    const roll = 5; // 5しか出ないサイコロを使う
    final dice = MockDice(roll);
    final playRoomNotifier = PlayRoomNotifier(
      i18n,
      dice,
      store,
      await createPlayRoom(
        store,
        lifeRoad: lifeRoad.ref,
        host: humans.first.ref,
        humans: humans.map((el) => el.ref).toList(),
      ),
    );
    await playRoomNotifier.init();

    // 初期位置
    for (final human in playRoomNotifier.value.humans) {
      final position = playRoomNotifier.value.positionsByHumanId[human.id];
      expect(position.x, 0);
      expect(position.y, 0);
    }
    expect(playRoomNotifier.value.allHumansReachedTheGoal, false);

    // human 一人目 がサイコロを振って進む
    await playRoomNotifier.rollDice();
    expect(playRoomNotifier.value.positionsByHumanId[humans.first.id].x, roll);

    // human 二人目 がサイコロを振って進む
    await playRoomNotifier.rollDice();
    expect(playRoomNotifier.value.positionsByHumanId[humans[1].id].x, roll);

    // human 一人目 がサイコロを振って進む
    await playRoomNotifier.rollDice();
    expect(playRoomNotifier.value.positionsByHumanId[humans.first.id].x, lifeRoad.entity.width - 1);

    // human 二人目 がサイコロを振って進む
    await playRoomNotifier.rollDice();
    expect(playRoomNotifier.value.positionsByHumanId[humans[1].id].x, lifeRoad.entity.width - 1);
    expect(playRoomNotifier.value.allHumansReachedTheGoal, true);
  });

  group('with directionEvent', () {
    final lifeEvents = [
      [startEvent, directionEvent, gainEvent, gainEvent],
      [blankEvent, gainEvent, blankEvent, gainEvent],
      [blankEvent, gainEvent, gainEvent, goalEvent],
      [blankEvent, blankEvent, blankEvent, blankEvent],
    ];

    test('Dice roll is 1', () async {
      final store = Store(MockFirestoreInstance());
      final humans = [await createUser(store), await createUser(store, uid: user.uid)];
      final lifeRoad = await createLifeRoad(store, lifeEvents: lifeEvents);

      const roll = 1;
      final dice = MockDice(1);
      final playRoomNotifier = PlayRoomNotifier(
        i18n,
        dice,
        store,
        await createPlayRoom(
          store,
          lifeRoad: lifeRoad.ref,
          host: humans.first.ref,
          humans: humans.map((el) => el.ref).toList(),
        ),
      );
      await playRoomNotifier.init();

      // human 一人目 がサイコロを振って進む
      await playRoomNotifier.rollDice();
      expect(playRoomNotifier.value.positionsByHumanId[humans.first.id].x, roll);
      expect(playRoomNotifier.value.positionsByHumanId[humans.first.id].y, 0);

      // human 二人目 がサイコロを振って進む
      await playRoomNotifier.rollDice();
      expect(playRoomNotifier.value.positionsByHumanId[humans[1].id].x, roll);
      expect(playRoomNotifier.value.positionsByHumanId[humans[1].id].y, 0);

      // human 一人目 がサイコロを振って進もうとする
      await playRoomNotifier.rollDice();
      // しかし分岐地点なので、方向の選択を求められる
      expect(playRoomNotifier.value.requireSelectDirection, true);
      expect(playRoomNotifier.value.currentHumanLifeStep.hasUp, false);
      expect(playRoomNotifier.value.currentHumanLifeStep.hasDown, true);
      expect(playRoomNotifier.value.currentHumanLifeStep.hasLeft, false);
      expect(playRoomNotifier.value.currentHumanLifeStep.hasRight, true);
      // 右を選ぶ
      await playRoomNotifier.chooseDirection(Direction.right);
      expect(playRoomNotifier.value.positionsByHumanId[humans.first.id].x, 2);
      expect(playRoomNotifier.value.positionsByHumanId[humans.first.id].y, 0);

      // human 二人目 がサイコロを振って進もうとする
      await playRoomNotifier.rollDice();
      // しかし分岐地点なので、方向の選択を求められる
      expect(playRoomNotifier.value.requireSelectDirection, true);
      expect(playRoomNotifier.value.currentHumanLifeStep.hasUp, false);
      expect(playRoomNotifier.value.currentHumanLifeStep.hasDown, true);
      expect(playRoomNotifier.value.currentHumanLifeStep.hasLeft, false);
      expect(playRoomNotifier.value.currentHumanLifeStep.hasRight, true);
      // 下を選ぶ
      await playRoomNotifier.chooseDirection(Direction.down);
      expect(playRoomNotifier.value.positionsByHumanId[humans[1].id].x, 1);
      expect(playRoomNotifier.value.positionsByHumanId[humans[1].id].y, 1);
    });

    test('Dice roll is 3', () async {
      final store = Store(MockFirestoreInstance());
      final humans = [await createUser(store), await createUser(store, uid: user.uid)];
      final lifeRoad = await createLifeRoad(store, lifeEvents: lifeEvents);

      const roll = 3;
      final dice = MockDice(roll);
      final playRoomNotifier = PlayRoomNotifier(
        i18n,
        dice,
        store,
        await createPlayRoom(
          store,
          lifeRoad: lifeRoad.ref,
          host: humans.first.ref,
          humans: humans.map((el) => el.ref).toList(),
        ),
      );
      await playRoomNotifier.init();

      // human 一人目 がサイコロを振って進む
      await playRoomNotifier.rollDice();
      expect(playRoomNotifier.value.positionsByHumanId[humans.first.id].x, 1);
      expect(playRoomNotifier.value.positionsByHumanId[humans.first.id].y, 0);
      // 途中で分岐地点を踏むので、方向の選択を求められる
      expect(playRoomNotifier.value.requireSelectDirection, true);
      expect(playRoomNotifier.value.currentHumanLifeStep.hasUp, false);
      expect(playRoomNotifier.value.currentHumanLifeStep.hasDown, true);
      expect(playRoomNotifier.value.currentHumanLifeStep.hasLeft, false);
      expect(playRoomNotifier.value.currentHumanLifeStep.hasRight, true);
      // 右を選ぶ
      await playRoomNotifier.chooseDirection(Direction.right);
      expect(playRoomNotifier.value.positionsByHumanId[humans.first.id].x, roll);
      expect(playRoomNotifier.value.positionsByHumanId[humans.first.id].y, 0);

      // human 二人目 がサイコロを振って進む
      await playRoomNotifier.rollDice();
      expect(playRoomNotifier.value.positionsByHumanId[humans[1].id].x, 1);
      expect(playRoomNotifier.value.positionsByHumanId[humans[1].id].y, 0);
      // 途中で分岐地点を踏むので、方向の選択を求められる
      expect(playRoomNotifier.value.requireSelectDirection, true);
      expect(playRoomNotifier.value.currentHumanLifeStep.hasUp, false);
      expect(playRoomNotifier.value.currentHumanLifeStep.hasDown, true);
      expect(playRoomNotifier.value.currentHumanLifeStep.hasLeft, false);
      expect(playRoomNotifier.value.currentHumanLifeStep.hasRight, true);
      // 下を選ぶ
      await playRoomNotifier.chooseDirection(Direction.down);
      expect(playRoomNotifier.value.positionsByHumanId[humans[1].id].x, 1);
      expect(playRoomNotifier.value.positionsByHumanId[humans[1].id].y, 2);
    });
  });

  test('the second human can play alone when human1 reach the goal', () async {
    final lifeEvents = [
      [startEvent, gainEvent, gainEvent, goalEvent],
      [blankEvent, blankEvent, blankEvent, blankEvent],
      [blankEvent, blankEvent, blankEvent, blankEvent],
      [blankEvent, blankEvent, blankEvent, blankEvent],
    ];
    final store = Store(MockFirestoreInstance());
    final humans = [await createUser(store), await createUser(store, uid: user.uid)];
    final lifeRoad = await createLifeRoad(store, lifeEvents: lifeEvents);

    final dice = MockDice();

    // human 一人目 は3しか出ないサイコロを使う
    const rollForTheFirstHuman = 3;
    when(dice.roll()).thenReturn(rollForTheFirstHuman);
    final playRoomNotifier = PlayRoomNotifier(
      i18n,
      dice,
      store,
      await createPlayRoom(
        store,
        lifeRoad: lifeRoad.ref,
        host: humans.first.ref,
        humans: humans.map((el) => el.ref).toList(),
      ),
    );
    await playRoomNotifier.init();

    // human 一人目 がサイコロを振って進む
    await playRoomNotifier.rollDice();
    expect(playRoomNotifier.value.currentTurnHuman, equals(humans[1]));
    expect(playRoomNotifier.value.positionsByHumanId[humans.first.id].x, rollForTheFirstHuman);
    expect(playRoomNotifier.value.positionsByHumanId[humans.first.id].y, 0);

    // human 二人目 は1しか出ないサイコロを使う
    const rollForTheSecondHuman = 1;
    when(dice.roll()).thenReturn(rollForTheSecondHuman);

    // human 二人目 がサイコロを振って進む
    await playRoomNotifier.rollDice();
    expect(playRoomNotifier.value.currentTurnHuman, equals(humans[1]));
    expect(playRoomNotifier.value.positionsByHumanId[humans[1].id].x, rollForTheSecondHuman);
    expect(playRoomNotifier.value.positionsByHumanId[humans[1].id].y, 0);

    // human 二人目 がサイコロを振って進む
    await playRoomNotifier.rollDice();
    expect(playRoomNotifier.value.currentTurnHuman, equals(humans[1]));
    expect(playRoomNotifier.value.positionsByHumanId[humans[1].id].x, rollForTheSecondHuman * 2);
    expect(playRoomNotifier.value.positionsByHumanId[humans[1].id].y, 0);

    // human2 がサイコロを振って進む
    await playRoomNotifier.rollDice();
    expect(playRoomNotifier.value.positionsByHumanId[humans[1].id].x, rollForTheSecondHuman * 3);
    expect(playRoomNotifier.value.positionsByHumanId[humans[1].id].y, 0);
  });
}
