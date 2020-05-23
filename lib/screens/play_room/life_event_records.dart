import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/play_room/life_event_record.dart';
import '../../models/play_room/play_room.dart';

class LifeEventRecords extends StatelessWidget {
  const LifeEventRecords({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final everylifeEventRecords =
        context.select<PlayRoomNotifier, List<LifeEventRecordModel>>((model) => model.everyLifeEventRecords);

    return Card(
      child: ListView(
        reverse: true,
        children: [
          for (final model in everylifeEventRecords) Text(model.lifeEventRecordMessage),
        ],
      ),
    );
  }
}
