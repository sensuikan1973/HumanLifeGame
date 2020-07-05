import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/firestore/play_room.dart';
import '../../api/firestore/store.dart';
import '../../i18n/i18n.dart';
import '../../models/lobby/lobby_notifier.dart';
import '../../router.dart';
import '../play_room/play_room.dart';

class RoomListItem extends StatelessWidget {
  const RoomListItem(this._playRoom, {Key key}) : super(key: key);

  final Doc<PlayRoomEntity> _playRoom;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          _roomTitle(),
          Row(
            children: [
              _preview(),
              Column(
                children: [
                  _humans(),
                  _joinButton(context),
                ],
              ),
            ],
          ),
        ],
      );

  SizedBox _roomTitle() => SizedBox(
        width: 720,
        height: 40,
        child: ColoredBox(
          color: Colors.grey[100],
          child: Text(_playRoom.entity.title),
        ),
      );

  SizedBox _preview() => SizedBox(
        width: 300,
        height: 200,
        child: Image.asset('images/play_view_background.jpg', fit: BoxFit.fitHeight),
      );

  SizedBox _humans() => SizedBox(
        width: 420,
        height: 170,
        child: Column(
          children: [
            for (final humanId in _playRoom.entity.humanIds) Text(humanId),
          ],
        ),
      );

  SizedBox _joinButton(BuildContext context) => SizedBox(
        width: 420,
        height: 40,
        child: FlatButton(
          color: Colors.lightBlue,
          onPressed: () async {
            final notifier = context.read<LobbyNotifier>();
            await notifier.join(_playRoom);
            await Navigator.of(context).pushNamed(
              context.read<Router>().playRoom,
              arguments: PlayRoomNavigateArguments(notifier.value.haveJoinedPlayRoom),
            );
          },
          child: Text(I18n.of(context).lobbyEnterTheRoomButtonText),
        ),
      );
}
