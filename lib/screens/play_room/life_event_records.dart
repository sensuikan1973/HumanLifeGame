import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../i18n/i18n.dart';
import '../../models/play_room/play_room.dart';

class LifeEventRecords extends StatelessWidget {
  const LifeEventRecords({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final everylifeEventRecords =context.select<PlayRoomNotifier, List<LifeEventModel>>((model) => model.everyLifeEventRecords);
    final everylifeEventRecords = context.watch<PlayRoomNotifier>().everyLifeEventRecords;
    return Card(
      child: ListView(
        reverse: true,
        children: [
          for (var lifeEventRecode in everylifeEventRecords)
            Text(
              I18n.of(context).lifeStepEventType(lifeEventRecode.type),
            ),
        ],
      ),
    );
  }
}
