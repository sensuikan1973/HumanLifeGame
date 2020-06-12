import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/play_room/play_room_notifier.dart';

class Announcement extends StatelessWidget {
  const Announcement({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final message = context.select<PlayRoomNotifier, String>((model) => model.value.announcement);
    return Card(
      child: Text(
        message,
        key: const Key('announcementMessageText'),
      ),
    );
  }
}
