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
import 'package:HumanLifeGame/screens/common/life_step.dart';
import 'package:HumanLifeGame/screens/play_room/play_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'helper/widget_build_helper.dart';

Future<void> main() async {
  final i18n = await I18n.load(const Locale('en', 'US'));
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

  testWidgets('show LifeSteps, display size = (1440, 1024)', (tester) async {
    WidgetsBinding.instance.renderView.configuration = TestViewConfiguration(size: const Size(1440, 1024));
    final playRoomModel = PlayRoomNotifier(i18n, humanLife, orderedHumans: orderedHumans);
    await tester.pumpWidget(testableApp(
      home: ChangeNotifierProvider(create: (_) => playRoomModel, child: const PlayView()),
    ));
    await tester.pump();
    expect(find.byType(LifeStep), findsNWidgets(lifeEvents.length * lifeEvents.first.length));
  });
  testWidgets('show LifeSteps, display size = (1050, 750)', (tester) async {
    WidgetsBinding.instance.renderView.configuration = TestViewConfiguration(size: const Size(1050, 750));
    final playRoomModel = PlayRoomNotifier(i18n, humanLife, orderedHumans: orderedHumans);
    await tester.pumpWidget(testableApp(
      home: ChangeNotifierProvider(create: (_) => playRoomModel, child: const PlayView()),
    ));
    await tester.pump();
    expect(find.byType(LifeStep), findsNWidgets(lifeEvents.length * lifeEvents.first.length));
  });
}
