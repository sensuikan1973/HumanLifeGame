import 'dart:math';

import 'package:HumanLifeGame/api/auth.dart';
import 'package:HumanLifeGame/api/dice.dart';
import 'package:HumanLifeGame/api/firestore/life_road.dart';
import 'package:HumanLifeGame/api/firestore/play_room.dart';
import 'package:HumanLifeGame/api/firestore/store.dart';
import 'package:HumanLifeGame/api/firestore/user.dart';
import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/router.dart';
import 'package:HumanLifeGame/screens/lobby/human_life_tips.dart';
import 'package:HumanLifeGame/screens/lobby/lobby.dart';
import 'package:HumanLifeGame/screens/lobby/room_list_item.dart';
import 'package:HumanLifeGame/screens/play_room/play_room.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../mocks/auth.dart';
import 'helper/widget_build_helper.dart';

Future<void> main() async {
  setUp(() {
    // See: https://github.com/flutter/flutter/issues/12994#issuecomment-397321431
    // Desktopの標準サイズ 1440x1024に設定
    WidgetsBinding.instance.renderView.configuration = TestViewConfiguration(size: const Size(1440, 1024));
  });

  final i18n = await I18n.load(const Locale('en', 'US'));
  final user = MockFirebaseUser();
  when(user.uid).thenReturn('foo');
  when(user.displayName).thenReturn('dummy user');

  testWidgets('create public play room', (tester) async {
    final auth = MockAuth();
    when(auth.currentUser).thenAnswer((_) async => user);
    final firestore = MockFirestoreInstance();
    final store = Store(firestore);
    await tester.pumpWidget(
      testableApp(
        providers: [
          Provider<Router>(create: (_) => const Router()),
          Provider<Dice>(create: (_) => const Dice()),
          Provider<Auth>(create: (_) => auth),
          Provider<Store>(create: (_) => store),
        ],
        home: Lobby.inProviders(),
      ),
    );
    await tester.pump();
    await tester.pump();
    expect(find.byType(HumanLifeTips), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byType(RoomListItem), findsNothing); // room 存在しない

    final createPublicPlayRoomButton = find.byTooltip(i18n.lobbyCreatePublicRoomButtonTooltip);
    expect(createPublicPlayRoomButton, findsOneWidget);

    await tester.tap(createPublicPlayRoomButton); // room が作成される
    await tester.pump();
    await tester.pump();
    expect(find.byType(PlayRoom), findsOneWidget); // playRoom に遷移する
  });

  testWidgets('list public play rooms', (tester) async {
    final auth = MockAuth();
    when(auth.currentUser).thenAnswer((_) async => user);
    final firestore = MockFirestoreInstance();
    final store = Store(firestore);

    // ダミー user を投入
    final userDocRef = store.docRef<UserEntity>(user.uid);
    await userDocRef.set(UserEntity(
      uid: user.uid,
      displayName: user.displayName,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ));

    // ダミー room を投入
    // FIXME: 本当は add で書くべきだが、https://github.com/atn832/cloud_firestore_mocks/pull/99 のバグがあるので set で書いてる
    const roomNum = 2;
    for (var i = 0; i < roomNum; ++i) {
      final randString = Random().nextInt(1000).toString();
      await store.collectionRef<PlayRoomEntity>().docRef().set(PlayRoomEntity(
          host: userDocRef.ref,
          humans: [userDocRef.ref],
          title: randString,
          lifeRoad: store.docRef<LifeRoadEntity>(randString).ref,
          currentTurnHumanId: user.uid));
    }

    await tester.pumpWidget(
      testableApp(
        providers: [
          Provider<Router>(create: (_) => const Router()),
          Provider<Dice>(create: (_) => const Dice()),
          Provider<Auth>(create: (_) => auth),
          Provider<Store>(create: (_) => store),
        ],
        home: Lobby.inProviders(),
      ),
    );
    await tester.pump();
    await tester.pump();
    expect(find.byType(HumanLifeTips), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byType(RoomListItem), findsNWidgets(roomNum)); // ダミーデータの数だけ表示される

    // 複数ある enter button のうち１つをタップする
    await tester.tap(find.text(i18n.lobbyEnterTheRoomButtonText).first);
    await tester.pump();
    await tester.pump();
    expect(find.byType(PlayRoom), findsOneWidget); // playRoom に遷移
  });
}
