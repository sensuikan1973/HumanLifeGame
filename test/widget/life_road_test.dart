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
import 'package:HumanLifeGame/screens/common/life_road.dart';
import 'package:HumanLifeGame/screens/common/life_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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
  final lifeRoad = LifeRoadModel(lifeStepsOnBoard: LifeRoadModel.createLifeStepsOnBoard(lifeEvents));

  final humanLife = HumanLifeModel(
    title: 'hello',
    author: UserModel(id: 'user', name: 'hoge'),
    lifeRoad: lifeRoad,
  );
  final lifeRoadSize = Size(150.0 * humanLife.lifeRoad.width, 100.0 * humanLife.lifeRoad.height);
  testWidgets('show LifeSteps', (tester) async {
    final playRoomModel = PlayRoomNotifier(i18n, MockDice(), humanLife, humans);
    await tester.pumpWidget(testableApp(
      home: ChangeNotifierProvider(
          create: (_) => playRoomModel, child: LifeRoad(lifeRoad, lifeRoadSize.width, lifeRoadSize.height)),
    ));
    await tester.pump();

    expect(find.byType(LifeStep), findsNWidgets(lifeEvents.expand((el) => el.where((el) => el != blank)).length));
  });
}
