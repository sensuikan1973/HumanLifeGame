import 'package:HumanLifeGame/api/firestore/play_room.dart';
import 'package:HumanLifeGame/api/firestore/store.dart';
import 'package:HumanLifeGame/human_life_game_app.dart';
import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/screens/lobby/human_life_tips.dart';
import 'package:HumanLifeGame/screens/lobby/lobby.dart';
import 'package:HumanLifeGame/screens/lobby/room_list_item.dart';
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

  testWidgets('create public play room', (tester) async {
    final store = Store(MockFirestoreInstance());
    await createUser(store, uid: user.uid);
    await tester.pumpWidget(
      testableApp(auth: auth, store: store, home: Lobby.inProviders()),
    );
    await tester.pump();
    await tester.pump();
    expect(find.byType(LifeRoadTips), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byType(RoomListItem), findsNothing); // room 存在しない

    final createPublicPlayRoomButton = find.byTooltip(i18n.lobbyCreatePublicRoomButtonTooltip);
    expect(createPublicPlayRoomButton, findsOneWidget);

    await tester.tap(createPublicPlayRoomButton); // room が作成される
    await tester.pumpAndSettle(PlayRoomState.showDelay);
    expect(find.byType(PlayRoom), findsOneWidget); // playRoom に遷移する
  });

  testWidgets('join the public play rooms which myself hosts', (tester) async {
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
    expect(find.byType(LifeRoadTips), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byType(RoomListItem), findsOneWidget);
    expect(find.text(user.uid), findsOneWidget); // 参加者としてテキストが表示されてる

    // playRoom に遷移
    await tester.tap(find.text(i18n.lobbyEnterTheRoomButtonText).first);
    await tester.pumpAndSettle(PlayRoomState.showDelay);
    expect(find.byType(PlayRoom), findsOneWidget); // playRoom に遷移

    // TODO: 遷移後に humans の表示だけ test しておきたい
    // ただし、cloud_firestore_mocks で DocumentReference の arrayUnion が機能しないのが辛い
    // See: https://github.com/atn832/cloud_firestore_mocks/issues/106
  });

  testWidgets('join the public play rooms which other hosts', (tester) async {
    final store = Store(MockFirestoreInstance());

//    final userDoc = await createUser(store, uid: user.uid);

    // 見知らぬ他人の user document を投入
    final otherUserDoc = await createUser(store);
    // 他人が作成した playRoom
    await store.collectionRef<PlayRoomEntity>().add(
          PlayRoomEntity(
              host: otherUserDoc.ref,
              humans: [otherUserDoc.ref],
              lifeRoad: (await createLifeRoad(store)).ref,
              currentTurnHumanId: otherUserDoc.entity.uid),
        );

    await tester.pumpWidget(
      testableApp(auth: auth, store: store, home: Lobby.inProviders()),
    );
    await tester.pump();
    await tester.pump();
    expect(find.byType(LifeRoadTips), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byType(RoomListItem), findsOneWidget);
    expect(find.text(otherUserDoc.entity.uid), findsOneWidget); // 参加者としてテキストが表示されてる

    // playRoom に遷移
    await tester.tap(find.text(i18n.lobbyEnterTheRoomButtonText).first);
    await tester.pumpAndSettle(PlayRoomState.showDelay);
    expect(find.byType(PlayRoom), findsOneWidget); // playRoom に遷移

    // TODO: 遷移後に humans の表示だけ test しておきたい
    // ただし、cloud_firestore_mocks で DocumentReference の arrayUnion が機能しないのが辛い
    // See: https://github.com/atn832/cloud_firestore_mocks/issues/106
  });

  testWidgets('list play rooms', (tester) async {
    final store = Store(MockFirestoreInstance());
    const roomNum = 3;
    for (var i = 0; i < roomNum; ++i) {
      final userDoc = await createUser(store);
      await store.collectionRef<PlayRoomEntity>().add(
            PlayRoomEntity(
                host: userDoc.ref,
                humans: [userDoc.ref],
                title: 'life_$i',
                lifeRoad: (await createLifeRoad(store)).ref,
                currentTurnHumanId: userDoc.entity.uid),
          );
    }

    await tester.pumpWidget(
      testableApp(auth: auth, store: store, home: Lobby.inProviders()),
    );
    await tester.pumpAndSettle(PlayRoomState.showDelay);
    expect(find.byType(LifeRoadTips), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byType(RoomListItem), findsNWidgets(roomNum));
  });
}
