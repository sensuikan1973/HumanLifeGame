import 'package:HumanLifeGame/api/firestore/store.dart';
import 'package:HumanLifeGame/human_life_game_app.dart';
import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/models/play_room/play_room_notifier.dart';
import 'package:HumanLifeGame/screens/play_room/player_action.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../helper/firestore/life_event_helper.dart';
import '../helper/firestore/life_road_helper.dart';
import '../helper/firestore/play_room_helper.dart';
import '../helper/firestore/user_helper.dart';
import '../mocks/auth.dart';
import '../mocks/dice.dart';
import '../mocks/play_room_state.dart';
import 'helper/testable_app.dart';

Future<void> main() async {
  final i18n = await I18n.load(HumanLifeGameApp.defaultLocale);
  final user = MockFirebaseUser();
  final auth = MockAuth(user);

  testWidgets("show 'Roll the Dice' text", (tester) async {
    final lifeEvents = [
      [startEvent, gainEvent, goalEvent],
      [blankEvent, blankEvent, blankEvent],
      [blankEvent, blankEvent, blankEvent],
    ];
    final store = Store(MockFirestoreInstance());
    final humans = [await createUser(store), await createUser(store, uid: user.uid)];
    final lifeRoad = await createLifeRoad(store, lifeEvents: lifeEvents);

    final playRoomNotifier = PlayRoomNotifier(
      i18n,
      MockDice(),
      store,
      await createPlayRoom(
        store,
        lifeRoad: lifeRoad.ref,
        host: humans.first.ref,
        humans: humans.map((el) => el.ref).toList(),
      ),
    );
    await playRoomNotifier.init();

    await tester.pumpWidget(testableApp(
      auth: auth,
      store: store,
      home: ChangeNotifierProvider(create: (_) => playRoomNotifier, child: const PlayerAction()),
    ));
    await tester.pump();
    expect(find.text(i18n.rollDice), findsOneWidget);
  });

  testWidgets('show selectDirection Button. pattern1: up,right,down', (tester) async {
    final lifeEvents = [
      [blankEvent, gainEvent, gainEvent, gainEvent],
      [blankEvent, gainEvent, blankEvent, gainEvent],
      [startEvent, directionEvent, gainEvent, goalEvent],
      [blankEvent, gainEvent, blankEvent, gainEvent],
      [blankEvent, gainEvent, gainEvent, gainEvent],
    ];
    final store = Store(MockFirestoreInstance());
    final humans = [await createUser(store), await createUser(store, uid: user.uid)];
    final lifeRoad = await createLifeRoad(store, lifeEvents: lifeEvents);

    final playRoomNotifier = PlayRoomNotifier(
      i18n,
      MockDice(),
      store,
      await createPlayRoom(
        store,
        lifeRoad: lifeRoad.ref,
        host: humans.first.ref,
        humans: humans.map((el) => el.ref).toList(),
      ),
    );
    await playRoomNotifier.init();

    final state = MockPlayRoomState();
    playRoomNotifier.value = state;
    when(state.requireSelectDirection).thenReturn(true);
    when(state.currentHumanLifeStep).thenReturn(lifeRoad.entity.start.right); // 最初の分岐

    await tester.pumpWidget(testableApp(
      auth: auth,
      store: store,
      home: ChangeNotifierProvider(create: (_) => playRoomNotifier, child: const PlayerAction()),
    ));
    await tester.pump();
    final enabledIconButton = find.byWidgetPredicate((widget) => widget is IconButton && widget.onPressed != null);
    expect(enabledIconButton, findsNWidgets(3)); // 選択可能な方向は 3 つ
  });

  testWidgets('show selectDirection Button. pattern2: left,down', (tester) async {
    final lifeEvents = [
      [blankEvent, blankEvent, startEvent],
      [gainEvent, gainEvent, directionEvent],
      [goalEvent, blankEvent, gainEvent],
      [gainEvent, gainEvent, gainEvent],
    ];
    final store = Store(MockFirestoreInstance());
    final humans = [await createUser(store), await createUser(store, uid: user.uid)];
    final lifeRoad = await createLifeRoad(store, lifeEvents: lifeEvents);

    final playRoomNotifier = PlayRoomNotifier(
      i18n,
      MockDice(),
      store,
      await createPlayRoom(
        store,
        lifeRoad: lifeRoad.ref,
        host: humans.first.ref,
        humans: humans.map((el) => el.ref).toList(),
      ),
    );
    await playRoomNotifier.init();

    final state = MockPlayRoomState();
    playRoomNotifier.value = state;
    when(state.requireSelectDirection).thenReturn(true);
    when(state.currentHumanLifeStep).thenReturn(lifeRoad.entity.start.down); // 最初の分岐

    await tester.pumpWidget(testableApp(
      home: ChangeNotifierProvider(create: (_) => playRoomNotifier, child: const PlayerAction()),
    ));
    await tester.pump();
    final enabledIconButton = find.byWidgetPredicate((widget) => widget is IconButton && widget.onPressed != null);
    expect(enabledIconButton, findsNWidgets(2)); // 選択可能な方向は 2 つ
  });
}
