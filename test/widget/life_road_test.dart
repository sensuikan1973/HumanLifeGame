import 'package:HumanLifeGame/api/firestore/store.dart';
import 'package:HumanLifeGame/human_life_game_app.dart';
import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/models/play_room/play_room_notifier.dart';
import 'package:HumanLifeGame/screens/common/life_road.dart';
import 'package:HumanLifeGame/screens/common/life_step.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../helper/firestore/life_event_helper.dart';
import '../helper/firestore/life_road_helper.dart';
import '../helper/firestore/play_room_helper.dart';
import '../mocks/dice.dart';
import 'helper/testable_app.dart';

Future<void> main() async {
  final i18n = await I18n.load(HumanLifeGameApp.defaultLocale);
  final lifeEvents = [
    [startEvent, gainEvent, gainEvent, gainEvent, gainEvent, gainEvent, goalEvent],
    [blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent],
    [blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent],
    [blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent],
    [blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent],
    [blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent],
    [blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent, blankEvent],
  ];

  testWidgets('show LifeSteps', (tester) async {
    final store = Store(MockFirestoreInstance());
    final lifeRoad = await createLifeRoad(store, lifeEvents: lifeEvents);
    final playRoomNotifier = PlayRoomNotifier(i18n, MockDice(), store, await createPlayRoom(store));
    await tester.pumpWidget(testableApp(
      home: ChangeNotifierProvider(
        create: (_) => playRoomNotifier,
        child: LifeRoad(lifeRoad.entity, Size(150.0 * lifeRoad.entity.width, 100.0 * lifeRoad.entity.height)),
      ),
    ));
    await tester.pump();

    expect(find.byType(LifeStep), findsNWidgets(lifeEvents.expand((el) => el).where((el) => el != blankEvent).length));
  });
}
