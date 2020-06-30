import 'package:firestore_ref/firestore_ref.dart';

import '../../api/firestore/play_room.dart';

class LobbyState {
  LobbyState();

  List<Document<PlayRoomEntity>> publicPlayRooms = [];
  Document<PlayRoomEntity> haveCreatedPlayRoom;
  Document<PlayRoomEntity> haveJoinedPlayRoom;
}
