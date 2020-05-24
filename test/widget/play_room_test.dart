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

import '../mocks/dice.dart';
import 'helper/widget_build_helper.dart';

Future<void> main() async {
  final i18n = await I18n.load(const Locale('en', 'US'));
  final humans = [HumanModel(id: 'h1', name: 'foo', order: 0), HumanModel(id: 'h2', name: 'bar', order: 1)];
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
    final playRoomModel = PlayRoomNotifier(i18n, MockDice(), humanLife, humans);
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
    const roll = 5;
    when(dice.roll()).thenReturn(roll);
    final playRoomModel = PlayRoomNotifier(i18n, dice, humanLife, humans);
    await tester.pumpWidget(_TestablePlayRoom(dice, playRoomModel));
    await tester.pump();

    await tester.tap(find.byKey(const Key('playerActionDiceRollButton')));
    await tester.pump();
    expect(find.text(roll.toString()), findsOneWidget);
  });

  testWidgets('show Announcement message when dice is rolled', (tester) async {
    final dice = MockDice();
    const roll = 5;
    when(dice.roll()).thenReturn(roll);
    final playRoomModel = PlayRoomNotifier(i18n, dice, humanLife, humans);
    await tester.pumpWidget(_TestablePlayRoom(dice, playRoomModel));
    await tester.pump();

    final rollDiceButton = find.byKey(const Key('playerActionDiceRollButton'));
    await tester.tap(rollDiceButton);
    await tester.pump();
    expect(find.text(i18n.rollAnnouncement(humans.first.name, roll)), findsOneWidget);

    await tester.tap(rollDiceButton);
    await tester.pump();
    expect(find.text(i18n.rollAnnouncement(humans[1].name, roll)), findsOneWidget);

    await tester.tap(rollDiceButton);
    await tester.pump();
    expect(find.text(i18n.rollAnnouncement(humans.first.name, roll)), findsOneWidget);
  });

  testWidgets('roll-the-dice button shuld be disabled when all Humans reached the goal', (tester) async {
    final dice = MockDice();
    const roll = 6;
    when(dice.roll()).thenReturn(roll);
    final playRoomModel = PlayRoomNotifier(i18n, dice, humanLife, humans);
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
    final playRoomModel = PlayRoomNotifier(i18n, dice, humanLife, humans);
    await tester.pumpWidget(_TestablePlayRoom(dice, playRoomModel));
    await tester.pump();

    final rollDiceButton = find.byKey(const Key('playerActionDiceRollButton'));
    await tester.tap(rollDiceButton);
    await tester.pump();

    await tester.tap(rollDiceButton);
    await tester.pumpAndSettle();
    expect(find.text(i18n.resultAnnouncementDialogMessage), findsOneWidget);
  });

  testWidgets('not show dialog after rebuilt', (tester) async {
    final dice = MockDice();
    const roll = 6;
    when(dice.roll()).thenReturn(roll);
    final playRoomModel = PlayRoomNotifier(i18n, dice, humanLife, humans);

    await tester.pumpWidget(_TestablePlayRoom(dice, playRoomModel));
    await tester.pump();

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
    const windowWidth = 1000.0;
    const windowHeight = 1024.0;
    const size = Size(windowWidth, windowHeight);
    await tester.pumpWidget(_TestablePlayRoom(dice, playRoomModel, size: size));
    await tester.pumpAndSettle();
    expect(find.text(i18n.resultAnnouncementDialogMessage), findsNothing);
  });

  testWidgets('stack widgets when screen size is middle', (tester) async {
    final playRoomModel = PlayRoomNotifier(i18n, MockDice(), humanLife, humans);

    // デスクトップサイズのスクリーンの場合は、stackされない
    await tester.pumpWidget(_TestablePlayRoom(const Dice(), playRoomModel));
    await tester.pump();
    var lifeStages = tester.element(find.byType(LifeStages));
    var lifeStagesAnsester = lifeStages.findAncestorWidgetOfExactType<Stack>();
    expect(find.byWidget(lifeStagesAnsester), findsNothing);
    var diceResult = tester.element(find.byType(DiceResult));
    var diceResultAnsester = diceResult.findAncestorWidgetOfExactType<Stack>();
    expect(find.byWidget(diceResultAnsester), findsNothing);
    var playerAction = tester.element(find.byType(PlayerAction));
    var playerActionAnsester = playerAction.findAncestorWidgetOfExactType<Stack>();
    expect(find.byWidget(playerActionAnsester), findsNothing);

    // デスクトップサイズより小さいスクリーンの場合は、stackする
    const windowWidth = 1000.0;
    const windowHeight = 1024.0;
    const size = Size(windowWidth, windowHeight);
    await tester.pumpWidget(_TestablePlayRoom(const Dice(), playRoomModel, size: size));
    await tester.pump();
    lifeStages = tester.element(find.byType(LifeStages));
    lifeStagesAnsester = lifeStages.findAncestorWidgetOfExactType<Stack>();
    expect(find.byWidget(lifeStagesAnsester), findsOneWidget);

    diceResult = tester.element(find.byType(DiceResult));
    diceResultAnsester = diceResult.findAncestorWidgetOfExactType<Stack>();
    expect(find.byWidget(diceResultAnsester), findsOneWidget);

    playerAction = tester.element(find.byType(PlayerAction));
    playerActionAnsester = playerAction.findAncestorWidgetOfExactType<Stack>();
    expect(find.byWidget(playerActionAnsester), findsOneWidget);
  });
}

class _TestablePlayRoom extends StatelessWidget {
  const _TestablePlayRoom(this.dice, this.playRoomModel, {Size size}) : _size = size ?? const Size(1440, 1024);

  final Dice dice;
  final PlayRoomNotifier playRoomModel;
  final Size _size;
  @override
  Widget build(BuildContext context) => testableApp(
        home: MultiProvider(
          providers: [
            Provider<Dice>(create: (context) => dice),
            ChangeNotifierProvider<PlayerActionNotifier>(
              create: (context) => PlayerActionNotifier(context.read<Dice>()),
            ),
            ChangeNotifierProvider<PlayRoomNotifier>(
              create: (context) => playRoomModel,
            )
          ],
          child: MediaQuery(data: MediaQueryData(size: _size), child: const PlayRoom()),
        ),
      );
}
