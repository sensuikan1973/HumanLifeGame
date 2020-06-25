import 'package:firestore_ref/firestore_ref.dart';

import '../../api/firestore/play_room.dart';
import '../play_room/play_room_notifier.dart';

class LobbyState {
  LobbyState();

  List<Document<PlayRoomEntity>> publicPlayRooms = [];

  PlayRoomNotifierArguments navigateArgumentsToPlayRoom;
}
