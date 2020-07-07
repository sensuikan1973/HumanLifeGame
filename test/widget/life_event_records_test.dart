import 'package:HumanLifeGame/api/firestore/life_event_record.dart';
import 'package:HumanLifeGame/api/firestore/store.dart';
import 'package:HumanLifeGame/human_life_game_app.dart';
import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/models/play_room/play_room_notifier.dart';
import 'package:HumanLifeGame/screens/play_room/life_event_records.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../helper/firestore/life_event_helper.dart';
import '../helper/firestore/play_room_helper.dart';
import '../helper/firestore/user_helper.dart';
import '../mocks/dice.dart';
import 'helper/testable_app.dart';

Future<void> main() async {
  final i18n = await I18n.load(HumanLifeGameApp.defaultLocale);
  testWidgets("show 'lifeEventRecords'Text", (tester) async {
    final store = Store(MockFirestoreInstance());
    final humans = [await createUser(store), await createUser(store)];
    final playRoomNotifier = PlayRoomNotifier(i18n, MockDice(), store, await createPlayRoom(store));
    for (final human in humans) {
      playRoomNotifier.value.everyLifeEventRecords = [LifeEventRecordEntity(human: human.ref, lifeEvent: startEvent)];
    }
    await tester.pumpWidget(testableApp(
      store: store,
      home: ChangeNotifierProvider(create: (_) => playRoomNotifier, child: const LifeEventRecords()),
    ));
    await tester.pump();

    for (final record in playRoomNotifier.value.everyLifeEventRecords) {
      expect(find.text(i18n.lifeStepEventType(record.lifeEvent.type)), findsOneWidget);
    }
  });
}
