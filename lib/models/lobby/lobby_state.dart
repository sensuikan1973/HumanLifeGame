import '../../api/firestore/play_room.dart';
import '../../api/firestore/store.dart';

class LobbyState {
  LobbyState();

  List<Doc<PlayRoomEntity>> publicPlayRooms = [];
  Doc<PlayRoomEntity> haveCreatedPlayRoom;
  Doc<PlayRoomEntity> haveJoinedPlayRoom;
}
