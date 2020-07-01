import 'package:HumanLifeGame/api/firestore/store.dart';
import 'package:HumanLifeGame/human_life_game_app.dart';
import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/models/common/human.dart';
import 'package:HumanLifeGame/models/common/life_event.dart';
import 'package:HumanLifeGame/models/common/life_event_params/start_params.dart';
import 'package:HumanLifeGame/models/play_room/life_event_record.dart';
import 'package:HumanLifeGame/models/play_room/play_room_notifier.dart';
import 'package:HumanLifeGame/screens/play_room/life_event_records.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../mocks/dice.dart';
import 'helper/firestore/play_room_helper.dart';
import 'helper/testable_app.dart';

// FIXME:
Future<void> main() async {
  final i18n = await I18n.load(HumanLifeGameApp.defaultLocale);
  final humans = [const HumanModel(id: 'h1', name: 'foo', order: 0), const HumanModel(id: 'h2', name: 'bar', order: 1)];
  final start = LifeEventModel(LifeEventTarget.myself, const StartParams());

  testWidgets("show 'lifeEventRecords'Text", (tester) async {
    final firestore = MockFirestoreInstance();
    final store = Store(firestore);
    final playRoomNotifier = PlayRoomNotifier(i18n, MockDice(), await createPlayRoom(store));
    for (final orderedHuman in humans) {
      playRoomNotifier.value.everyLifeEventRecords = [LifeEventRecordModel(i18n, orderedHuman, start)];
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
