import 'package:HumanLifeGame/api/firestore/store.dart';
import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/models/common/life_event_params/gain_life_items_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/goal_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/nothing_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/start_params.dart';
import 'package:HumanLifeGame/models/common/life_road.dart';
import 'package:HumanLifeGame/models/play_room/play_room_notifier.dart';
import 'package:HumanLifeGame/screens/common/life_road.dart';
import 'package:HumanLifeGame/screens/common/life_step.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../mocks/dice.dart';
import 'helper/firestore/play_room_helper.dart';
import 'helper/testable_app.dart';

// FIXME:
Future<void> main() async {
  final i18n = await I18n.load(const Locale('en', 'US'));
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
  final lifeRoadSize = Size(150.0 * lifeRoad.width, 100.0 * lifeRoad.height);

  testWidgets('show LifeSteps', (tester) async {
    final firestore = MockFirestoreInstance();
    final store = Store(firestore);
    final playRoomNotifier = PlayRoomNotifier(i18n, MockDice(), await createPlayRoom(store));
    await tester.pumpWidget(testableApp(
      home: ChangeNotifierProvider(
        create: (_) => playRoomNotifier,
        child: LifeRoad(lifeRoad, lifeRoadSize.width, lifeRoadSize.height),
      ),
    ));
    await tester.pump();

    expect(find.byType(LifeStep), findsNWidgets(lifeEvents.expand((el) => el).where((el) => el != blank).length));
  });
}
