import '../../api/auth.dart';
import '../../api/firestore/play_room.dart';
import '../../api/firestore/store.dart';
import '../../api/firestore/user.dart';

class LobbyNotifier {
  LobbyNotifier(this._auth, this._store);

  final Auth _auth;
  final Store _store;

  Future<void> createPublicPlayRoom() async {
    final user = await _auth.currentUser;
    final userRef = _store.docRef<User>(user.id).ref;
    final room = PlayRoom(
      host: userRef,
      title: 'はじめての人生',
      humans: [userRef],
      lifeRoad: userRef, // FIXME: null 禁止だからテキトーに入れてるだけで絶対に修正しないとダメ
      everyLifeEventRecords: [],
      lifeStages: [],
      currentTurnHumanId: user.id,
    );
    await _store.collectionRef<PlayRoom>().add(room);
  }
}
