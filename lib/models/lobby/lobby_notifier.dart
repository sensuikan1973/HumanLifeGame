import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';

import '../../api/auth.dart';
import '../../api/firestore/life_road.dart';
import '../../api/firestore/play_room.dart';
import '../../api/firestore/store.dart';
import '../../api/firestore/user.dart';
import 'lobby_state.dart';

class LobbyNotifier extends ValueNotifier<LobbyState> {
  LobbyNotifier(this._auth, this._store) : super(LobbyState()) {
    _init();
  }

  final Auth _auth;
  final Store _store;
  final _roomListLimit = 5;

  Future<void> _init() async {
    await _signIn();
    await fetchPlayRooms();
  }

  Future<FirebaseUser> _signIn() async {
    final user = await _auth.currentUser;
    if (user != null) return user;
    if (kDebugMode) return _auth.signInForDebug();
    return _auth.signInAnonymously();
  }

  /// FIXME: 消す。当然 LifeRoad がここで作られることなんてないからね。
  Future<Doc<LifeRoadEntity>> _createLifeRoad() async {
    final user = await _auth.currentUser;
    final userDoc = _store.docRef<UserEntity>(user.uid);
    final lifeRoadCollectionRef = _store.collectionRef<LifeRoadEntity>(userDoc.ref.path);
    final entity = LifeRoadEntity(
      author: userDoc.ref,
      lifeEvents: LifeRoadEntity.dummyLifeEvents(),
      title: 'dummy',
    );
    final docRef = await lifeRoadCollectionRef.add(entity);
    return Doc<LifeRoadEntity>(_store, docRef.ref, entity);
  }

  Future<void> createPublicPlayRoom() async {
    final user = await _auth.currentUser;
    final userDocRef = _store.docRef<UserEntity>(user.uid);
    final room = PlayRoomEntity(
      host: userDocRef.ref,
      title: 'はじめての人生',
      humans: [userDocRef.ref],
      lifeRoad: (await _createLifeRoad()).ref,
      currentTurnHumanId: user.uid,
    );
    final roomDocRef = _store.collectionRef<PlayRoomEntity>().docRef();
    final batch = _store.firestore.batch();
    await roomDocRef.setData(room.encode(), batch: batch);
    await userDocRef.updateData(<String, dynamic>{
      UserEntityField.joinPlayRoom: roomDocRef.ref,
      TimestampField.updatedAt: FieldValue.serverTimestamp(),
    }, batch: batch);
    await batch.commit(); // FIXME: エラーハンドリング. 特に既に join 済みの場合のハンドリング.
    value.haveCreatedPlayRoom = Doc<PlayRoomEntity>(_store, roomDocRef.ref, room);
    notifyListeners();
  }

  Future<void> join(Doc<PlayRoomEntity> playRoomDoc) async {
    final user = await _auth.currentUser;
    final userDocRef = _store.docRef<UserEntity>(user.uid);
    // 既に参加済みの場合
    if (playRoomDoc.entity.humans.contains(userDocRef.ref)) {
      value.haveJoinedPlayRoom = playRoomDoc;
      return notifyListeners();
    }

    final roomDocRef = _store.collectionRef<PlayRoomEntity>().docRef(playRoomDoc.id);
    final batch = _store.firestore.batch();
    await userDocRef.updateData(<String, dynamic>{
      UserEntityField.joinPlayRoom: playRoomDoc.ref,
      TimestampField.updatedAt: FieldValue.serverTimestamp(),
    }, batch: batch);
    await roomDocRef.updateData(<String, dynamic>{
      PlayRoomEntityField.humans: FieldValue.arrayUnion(<DocumentReference>[userDocRef.ref]),
      TimestampField.updatedAt: FieldValue.serverTimestamp(),
    }, batch: batch);
    await batch.commit();
    value.haveJoinedPlayRoom = playRoomDoc;
    notifyListeners();
  }

  Future<void> fetchPlayRooms() async {
    final collectionRef = _store.collectionRef<PlayRoomEntity>();
    value.publicPlayRooms = await collectionRef.getDocuments(
      (query) => query.limit(_roomListLimit).orderBy(TimestampField.createdAt),
    );
    notifyListeners();
  }
}
