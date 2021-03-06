import 'package:HumanLifeGame/api/firestore/play_room.dart';
import 'package:HumanLifeGame/api/firestore/store.dart';
import 'package:HumanLifeGame/human_life_game_app.dart';
import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/screens/lobby/lobby.dart';
import 'package:HumanLifeGame/screens/play_room/play_room.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helper/firestore/life_road_helper.dart';
import '../helper/firestore/user_helper.dart';
import '../mocks/auth.dart';
import 'helper/testable_app.dart';

Future<void> main() async {
  setUp(() {
    // See: https://github.com/flutter/flutter/issues/12994#issuecomment-397321431
    // Desktopの標準サイズ 1440x1024に設定
    WidgetsBinding.instance.renderView.configuration = TestViewConfiguration(size: const Size(1440, 1024));
  });

  final i18n = await I18n.load(HumanLifeGameApp.defaultLocale);
  final user = MockFirebaseUser();
  final auth = MockAuth(user);

  testWidgets('make a room', (tester) async {
    final store = Store(MockFirestoreInstance());
    await createUser(store, uid: user.uid);
    await tester.pumpWidget(
      testableApp(auth: auth, store: store, home: Lobby.inProviders()),
    );
    await tester.pump();
    await tester.pump();

    expect(find.byType(RaisedButton), findsNWidgets(2));
    final makeRoomButton = find.text(i18n.makeRoomButtonText);
    expect(makeRoomButton, findsOneWidget);

    await tester.tap(makeRoomButton); // room が作成される
    await tester.pumpAndSettle(PlayRoomState.showDelay);
    expect(find.byType(PlayRoom), findsOneWidget); // playRoom に遷移する
  });

  testWidgets('join a room button is displayed', (tester) async {
    final store = Store(MockFirestoreInstance());
    final userDoc = await createUser(store, uid: user.uid);
    // playRoom を作成
    await store.collectionRef<PlayRoomEntity>().add(
          PlayRoomEntity(
              host: userDoc.ref,
              humans: [userDoc.ref],
              lifeRoad: (await createLifeRoad(store)).ref,
              currentTurnHumanId: user.uid),
        );

    await tester.pumpWidget(
      testableApp(auth: auth, store: store, home: Lobby.inProviders()),
    );
    await tester.pump();
    await tester.pump();

    final joinRoomButton = find.text(i18n.joinRoomButtonText);
    expect(joinRoomButton, findsOneWidget);
  });
}
