import 'package:HumanLifeGame/api/firestore/life_event.dart';
import 'package:HumanLifeGame/api/firestore/store.dart';
import 'package:HumanLifeGame/human_life_game_app.dart';
import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/models/common/life_event_params/life_event_params.dart';
import 'package:HumanLifeGame/models/common/life_event_params/start_params.dart';
import 'package:HumanLifeGame/models/play_room/life_event_record.dart';
import 'package:HumanLifeGame/models/play_room/play_room_notifier.dart';
import 'package:HumanLifeGame/screens/play_room/life_event_records.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../helper/firestore/play_room_helper.dart';
import '../helper/firestore/user_helper.dart';
import '../mocks/dice.dart';
import 'helper/testable_app.dart';

// FIXME:
Future<void> main() async {
  final i18n = await I18n.load(HumanLifeGameApp.defaultLocale);
  const start = LifeEventEntity<StartParams>(
    target: LifeEventTarget.myself,
    type: LifeEventType.start,
    params: StartParams(),
  );

  testWidgets("show 'lifeEventRecords'Text", (tester) async {
    final firestore = MockFirestoreInstance();
    final store = Store(firestore);
    final humans = [await createUser(store), await createUser(store)];
    final playRoomNotifier = PlayRoomNotifier(i18n, MockDice(), await createPlayRoom(store));
    for (final human in humans) {
      playRoomNotifier.value.everyLifeEventRecords = [LifeEventRecordModel(i18n, human, start)];
    }
    await tester.pumpWidget(testableApp(
      store: store,
      home: ChangeNotifierProvider(create: (_) => playRoomNotifier, child: const LifeEventRecords()),
    ));
    await tester.pump();

    for (final model in playRoomNotifier.value.everyLifeEventRecords) {
      expect(find.text(model.lifeEventRecordMessage), findsOneWidget);
    }
  });
}
