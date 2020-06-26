import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/firestore/play_room.dart';
import '../../router.dart';

class RoomListItem extends StatelessWidget {
  const RoomListItem(this._playRoom, {Key key}) : super(key: key);

  final Document<PlayRoomEntity> _playRoom;

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
        child: Tooltip(
          message: 'enter the room',
          child: FlatButton(
            color: Colors.lightBlue,
            onPressed: () => Navigator.of(context).pushNamed(context.read<Router>().playRoom),
            child: const Text('enter the room'),
          ),
        ),
      );
}
