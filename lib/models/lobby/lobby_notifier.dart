import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';

import '../../api/auth.dart';
import '../../api/firestore/life_road.dart';
import '../../api/firestore/play_room.dart';
import '../../api/firestore/store.dart';
import '../../api/firestore/user.dart';
import '../play_room/play_room_notifier.dart';
import 'lobby_state.dart';

class LobbyNotifier extends ValueNotifier<LobbyState> {
  LobbyNotifier(this._auth, this._store) : super(LobbyState()) {
    _init();
  }

  final Auth _auth;
  final Store _store;

  final _roomListLimit = 5;

  Future<void> _init() async {
    await _signIn(_auth);
    await fetchPlayRooms();
  }

  Future<FirebaseUser> _signIn(Auth auth) async {
    final user = await auth.currentUser;
    if (user != null) return user;
    if (kDebugMode) return auth.signInForDebug();
    return auth.signInAnonymously();
  }

  Future<void> createPublicPlayRoom() async {
    final user = await _auth.currentUser;
    final userDocRef = _store.docRef<UserEntity>(user.uid);
    final room = PlayRoomEntity(
      host: userDocRef.ref,
      title: 'はじめての人生',
      humans: [userDocRef.ref],
      // FIXME: 本当に存在する lifeRoad を参照するように
      lifeRoad: _store.docRef<LifeRoadEntity>('FIXME').ref,
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
    value.navigateArgumentsToPlayRoom = PlayRoomNotifierArguments(
      Document<PlayRoomEntity>(roomDocRef.ref, room),
    );
    notifyListeners();
  }

  Future<void> join(Document<PlayRoomEntity> playRoomDoc) async {
    final user = await _auth.currentUser;
    final userDocRef = _store.docRef<UserEntity>(user.uid);
    // 既に参加済みの場合は何もしない
    if (playRoomDoc.entity.humans.contains(userDocRef.ref)) return notifyListeners();

    final roomDocRef = _store.collectionRef<PlayRoomEntity>().docRef(playRoomDoc.id);
    final batch = _store.firestore.batch();
    await userDocRef.updateData(<String, dynamic>{
      UserEntityField.joinPlayRoom: playRoomDoc.ref,
      TimestampField.updatedAt: FieldValue.serverTimestamp(),
    }, batch: batch);
    await roomDocRef.updateData(<String, dynamic>{
      PlayRoomEntityField.humans: FieldValue.arrayUnion(<dynamic>[userDocRef.ref]),
      TimestampField.updatedAt: FieldValue.serverTimestamp(),
    }, batch: batch);
    await batch.commit();
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
