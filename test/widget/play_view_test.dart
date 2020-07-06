void main() {}
//import 'package:HumanLifeGame/i18n/i18n.dart';
//import 'package:HumanLifeGame/models/common/human.dart';
//import 'package:HumanLifeGame/models/common/life_event.dart';
//import 'package:HumanLifeGame/models/common/life_event_params/gain_life_items_params.dart';
//import 'package:HumanLifeGame/models/common/life_event_params/goal_params.dart';
//import 'package:HumanLifeGame/models/common/life_event_params/nothing_params.dart';
//import 'package:HumanLifeGame/models/common/life_event_params/start_params.dart';
//import 'package:HumanLifeGame/models/common/life_road.dart';
//import 'package:HumanLifeGame/models/play_room/play_room_notifier.dart';
//import 'package:HumanLifeGame/screens/common/life_step_entity.dart';
//import 'package:HumanLifeGame/screens/play_room/play_view.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_test/flutter_test.dart';
//import 'package:provider/provider.dart';
//
//import '../mocks/dice.dart';
//import 'helper/testable_app.dart';
//
//Future<void> main() async {
//  final i18n = await I18n.load(const Locale('en', 'US'));
//  final dice = MockDice();
//  final humans = [const HumanModel(id: 'h1', name: 'foo', order: 0), const HumanModel(id: 'h2', name: 'bar', order: 1)];
//  final start = LifeEventModel(LifeEventTarget.myself, const StartParams());
//  final goals = LifeEventModel(LifeEventTarget.myself, const GoalParams());
//  final gains = LifeEventModel(LifeEventTarget.myself, const GainLifeItemsParams(targetItems: []));
//  final blank = LifeEventModel(LifeEventTarget.myself, const NothingParams());
//  final lifeEvents = [
//    [start, gains, gains, gains, gains, gains, goals],
//    [blank, blank, blank, blank, blank, blank, blank],
//    [blank, blank, blank, blank, blank, blank, blank],
//    [blank, blank, blank, blank, blank, blank, blank],
//    [blank, blank, blank, blank, blank, blank, blank],
//    [blank, blank, blank, blank, blank, blank, blank],
//    [blank, blank, blank, blank, blank, blank, blank],
//  ];
//  final lifeRoad = LifeRoadModel(lifeStepsOnBoard: LifeRoadModel.createLifeStepsOnBoard(lifeEvents));
//
//  testWidgets('show LifeSteps, display size = (1440, 1024)', (tester) async {
//    const windowWidth = 1440.0;
//    const windowHeight = 1024.0;
//    const size = Size(windowWidth, windowHeight);
//    final playRoomModel = PlayRoomNotifier(i18n, dice, lifeRoad, humans);
//
//    await tester.pumpWidget(
//      testableApp(
//        home: ChangeNotifierProvider(
//          create: (_) => playRoomModel,
//          child: const MediaQuery(data: MediaQueryData(size: size), child: PlayView()),
//        ),
//      ),
//    );
//    await tester.pump();
//
//    expect(find.byType(LifeStep), findsNWidgets(lifeEvents.expand((el) => el.where((el) => el != blank)).length));
//  });
//  testWidgets('show LifeSteps, display size = (1050, 750)', (tester) async {
//    const windowWidth = 1050.0;
//    const windowHeight = 750.0;
//    const size = Size(windowWidth, windowHeight);
//    final playRoomModel = PlayRoomNotifier(i18n, dice, lifeRoad, humans);
//
//    await tester.pumpWidget(
//      testableApp(
//        home: ChangeNotifierProvider(
//          create: (_) => playRoomModel,
//          child: const MediaQuery(
//            data: MediaQueryData(size: size),
//            child: PlayView(),
//          ),
//        ),
//      ),
//    );
//    await tester.pump();
//
//    expect(find.byType(LifeStep), findsNWidgets(lifeEvents.expand((el) => el.where((el) => el != blank)).length));
//  });
//}
