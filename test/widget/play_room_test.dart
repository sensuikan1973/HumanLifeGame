import 'package:HumanLifeGame/api/dice.dart';
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
import 'package:HumanLifeGame/screens/play_room/announcement.dart';
import 'package:HumanLifeGame/screens/play_room/dice_result.dart';
import 'package:HumanLifeGame/screens/play_room/life_stages.dart';
import 'package:HumanLifeGame/screens/play_room/play_room.dart';
import 'package:HumanLifeGame/screens/play_room/play_view.dart';
import 'package:HumanLifeGame/screens/play_room/player_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../mocks/mocks.dart';
import 'helper/widget_build_helper.dart';

Future<void> main() async {
  const locale = Locale('en', 'US');
  final i18n = await I18n.load(locale);
  final orderedHumans = [HumanModel(id: 'h1', name: 'foo'), HumanModel(id: 'h2', name: 'bar')];
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
  final humanLife = HumanLifeModel(
    title: 'hello',
    author: UserModel(id: 'user', name: 'hoge'),
    lifeRoad: LifeRoadModel(lifeStepsOnBoard: LifeRoadModel.createLifeStepsOnBoard(lifeEvents)),
  );

  setUp(() {
    // See: https://github.com/flutter/flutter/issues/12994#issuecomment-397321431
    // Desktopの標準サイズ 1440x1024に設定
    WidgetsBinding.instance.renderView.configuration = TestViewConfiguration(size: const Size(1440, 1024));
  });

  testWidgets('show some widgets', (tester) async {
    final playRoomModel = PlayRoomNotifier(i18n, humanLife, orderedHumans: orderedHumans);
    await tester.pumpWidget(_TestablePlayRoom(const Dice(), playRoomModel));
    await tester.pump();
    expect(find.byType(PlayerAction), findsOneWidget);
    expect(find.byType(DiceResult), findsOneWidget);
    expect(find.byType(LifeStages), findsOneWidget);
    expect(find.byType(Announcement), findsOneWidget);
    expect(find.byType(PlayView), findsOneWidget);
  });

  testWidgets('random value(1 <= value <= 6) should be displayed when dice is rolled', (tester) async {
    final dice = MockDice();
    when(dice.roll()).thenReturn(5);
    final playRoomModel = PlayRoomNotifier(i18n, humanLife, orderedHumans: orderedHumans);
    await tester.pumpWidget(_TestablePlayRoom(dice, playRoomModel));
    await tester.pump();

    await tester.tap(find.byKey(const Key('playerActionDiceRollButton')));
    await tester.pump();
    expect(find.text('5'), findsOneWidget);
  });

  testWidgets('show Announcement message when dice is rolled', (tester) async {
    final dice = MockDice();
    const roll = 5;
    when(dice.roll()).thenReturn(roll);
    final playRoomModel = PlayRoomNotifier(i18n, humanLife, orderedHumans: orderedHumans);
    await tester.pumpWidget(_TestablePlayRoom(dice, playRoomModel));
    await tester.pump();

    final rollDiceButton = find.byKey(const Key('playerActionDiceRollButton'));
    await tester.tap(rollDiceButton);
    await tester.pump();
    expect(find.text(i18n.rollAnnouncement(orderedHumans.first.name, roll)), findsOneWidget);

    await tester.tap(rollDiceButton);
    await tester.pump();
    expect(find.text(i18n.rollAnnouncement(orderedHumans[1].name, roll)), findsOneWidget);

    await tester.tap(rollDiceButton);
    await tester.pump();
    expect(find.text(i18n.rollAnnouncement(orderedHumans.first.name, roll)), findsOneWidget);
  });

  testWidgets('show user name in human life stages', (tester) async {
    final playRoomModel = PlayRoomNotifier(i18n, humanLife, orderedHumans: orderedHumans);
    await tester.pumpWidget(_TestablePlayRoom(const Dice(), playRoomModel));
    await tester.pump();
    for (final human in orderedHumans) {
      expect(find.text(human.name), findsOneWidget);
    }
  });

  testWidgets('roll-the-dice button shuld be disabled when all Humans reached the goal', (tester) async {
    final dice = MockDice();
    const roll = 6;
    when(dice.roll()).thenReturn(roll);
    final playRoomModel = PlayRoomNotifier(i18n, humanLife, orderedHumans: orderedHumans);
    await tester.pumpWidget(_TestablePlayRoom(dice, playRoomModel));
    await tester.pump();

    final rollDiceButton = find.byKey(const Key('playerActionDiceRollButton'));

    await tester.tap(rollDiceButton);
    await tester.pump();
    expect(tester.widget<FlatButton>(rollDiceButton).enabled, true);

    await tester.tap(rollDiceButton);
    await tester.pump();
    expect(tester.widget<FlatButton>(rollDiceButton).enabled, false);
  });

  testWidgets('show result dialog', (tester) async {
    final dice = MockDice();
    const roll = 6;
    when(dice.roll()).thenReturn(roll);
    final playRoomModel = PlayRoomNotifier(i18n, humanLife, orderedHumans: orderedHumans);
    await tester.pumpWidget(_TestablePlayRoom(dice, playRoomModel));
    await tester.pump();

    final rollDiceButton = find.byKey(const Key('playerActionDiceRollButton'));
    await tester.tap(rollDiceButton);
    await tester.pump();

    await tester.tap(rollDiceButton);
    await tester.pumpAndSettle();
    expect(find.text(i18n.resultAnnouncementDialogMessage), findsOneWidget);
  });
}

class _TestablePlayRoom extends StatelessWidget {
  const _TestablePlayRoom(this.dice, this.playRoomModel);

  final Dice dice;
  final PlayRoomNotifier playRoomModel;

  @override
  Widget build(BuildContext context) => testableApp(
        home: MultiProvider(
          providers: [
            Provider<Dice>(create: (context) => dice),
            ChangeNotifierProvider<PlayerActionNotifier>(
              create: (context) => PlayerActionNotifier(context.read<Dice>()),
            ),
            ChangeNotifierProxyProvider<PlayerActionNotifier, PlayRoomNotifier>(
              create: (context) => playRoomModel,
              update: (context, playerActionNotifier, playRoomNotifier) =>
                  playRoomNotifier..update(playerActionNotifier),
            )
          ],
          child: const PlayRoom(),
        ),
      );
}
