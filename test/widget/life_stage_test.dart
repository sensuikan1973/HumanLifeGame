import 'package:HumanLifeGame/api/firestore/life_item.dart';
import 'package:HumanLifeGame/api/firestore/store.dart';
import 'package:HumanLifeGame/api/firestore/user.dart';
import 'package:HumanLifeGame/entities/life_item_type.dart';
import 'package:HumanLifeGame/human_life_game_app.dart';
import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/models/play_room/play_room_notifier.dart';
import 'package:HumanLifeGame/screens/common/human.dart';
import 'package:HumanLifeGame/screens/play_room/life_stages.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../helper/firestore/play_room_helper.dart';
import '../mocks/dice.dart';
import 'helper/testable_app.dart';

Future<void> main() async {
  final i18n = await I18n.load(HumanLifeGameApp.defaultLocale);
  final dice = MockDice();

  testWidgets('show initial total moneys', (tester) async {
    final store = Store(MockFirestoreInstance());
    final playRoomNotifier = PlayRoomNotifier(i18n, dice, store, await createPlayRoom(store));
    await playRoomNotifier.init();
    await tester.pumpWidget(testableApp(
      home: ChangeNotifierProvider(create: (_) => playRoomNotifier, child: const LifeStages()),
    ));
    await tester.pump();
    expect(find.text('0'), findsNWidgets(playRoomNotifier.value.lifeStages.length));
  });

  testWidgets('show variable total moneys', (tester) async {
    final store = Store(MockFirestoreInstance());
    final playRoomNotifier = PlayRoomNotifier(i18n, dice, store, await createPlayRoom(store));
    await playRoomNotifier.init();
    for (final lifeStage in playRoomNotifier.value.lifeStages) {
      lifeStage.lifeItems.add(const LifeItemEntity(key: 'key', type: LifeItemType.money, amount: 200));
    }
    await tester.pumpWidget(testableApp(
      home: ChangeNotifierProvider(create: (_) => playRoomNotifier, child: const LifeStages()),
    ));
    await tester.pump();
    expect(find.text('200'), findsNWidgets(playRoomNotifier.value.lifeStages.length));
  });

  testWidgets('show current human', (tester) async {
    final store = Store(MockFirestoreInstance());
    final playRoomNotifier = PlayRoomNotifier(i18n, dice, store, await createPlayRoom(store));
    await playRoomNotifier.init();
    await tester.pumpWidget(testableApp(
      home: ChangeNotifierProvider(create: (_) => playRoomNotifier, child: const LifeStages()),
    ));
    await tester.pump();
    final currentHumanSelector = find.byIcon(Icons.chevron_right);
    final row = tester.element(currentHumanSelector).findAncestorWidgetOfExactType<Row>();
    final currentHumanNameText = find.text(playRoomNotifier.value.currentTurnHuman.entity.displayName);
    expect(row.children, contains(currentHumanNameText.evaluate().first.widget));
  });

  testWidgets('show user name', (tester) async {
    final store = Store(MockFirestoreInstance());
    final playRoom = await createPlayRoom(store);
    final playRoomNotifier = PlayRoomNotifier(i18n, dice, store, playRoom);
    await playRoomNotifier.init();
    await tester.pumpWidget(testableApp(
      home: ChangeNotifierProvider(create: (_) => playRoomNotifier, child: const LifeStages()),
    ));
    await tester.pump();
    for (final ref in playRoom.entity.humans) {
      final human = await store.docRef<UserEntity>(ref.documentID).get();
      expect(find.text(human.entity.displayName), findsOneWidget);
    }
  });

  testWidgets('show human icons', (tester) async {
    final store = Store(MockFirestoreInstance());
    final playRoom = await createPlayRoom(store);
    final playRoomNotifier = PlayRoomNotifier(i18n, dice, store, playRoom);
    await playRoomNotifier.init();
    await tester.pumpWidget(testableApp(
      home: ChangeNotifierProvider(create: (_) => playRoomNotifier, child: const LifeStages()),
    ));
    await tester.pump();

    for (var i = 0; i < playRoom.entity.humans.length; ++i) {
      expect(find.byWidget(Human.orderedIcon[i]), findsOneWidget);
    }
  });
}
