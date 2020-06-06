import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/models/common/human.dart';
import 'package:HumanLifeGame/models/common/human_life.dart';
import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/models/common/life_event_params/start_params.dart';
import 'package:HumanLifeGame/models/common/life_road.dart';
import 'package:HumanLifeGame/models/common/user.dart';
import 'package:HumanLifeGame/models/play_room/life_event_record.dart';
import 'package:HumanLifeGame/models/play_room/play_room.dart';
import 'package:HumanLifeGame/screens/play_room/life_event_records.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../mocks/dice.dart';
import 'helper/widget_build_helper.dart';

Future<void> main() async {
  final i18n = await I18n.load(const Locale('en', 'US'));
  final humans = [const HumanModel(id: 'h1', name: 'foo', order: 0), const HumanModel(id: 'h2', name: 'bar', order: 1)];
  final humanLife = HumanLifeModel(
    title: 'dummy HumanLife',
    author: UserModel(id: 'dummyUserId', name: 'dummyUser', isAnonymous: true),
    lifeRoad: LifeRoadModel(
      lifeStepsOnBoard: LifeRoadModel.createLifeStepsOnBoard(
        LifeRoadModel.dummyLifeEvents(),
      ),
    ),
  );
  final start = LifeEventModel(LifeEventTarget.myself, const StartParams());

  testWidgets("show 'lifeEventRecords'Text", (tester) async {
    final playRoomModel = PlayRoomNotifier(i18n, MockDice(), humanLife, humans);
    for (final orderedHuman in humans) {
      playRoomModel.value.everyLifeEventRecords = [LifeEventRecordModel(i18n, orderedHuman, start)];
    }
    await tester.pumpWidget(testableApp(
      home: ChangeNotifierProvider(create: (_) => playRoomModel, child: const LifeEventRecords()),
    ));
    await tester.pump();

    for (final model in playRoomModel.value.everyLifeEventRecords) {
      expect(find.text(model.lifeEventRecordMessage), findsOneWidget);
    }
  });
}
