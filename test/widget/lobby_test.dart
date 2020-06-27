import 'dart:math';

import 'package:HumanLifeGame/api/firestore/life_road.dart';
import 'package:HumanLifeGame/api/firestore/play_room.dart';
import 'package:HumanLifeGame/api/firestore/store.dart';
import 'package:HumanLifeGame/api/firestore/user.dart';
import 'package:HumanLifeGame/i18n/i18n.dart';
import 'package:HumanLifeGame/screens/lobby/human_life_tips.dart';
import 'package:HumanLifeGame/screens/lobby/lobby.dart';
import 'package:HumanLifeGame/screens/lobby/room_list_item.dart';
import 'package:HumanLifeGame/screens/play_room/play_room.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

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
  final auth = MockAuth();
  when(auth.currentUser).thenAnswer((_) async => user);

  testWidgets('create public play room', (tester) async {
    final firestore = MockFirestoreInstance();
    final store = Store(firestore);
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
    await tester.pump();
    await tester.pump();
    expect(find.byType(PlayRoom), findsOneWidget); // playRoom に遷移する
  });

  testWidgets('list public play rooms', (tester) async {
    final firestore = MockFirestoreInstance();
    final store = Store(firestore);

    // 自身の user document を投入
    final userDocRef = store.docRef<UserEntity>(user.uid);
    await userDocRef.set(UserEntity(
      uid: user.uid,
      displayName: user.displayName,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ));

    // 見知らぬ他人の user document を投入
    final otherUserDocRef = store.docRef<UserEntity>('aaa');
    await otherUserDocRef.set(UserEntity(
      uid: otherUserDocRef.ref.documentID,
      displayName: 'unknown person',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ));

    // 自身では無い、他人の投稿した room を投入
    const roomNum = 2;
    for (var i = 0; i < roomNum; ++i) {
      final randString = Random().nextInt(1000).toString();
      await store.collectionRef<PlayRoomEntity>().add(PlayRoomEntity(
          host: otherUserDocRef.ref,
          humans: [otherUserDocRef.ref],
          title: randString,
          lifeRoad: store.docRef<LifeRoadEntity>(randString).ref,
          currentTurnHumanId: otherUserDocRef.ref.documentID));
    }

    await tester.pumpWidget(
      testableApp(auth: auth, store: store, home: Lobby.inProviders()),
    );
    await tester.pump();
    await tester.pump();
    expect(find.byType(LifeRoadTips), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byType(RoomListItem), findsNWidgets(roomNum));

    // 複数ある enter button のうち１つをタップする
    await tester.tap(find.text(i18n.lobbyEnterTheRoomButtonText).first);
    await tester.pump();
    await tester.pump();
    expect(find.byType(PlayRoom), findsOneWidget); // playRoom に遷移

    // FIXME: UI 実装したら "Widget" テストするべき
    // NOTE: その前にまず DB チェックのテストだけでもと思ったが、
    // cloud_firestore_mocks で DocumentReference の arrayUnion が機能しないことが分かったので、一旦コメントアウトしてる
    // See: https://github.com/atn832/cloud_firestore_mocks/blob/bc57783b8ae993852e3ad19212fa985c208fd601/lib/src/mock_document_reference.dart#L25
//    final joinedRoom = await store
//        .collectionRef<PlayRoomEntity>()
//        .ref
//        .where(PlayRoomEntityField.humans, arrayContains: userDocRef)
//        .getDocuments();
//    expect(joinedRoom.documents.length, 1);
  });
}
