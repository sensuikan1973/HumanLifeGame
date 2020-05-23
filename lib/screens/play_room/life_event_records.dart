import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../i18n/i18n.dart';
import '../../models/play_room/life_event_record.dart';
import '../../models/play_room/play_room.dart';

class LifeEventRecords extends StatelessWidget {
  const LifeEventRecords({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final everylifeEventRecords =
        context.select<PlayRoomNotifier, List<LifeEventRecodeModel>>((model) => model.everyLifeEventRecords);

    return Card(
      child: ListView(
        reverse: true,
        children: [
          for (var model in everylifeEventRecords)
            Text('${model.human.name} : ${I18n.of(context).lifeStepEventType(model.lifeEventRecord.type)}'),
        ],
      ),
    );
  }
}
