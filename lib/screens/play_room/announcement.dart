import 'package:HumanLifeGame/models/play_room.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Announcement extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SizedBox(
        width: 400,
        height: 50,
        child: Selector<PlayRoomModel, String>(
          selector: (context, model) => model.announcement.message,
          builder: (context, message, child) => Text(message),
        ),
      );
}
