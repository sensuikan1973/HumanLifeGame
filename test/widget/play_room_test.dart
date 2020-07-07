import 'package:HumanLifeGame/api/firestore/store.dart';
import 'package:HumanLifeGame/human_life_game_app.dart';
import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/screens/play_room/announcement.dart';
import 'package:HumanLifeGame/screens/play_room/dice_result.dart';
import 'package:HumanLifeGame/screens/play_room/life_stages.dart';
import 'package:HumanLifeGame/screens/play_room/play_room.dart';
import 'package:HumanLifeGame/screens/play_room/play_view.dart';
import 'package:HumanLifeGame/screens/play_room/player_action.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helper/firestore/life_event_helper.dart';
import '../helper/firestore/life_road_helper.dart';
import '../helper/firestore/play_room_helper.dart';
import '../helper/firestore/user_helper.dart';
import '../mocks/auth.dart';
import '../mocks/dice.dart';
import 'helper/testable_app.dart';

Future<void> main() async {
  final i18n = await I18n.load(HumanLifeGameApp.defaultLocale);
  final user = MockFirebaseUser();
  final auth = MockAuth(user);

  final lifeEvents = [
    [startEvent, gainEvent, gainEvent, gainEvent, gainEvent, gainEvent, goalEvent],
    [blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent],
    [blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent],
    [blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent],
    [blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent],
    [blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent],
    [blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent],
  ];

  setUp(() {
    // See: https://github.com/flutter/flutter/issues/12994#issuecomment-397321431
    WidgetsBinding.instance.renderView.configuration = TestViewConfiguration(size: const Size(1440, 1024));
  });

  testWidgets('show some widgets', (tester) async {
    final store = Store(MockFirestoreInstance());
    final humans = [await createUser(store), await createUser(store, uid: user.uid)];
    await tester.pumpWidget(testableApp(
      store: store,
      auth: auth,
      home: PlayRoom.inProviders(
        playRoomDoc: await createPlayRoom(
          store,
          lifeRoad: (await createLifeRoad(store, lifeEvents: lifeEvents)).ref,
          humans: humans.map((el) => el.ref).toList(),
        ),
      ),
    ));
    await tester.pumpAndSettle(PlayRoomState.showDelay);
    expect(find.byType(PlayerAction), findsOneWidget);
    expect(find.byType(DiceResult), findsOneWidget);
    expect(find.byType(LifeStages), findsOneWidget);
    expect(find.byType(Announcement), findsOneWidget);
    expect(find.byType(PlayView), findsOneWidget);
  });

  testWidgets('random value(1 <= value <= 6) should be displayed when dice is rolled', (tester) async {
    const roll = 5;
    final dice = MockDice(roll);
    final store = Store(MockFirestoreInstance());
    final humans = [await createUser(store), await createUser(store, uid: user.uid)];
    await tester.pumpWidget(testableApp(
      dice: dice,
      auth: auth,
      store: store,
      home: PlayRoom.inProviders(
        playRoomDoc: await createPlayRoom(
          store,
          lifeRoad: (await createLifeRoad(store, lifeEvents: lifeEvents)).ref,
          host: humans.first.ref,
          humans: humans.map((el) => el.ref).toList(),
        ),
      ),
    ));
    await tester.pumpAndSettle(PlayRoomState.showDelay);

    await tester.tap(find.byKey(PlayerAction.rollButtonKey));
    await tester.pump();
    expect(find.text(roll.toString()), findsOneWidget);
  });

  testWidgets('show Announcement message when dice is rolled', (tester) async {
    const roll = 5;
    final dice = MockDice(roll);
    final store = Store(MockFirestoreInstance());
    final humans = [await createUser(store), await createUser(store, uid: user.uid)];
    await tester.pumpWidget(testableApp(
      dice: dice,
      auth: auth,
      store: store,
      home: PlayRoom.inProviders(
        playRoomDoc: await createPlayRoom(
          store,
          lifeRoad: (await createLifeRoad(store, lifeEvents: lifeEvents)).ref,
          host: humans.first.ref,
          humans: humans.map((el) => el.ref).toList(),
        ),
      ),
    ));
    await tester.pumpAndSettle(PlayRoomState.showDelay);

    final rollDiceButton = find.byKey(PlayerAction.rollButtonKey);
    await tester.tap(rollDiceButton);
    await tester.pump();
    expect(find.text(i18n.rollAnnouncement(humans.first.entity.displayName, roll)), findsOneWidget);

    await tester.tap(rollDiceButton);
    await tester.pump();
    expect(find.text(i18n.rollAnnouncement(humans[1].entity.displayName, roll)), findsOneWidget);

    await tester.tap(rollDiceButton);
    await tester.pump();
    expect(find.text(i18n.rollAnnouncement(humans.first.entity.displayName, roll)), findsOneWidget);
  });

  testWidgets('roll-the-dice button should be disabled when all Humans reached the goal', (tester) async {
    final store = Store(MockFirestoreInstance());
    final humans = [await createUser(store), await createUser(store, uid: user.uid)];
    await tester.pumpWidget(testableApp(
      auth: auth,
      store: store,
      home: MediaQuery(
        data: const MediaQueryData(size: Size(1440, 1024)),
        child: PlayRoom.inProviders(
          playRoomDoc: await createPlayRoom(
            store,
            lifeRoad: (await createLifeRoad(store, lifeEvents: lifeEvents)).ref,
            host: humans.first.ref,
            humans: humans.map((el) => el.ref).toList(),
          ),
        ),
      ),
    ));
    await tester.pumpAndSettle(PlayRoomState.showDelay);

    final rollDiceButton = find.byKey(PlayerAction.rollButtonKey);

    await tester.tap(rollDiceButton);
    await tester.pump();
    expect(tester.widget<FlatButton>(rollDiceButton).enabled, true);

    await tester.tap(rollDiceButton);
    await tester.pump();
    expect(tester.widget<FlatButton>(rollDiceButton).enabled, false);
  }, skip: true);

  testWidgets('show result dialog', (tester) async {
    final store = Store(MockFirestoreInstance());
    final humans = [await createUser(store), await createUser(store, uid: user.uid)];
    await tester.pumpWidget(testableApp(
      auth: auth,
      store: store,
      home: MediaQuery(
        data: const MediaQueryData(size: Size(1440, 1024)),
        child: PlayRoom.inProviders(
          playRoomDoc: await createPlayRoom(
            store,
            lifeRoad: (await createLifeRoad(store, lifeEvents: lifeEvents)).ref,
            host: humans.first.ref,
            humans: humans.map((el) => el.ref).toList(),
          ),
        ),
      ),
    ));
    await tester.pumpAndSettle(PlayRoomState.showDelay);

    final rollDiceButton = find.byKey(PlayerAction.rollButtonKey);
    await tester.tap(rollDiceButton);
    await tester.pump();

    await tester.tap(rollDiceButton);
    await tester.pumpAndSettle();
    await tester.pump();
    expect(find.text(i18n.resultAnnouncementDialogMessage), findsOneWidget);
  }, skip: true);

  testWidgets('not show dialog after rebuilt', (tester) async {
    final store = Store(MockFirestoreInstance());
    final humans = [await createUser(store), await createUser(store, uid: user.uid)];
    await tester.pumpWidget(testableApp(
      auth: auth,
      store: store,
      home: MediaQuery(
        data: const MediaQueryData(size: Size(1440, 1024)),
        child: PlayRoom.inProviders(
          playRoomDoc: await createPlayRoom(
            store,
            lifeRoad: (await createLifeRoad(store, lifeEvents: lifeEvents)).ref,
            host: humans.first.ref,
            humans: humans.map((el) => el.ref).toList(),
          ),
        ),
      ),
    ));
    await tester.pumpAndSettle(PlayRoomState.showDelay);

    final rollDiceButton = find.byKey(const Key('playerActionDiceRollButton'));
    await tester.tap(rollDiceButton);
    await tester.pump();

    // ゲームが終了し、タイアログが表示される
    await tester.tap(rollDiceButton);
    await tester.pumpAndSettle();
    expect(find.text(i18n.resultAnnouncementDialogMessage), findsOneWidget);

    // 画面タップで、タイアログが消える
    // (10, 10)は、画面上の適当な座標
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();
    expect(find.text(i18n.resultAnnouncementDialogMessage), findsNothing);

    // 画面サイズを変更しリビルドされても、タイアログが再表示されない
    await tester.pumpWidget(testableApp(
      home: MediaQuery(
          data: const MediaQueryData(size: Size(1000, 1024)),
          child: PlayRoom.inProviders(playRoomDoc: await createPlayRoom(store))),
    ));
    await tester.pumpAndSettle();
    expect(find.text(i18n.resultAnnouncementDialogMessage), findsNothing);
  }, skip: true);

  testWidgets('stack widgets when screen size is middle', (tester) async {
    final store = Store(MockFirestoreInstance());
    final humans = [await createUser(store), await createUser(store, uid: user.uid)];

    // デスクトップサイズのスクリーンの場合は、stackされない
    await tester.pumpWidget(testableApp(
      auth: auth,
      store: store,
      home: MediaQuery(
        data: const MediaQueryData(size: Size(1440, 1024)),
        child: PlayRoom.inProviders(
          playRoomDoc: await createPlayRoom(
            store,
            lifeRoad: (await createLifeRoad(store, lifeEvents: lifeEvents)).ref,
            humans: humans.map((el) => el.ref).toList(),
          ),
        ),
      ),
    ));
    await tester.pumpAndSettle(PlayRoomState.showDelay);

    var lifeStages = tester.element(find.byType(LifeStages));
    var lifeStagesAncestor = lifeStages.findAncestorWidgetOfExactType<Stack>();
    expect(find.byWidget(lifeStagesAncestor), findsNothing);
    var diceResult = tester.element(find.byType(DiceResult));
    var diceResultAncestor = diceResult.findAncestorWidgetOfExactType<Stack>();
    expect(find.byWidget(diceResultAncestor), findsNothing);
    var playerAction = tester.element(find.byType(PlayerAction));
    var playerActionAncestor = playerAction.findAncestorWidgetOfExactType<Stack>();
    expect(find.byWidget(playerActionAncestor), findsNothing);

    // デスクトップサイズより小さいスクリーンの場合は、stackする
    await tester.pumpWidget(testableApp(
      home: MediaQuery(
        data: const MediaQueryData(size: Size(1000, 1024)),
        child: PlayRoom.inProviders(
          playRoomDoc: await createPlayRoom(
            store,
            lifeRoad: (await createLifeRoad(store, lifeEvents: lifeEvents)).ref,
            humans: humans.map((el) => el.ref).toList(),
          ),
        ),
      ),
    ));
    await tester.pumpAndSettle(PlayRoomState.showDelay);

    lifeStages = tester.element(find.byType(LifeStages));
    lifeStagesAncestor = lifeStages.findAncestorWidgetOfExactType<Stack>();
    expect(find.byWidget(lifeStagesAncestor), findsOneWidget);

    diceResult = tester.element(find.byType(DiceResult));
    diceResultAncestor = diceResult.findAncestorWidgetOfExactType<Stack>();
    expect(find.byWidget(diceResultAncestor), findsOneWidget);

    playerAction = tester.element(find.byType(PlayerAction));
    playerActionAncestor = playerAction.findAncestorWidgetOfExactType<Stack>();
    expect(find.byWidget(playerActionAncestor), findsOneWidget);
  });
}
