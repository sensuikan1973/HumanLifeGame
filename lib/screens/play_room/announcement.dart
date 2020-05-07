import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/play_room/play_room.dart';

class Announcement extends StatelessWidget {
  const Announcement({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final message = context.select<PlayRoomModel, String>((model) => model.announcement.message);
    return SizedBox(
      width: 400,
      height: 50,
      child: Text(
        message,
        key: const Key('announcementMessageText'),
      ),
    );
  }
}
