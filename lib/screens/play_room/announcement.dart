import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/play_room/play_room.dart';

class Announcement extends StatelessWidget {
  const Announcement({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 400,
        height: 50,
        child: Selector<PlayRoomModel, String>(
          selector: (context, model) => model.announcement.message,
          builder: (context, message, child) => Text(
            message,
            key: const Key('announcementMessageText'),
          ),
        ),
      );
}
