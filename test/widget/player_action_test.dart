void main() {}
//import 'package:HumanLifeGame/i18n/i18n.dart';
//import 'package:HumanLifeGame/models/common/human.dart';
//import 'package:HumanLifeGame/models/common/life_event.dart';
//import 'package:HumanLifeGame/models/common/life_event_params/gain_life_items_params.dart';
//import 'package:HumanLifeGame/models/common/life_event_params/goal_params.dart';
//import 'package:HumanLifeGame/models/common/life_event_params/nothing_params.dart';
//import 'package:HumanLifeGame/models/common/life_event_params/select_direction_params.dart';
//import 'package:HumanLifeGame/models/common/life_event_params/start_params.dart';
//import 'package:HumanLifeGame/models/common/life_road.dart';
//import 'package:HumanLifeGame/models/play_room/play_room_notifier.dart';
//import 'package:HumanLifeGame/screens/play_room/player_action.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_test/flutter_test.dart';
//import 'package:mockito/mockito.dart';
//import 'package:provider/provider.dart';
//
//import '../mocks/dice.dart';
//import '../mocks/play_room_state.dart';
//import 'helper/testable_app.dart';
//
//Future<void> main() async {
//  final i18n = await I18n.load(const Locale('en', 'US'));
//  final humans = [const HumanModel(id: 'h1', name: 'foo', order: 0), const HumanModel(id: 'h2', name: 'bar', order: 1)];
//
//  final start = LifeEventModel(LifeEventTarget.myself, const StartParams());
//  final goals = LifeEventModel(LifeEventTarget.myself, const GoalParams());
//  final gains = LifeEventModel(LifeEventTarget.myself, const GainLifeItemsParams(targetItems: []));
//  final blank = LifeEventModel(LifeEventTarget.myself, const NothingParams());
//  final direc = LifeEventModel(LifeEventTarget.myself, const SelectDirectionParams());
//
//  testWidgets("show 'Roll the Dice' text", (tester) async {
//    final lifeEvents = [
//      [start, gains, goals],
//      [blank, blank, blank],
//      [blank, blank, blank],
//    ];
//    final lifeRoad = LifeRoadModel(lifeStepsOnBoard: LifeRoadModel.createLifeStepsOnBoard(lifeEvents));
//    final playRoomNotifier = PlayRoomNotifier(i18n, MockDice(), lifeRoad, humans);
//    await tester.pumpWidget(testableApp(
//      home: ChangeNotifierProvider(create: (_) => playRoomNotifier, child: const PlayerAction()),
//    ));
//    await tester.pump();
//    expect(find.text(i18n.rollDice), findsOneWidget);
//  });
//
//  testWidgets('show selectDirection Button. pattern1: up,right,down', (tester) async {
//    final lifeEvents = [
//      [blank, gains, gains, gains],
//      [blank, gains, blank, gains],
//      [start, direc, gains, goals],
//      [blank, gains, blank, gains],
//      [blank, gains, gains, gains],
//    ];
//    final lifeRoad = LifeRoadModel(lifeStepsOnBoard: LifeRoadModel.createLifeStepsOnBoard(lifeEvents));
//    final state = MockPlayRoomState();
//    final playRoomNotifier = PlayRoomNotifier(i18n, MockDice(), lifeRoad, humans)..value = state;
//    when(state.requireSelectDirection).thenReturn(true);
//    when(state.currentHumanLifeStep).thenReturn(lifeRoad.start.right); // 最初の分岐
//
//    await tester.pumpWidget(testableApp(
//      home: ChangeNotifierProvider(create: (_) => playRoomNotifier, child: const PlayerAction()),
//    ));
//    await tester.pump();
//    final enabledIconButton = find.byWidgetPredicate((widget) => widget is IconButton && widget.onPressed != null);
//    expect(enabledIconButton, findsNWidgets(3));
//  });
//
//  testWidgets('show selectDirection Button. pattern2: left,down', (tester) async {
//    final lifeEvents = [
//      [blank, blank, start],
//      [gains, gains, direc],
//      [goals, blank, gains],
//      [gains, gains, gains],
//    ];
//    final lifeRoad = LifeRoadModel(lifeStepsOnBoard: LifeRoadModel.createLifeStepsOnBoard(lifeEvents));
//    final state = MockPlayRoomState();
//    final playRoomNotifier = PlayRoomNotifier(i18n, MockDice(), lifeRoad, humans)..value = state;
//    when(state.requireSelectDirection).thenReturn(true);
//    when(state.currentHumanLifeStep).thenReturn(lifeRoad.start.down); // 最初の分岐
//
//    await tester.pumpWidget(testableApp(
//      home: ChangeNotifierProvider(create: (_) => playRoomNotifier, child: const PlayerAction()),
//    ));
//    await tester.pump();
//    final enabledIconButton = find.byWidgetPredicate((widget) => widget is IconButton && widget.onPressed != null);
//    expect(enabledIconButton, findsNWidgets(2));
//  });
//}
